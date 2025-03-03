import { assert, expect } from "chai";
import * as dotenv from "dotenv";
import * as admin from "firebase-admin";
import firebaseFunctionsTest from "firebase-functions-test";
import nock from "nock";

import {
  WeatherData,
  fetchWeatherFromAPI,
  saveWeatherToFirestore,
} from "../src/weather_service";

dotenv.config();

// FirebaseFunctionsTestを「オンラインモード」で初期化
const testEnv = firebaseFunctionsTest({
  projectId: process.env.GCLOUD_PROJECT, //  GOOGLE CLOUDのテスト用プロジェクトID
});

const db = admin.firestore();

// テスト開始前にOpenWeatherMapAPIのレスポンスをモック
before(() => {
  nock("https://api.openweathermap.org")
    .get(/\/data\/2.5\/weather/)
    .reply(200, {
      main: { temp: 8.98, humidity: 27 },
      wind: { speed: 9.77 },
      weather: [{ description: "雲" }],
    });
});

after(() => {
  testEnv.cleanup(); // テスト終了後にFirebase接続をクリーンアップ
  nock.cleanAll();
});

describe("weather_service (オンラインモード)", () => {
  it("fetchWeatherFromAPIが有効な天気データを返す", async () => {
    const city = "Tokyo";
    const result: WeatherData = await fetchWeatherFromAPI(city);

    expect(result).to.deep.include({
      city,
      temperature: 8.98,
      humidity: 27,
      windSpeed: 9.77,
      description: "雲",
    });
  });

  it("saveWeatherToFirestoreはデータをFirestoreに保存する", async () => {
    const city = "Tokyo";
    const weatherData: WeatherData = {
      city,
      temperature: 8.98,
      humidity: 27,
      windSpeed: 9.77,
      description: "雲",
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    };

    await saveWeatherToFirestore(city, weatherData);

    // Firestoreからデータを取得して確認
    const snapshot = await db
      .collection("weather")
      .doc(city)
      .collection("forecasts")
      .orderBy("timestamp", "desc")
      .limit(1)
      .get();

    assert.isFalse(snapshot.empty);
    const storedData = snapshot.docs[0].data();

    expect(storedData).to.deep.include({
      temperature: 8.98,
      humidity: 27,
      windSpeed: 9.77,
      description: "雲",
    });
  });
});
