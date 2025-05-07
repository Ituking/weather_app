import { assert, expect } from "chai";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import firebaseFunctionsTest from "firebase-functions-test";
import { WrappedV2CallableFunction } from "firebase-functions-test/lib/v2";
import * as sinon from "sinon";

if (!admin.apps.length) {
  admin.initializeApp();
}

import { getWeatherForCity } from "../../src/controllers/weather_controller";
import * as weatherService from "../../src/services/weather_service";

const testEnv = firebaseFunctionsTest();

type WeatherData = {
  city: string;
  temperature: number;
  humidity: number;
  windSpeed: number;
  description: string;
  icon: string;
  timestamp: number;
};

describe("getWeatherForCityの動作検証 (Cloud Functions)", () => {
  let fetchWeatherStub: sinon.SinonStub;
  let saveWeatherStub: sinon.SinonStub;
  let getStub: sinon.SinonStub;
  let wrapped: WrappedV2CallableFunction<Promise<{ current: WeatherData; forecast: WeatherData[] }>>;

  beforeEach(() => {
    wrapped = testEnv.wrap(getWeatherForCity) as WrappedV2CallableFunction<Promise<{ current: WeatherData; forecast: WeatherData[] }>>;


    fetchWeatherStub = sinon
      .stub(weatherService, "fetchWeatherFromAPI")
      .resolves({
        current: {
          city: "Tokyo",
          temperature: 8.98,
          humidity: 27,
          windSpeed: 9.77,
          description: "雲",
          icon: "04d",
          timestamp: Math.floor(Date.now() / 1000),
        },
        forecast: [],
      });


    saveWeatherStub = sinon
      .stub(weatherService, "saveWeatherToFirestore")
      .resolves();

    // Firestoreのモック
    const collectionStub = sinon.stub();
    const docStub = sinon.stub();
    const currentDocStub = sinon.stub();
    const forecastOrderByStub = sinon.stub();
    getStub = sinon.stub();

    collectionStub.withArgs("weather").returns({ doc: docStub });

    docStub.withArgs("Tokyo").returns({
      collection: (subName: string) => {
        if (subName === "current") return { doc: currentDocStub };
        if (subName === "forecast") return { orderBy: forecastOrderByStub };
        return {};
      },
    });

    currentDocStub.withArgs("data").returns({ get: getStub });

    forecastOrderByStub.withArgs("timestamp").returns({
      get: sinon.stub().resolves({ docs: [] }),
    });

    sinon.stub(admin.firestore(), "collection").callsFake(collectionStub);
  });

  afterEach(() => {
    sinon.restore();
  });

  after(() => {
    testEnv.cleanup();
  });

  it("Firestoreにデータがある場合、APIを呼ばずにデータを返す", async () => {
    getStub.resolves({
      exists: true,
      data: () => ({
        city: "Tokyo",
        temperature: 8.98,
        humidity: 27,
        windSpeed: 9.77,
        description: "雲",
        icon: "04d",
        timestamp: Math.floor(Date.now() / 1000),
      }),
    } as unknown);

    const mockRequest = {
      data: { city: "Tokyo" },
      rawRequest: {},
      auth: null,
    } as unknown as functions.https.CallableRequest<unknown>;

    const result = await wrapped(mockRequest);

    expect(result.current).to.deep.include({
      city: "Tokyo",
      temperature: 8.98,
      humidity: 27,
      windSpeed: 9.77,
      description: "雲",
      icon: "04d",
    });

    assert.isFalse(fetchWeatherStub.called);
  });

  it("Firestoreにデータがない場合、APIから取得して保存する", async () => {
    getStub.resolves({ exists: false } as unknown);

    const mockRequest = {
      data: { city: "Tokyo" },
      rawRequest: {},
      auth: null,
    } as unknown as functions.https.CallableRequest<unknown>;

    const result = await wrapped(mockRequest);

    assert.isTrue(fetchWeatherStub.calledOnce);
    assert.isTrue(saveWeatherStub.calledOnce);

    expect(result.current).to.deep.include({
      city: "Tokyo",
      temperature: 8.98,
      humidity: 27,
      windSpeed: 9.77,
      description: "雲",
      icon: "04d",
    });
  });

  it("Firestoreに昨日の日付のデータがある場合、APIを呼び出す", async () => {
    const yesterdayTimestamp = Math.floor((Date.now() - 24 * 60 * 60 * 1000) / 1000); // 昨日

    getStub.resolves({
      exists: true,
      data: () => ({
        city: "Tokyo",
        temperature: 12.34,
        humidity: 50,
        windSpeed: 3.21,
        description: "曇り",
        icon: "03d",
        timestamp: yesterdayTimestamp, // 昨日のデータ
      }),
    } as unknown);

    const mockRequest = {
      data: { city: "Tokyo" },
      rawRequest: {},
      auth: null,
    } as unknown as functions.https.CallableRequest<unknown>;

    const result = await wrapped(mockRequest);

    assert.isTrue(fetchWeatherStub.calledOnce, "APIが呼び出されるべき");
    assert.isTrue(saveWeatherStub.calledOnce, "Firestore保存が行われるべき");

    expect(result.current).to.deep.include({
      city: "Tokyo",
      temperature: 8.98,
      humidity: 27,
      windSpeed: 9.77,
      description: "雲",
      icon: "04d",
    });
  });
});
