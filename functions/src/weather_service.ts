import axios from "axios";
import * as admin from "firebase-admin";

const projectId = process.env.FIREBASE_PROJECT_ID || process.env.FIREBASE_PROJECT_ID_DEV;

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  projectId,
});

// Firestoreインスタンス
const db = admin.firestore();

// NODE_ENVに応じてAPIキーを設定
const getOpenWeatherApiKey = (): string => {
  switch (process.env.NODE_ENV) {
  case "prod":
    return process.env.OPENWEATHERMAP_API_KEY_PROD || "";
  case "stg":
    return process.env.OPENWEATHERMAP_API_KEY_STG || "";
  case "dev":
  default:
    return process.env.OPENWEATHERMAP_API_KEY_DEV || "";
  }
};

const OPENWEATHER_API_KEY = getOpenWeatherApiKey();

// 天気データの型定義
export interface WeatherData {
  city: string;
  temperature: number;
  humidity: number;
  windSpeed: number;
  description: string;
  timestamp: FirebaseFirestore.FieldValue;
}

/**
 * OpenWeatherMapAPIから天気データを取得
 * @param {string} city - 取得する都市名
 * @returns {Promise<WeatherData>} 取得した天気データ
 */
export async function fetchWeatherFromAPI(city: string): Promise<WeatherData> {
  if (!OPENWEATHER_API_KEY) {
    throw new Error("APIキーが設定されていません");
  }

  try {
    const response = await axios.get(
      `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${OPENWEATHER_API_KEY}&units=metric&lang=ja`,
    );

    return {
      city: city,
      temperature: response.data.main.temp,
      humidity: response.data.main.humidity,
      windSpeed: response.data.wind.speed,
      description: response.data.weather[0].description,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    };
  } catch (error) {
    console.error(`${city}の天気データ取得に失敗:`, error);
    throw new Error("天気データの取得に失敗しました");
  }
}

/**
 * Firestoreに天気データを保存
 * @param {string} city - 都市名
 * @param {WeatherData} weatherData - 保存する天気データ
 * @returns {Promise<void>}
 */
export async function saveWeatherToFirestore(
  city: string,
  weatherData: WeatherData,
): Promise<void> {
  const now = new Date();
  const timestamp = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}-${String(now.getDate()).padStart(2, "0")}-${String(now.getHours()).padStart(2, "0")}`;

  try {
    await db
      .collection("weather")
      .doc(city)
      .collection("forecasts")
      .doc(timestamp)
      .set(weatherData);
    console.log(`Firestoreに${city}の天気データを保存`);
  } catch (error) {
    console.error("Firestoreへの保存に失敗:", error);
    throw new Error("Firestoreへの保存に失敗しました");
  }
}
