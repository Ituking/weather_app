import { expect } from 'chai';
import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
import firebaseFunctionsTest from 'firebase-functions-test';
import * as sinon from 'sinon';

import { getWeatherForCity } from '../src/weather_controller';
import * as weatherService from '../src/weather_service';

const testEnv = firebaseFunctionsTest();

describe('getWeatherForCityの動作検証 (Cloud Functions)', () => {
  let fetchWeatherStub: sinon.SinonStub;
  let saveWeatherStub: sinon.SinonStub;
  let getStub: sinon.SinonStub;
  let wrapped: any;

  beforeEach(() => {
    wrapped = testEnv.wrap(getWeatherForCity);

    fetchWeatherStub = sinon
      .stub(weatherService, 'fetchWeatherFromAPI')
      .resolves({
        city: 'Tokyo',
        temperature: 8.98,
        humidity: 27,
        windSpeed: 9.77,
        description: '雲',
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
      });

    saveWeatherStub = sinon
      .stub(weatherService, 'saveWeatherToFirestore')
      .resolves();

    // Firestoreのモック
    const collectionStub = sinon.stub();
    const docStub = sinon.stub();
    const forecastsCollectionStub = sinon.stub();
    const orderByStub = sinon.stub();
    const limitStub = sinon.stub();
    getStub = sinon.stub();

    collectionStub.withArgs('weather').returns({ doc: docStub });
    docStub.withArgs('Tokyo').returns({ collection: forecastsCollectionStub });
    forecastsCollectionStub
      .withArgs('forecasts')
      .returns({ orderBy: orderByStub });
    orderByStub.withArgs('timestamp', 'desc').returns({ limit: limitStub });
    limitStub.withArgs(1).returns({ get: getStub });

    sinon.stub(admin.firestore(), 'collection').callsFake(collectionStub);
  });

  afterEach(() => {
    sinon.restore();
  });

  after(() => {
    testEnv.cleanup();
  });

  it('Firestoreにデータがある場合、APIを呼ばずにデータを返す', async () => {
    getStub.resolves({
      empty: false,
      docs: [
        {
          data: () => ({
            city: 'Tokyo',
            temperature: 8.98,
            humidity: 27,
            windSpeed: 9.77,
            description: '雲',
          }),
        },
      ],
    } as any);

    const result = await wrapped({ data: { city: 'Tokyo' } });

    expect(result).to.deep.include({
      city: 'Tokyo',
      temperature: 8.98,
      humidity: 27,
      windSpeed: 9.77,
      description: '雲',
    });
    expect(fetchWeatherStub.called).to.be.false;
  });

  it('Firestoreにデータがない場合、APIから取得して保存する', async () => {
    getStub.resolves({ empty: true, docs: [] } as any);

    const mockRequest = {
      data: { city: 'Tokyo' },
      rawRequest: {},
      auth: null,
    } as unknown as functions.https.CallableRequest<any>;
    const result = await wrapped(mockRequest);

    expect(fetchWeatherStub.calledOnce).to.be.true;
    expect(saveWeatherStub.calledOnce).to.be.true;
    expect(result).to.deep.include({
      city: 'Tokyo',
      temperature: 8.98,
      humidity: 27,
      windSpeed: 9.77,
      description: '雲',
    });
  });
});
