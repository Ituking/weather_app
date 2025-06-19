import { assert, expect } from "chai";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import firebaseFunctionsTest from "firebase-functions-test";
import { WrappedV2CallableFunction } from "firebase-functions-test/lib/v2";
import * as sinon from "sinon";

import { getWeatherForCity } from "../../src/controllers/weather_controller";
import * as translationService from "../../src/services/wait_for_translation_ready";
import * as weatherService from "../../src/services/weather_service";

// 型定義
type MockDocumentReference = Pick<admin.firestore.DocumentReference, "get">;

const testEnv = firebaseFunctionsTest();

type WeatherData = {
  city: string;
  temperature: number;
  humidity: number;
  windSpeed: number;
  description: string;
  icon: string;
  timestamp: number;
  city_translations?: Record<string, string>;
  description_translations?: Record<string, string>;
};

describe("getWeatherForCityの動作検証 (Cloud Functions)", () => {
  let fetchWeatherStub: sinon.SinonStub;
  let saveWeatherStub: sinon.SinonStub;
  let getStub: sinon.SinonStub;
  let forecastGetStub: sinon.SinonStub;
  let waitForTranslationsStub: sinon.SinonStub;
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

    saveWeatherStub = sinon.stub(weatherService, "saveWeatherToFirestore").resolves();

    waitForTranslationsStub = sinon.stub(translationService, "waitForTranslations").callsFake(async (docRef: MockDocumentReference) => {
      const snapshot = await docRef.get();
      const data = snapshot.data();

      const translatedData: WeatherData = {
        city: data?.city ?? "Default City",
        temperature: data?.temperature ?? 0,
        humidity: data?.humidity ?? 0,
        windSpeed: data?.windSpeed ?? 0,
        description: data?.description ?? "Default Description",
        icon: data?.icon ?? "00d",
        timestamp: data?.timestamp ?? Math.floor(Date.now() / 1000),
        city_translations: { ja: "東京" },
        description_translations: { ja: "晴れ（翻訳済み）" },
        ...data,
      };

      return translatedData;
    });

    const collectionStub = sinon.stub();
    const docStub = sinon.stub();
    const currentDocStub = sinon.stub();
    const forecastOrderByStub = sinon.stub();
    getStub = sinon.stub();
    forecastGetStub = sinon.stub();

    collectionStub.withArgs("weather").returns({ doc: docStub });

    docStub.withArgs("Tokyo").returns({
      collection: (subName: string) => {
        if (subName === "current") return { doc: currentDocStub };
        if (subName === "forecast") return { orderBy: forecastOrderByStub };
        return {};
      },
    });

    currentDocStub.withArgs("data").returns({ get: getStub });
    forecastOrderByStub.withArgs("timestamp").returns({ get: forecastGetStub });

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

    forecastGetStub.resolves({ docs: [] });

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
    assert.isTrue(waitForTranslationsStub.called);
  });

  it("Firestoreに昨日の日付のデータがある場合、APIを呼び出す", async () => {
    const nowTimestamp = Math.floor(Date.now() / 1000);
    const yesterdayTimestamp = nowTimestamp - 86400;

    const commonWeatherData = {
      city: "Tokyo",
      temperature: 8.98,
      humidity: 27,
      windSpeed: 9.77,
      description: "曇り",
      icon: "04d",
    };

    getStub.onCall(0).resolves({
      exists: true,
      data: () => ({
        ...commonWeatherData,
        timestamp: yesterdayTimestamp,
      }),
    } as unknown);

    getStub.onCall(1).resolves({
      exists: true,
      data: () => ({
        ...commonWeatherData,
        timestamp: nowTimestamp,
      }),
    } as unknown);

    forecastGetStub.resolves({ docs: [] });

    const mockRequest = {
      data: { city: "Tokyo" },
      rawRequest: {},
      auth: null,
    } as unknown as functions.https.CallableRequest<unknown>;

    const result = await wrapped(mockRequest);

    assert.isTrue(fetchWeatherStub.calledOnce);
    assert.isTrue(saveWeatherStub.calledOnce);
    assert.isTrue(waitForTranslationsStub.calledOnce);

    expect(result.current).to.deep.include({
      ...commonWeatherData,
      timestamp: nowTimestamp,
      city_translations: { ja: "東京" },
      description_translations: { ja: "晴れ（翻訳済み）" },
    });

    expect(result.forecast.length).to.equal(0);
  });
});
