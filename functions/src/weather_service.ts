import axios from "axios";
import * as admin from "firebase-admin";

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
interface WeatherData {
  city: string;
  temperature: number;
  humidity: number;
  windSpeed: number;
  description: string;
  icon: string;
  timestamp: number;
}

interface DailyForecast {
  dt: number;
  temp: {
    day: number;
    min: number;
    max: number;
  };
  humidity: number;
  wind_speed: number;
  weather: { description: string; icon: string }[];
}

/**
 * 都市名から緯度経度を取得
 */
async function fetchLatLon(city: string): Promise<{ lat: number; lon: number }> {
  const geoUrl = `https://api.openweathermap.org/geo/1.0/direct?q=${city}&limit=1&appid=${OPENWEATHER_API_KEY}`;

  const geoRes = await axios.get(geoUrl);
  if (geoRes.data.length === 0) {
    throw new Error(`${city} の緯度経度情報が取得できませんでした`);
  }

  const { lat, lon } = geoRes.data[0];
  return { lat, lon };
}

/**
 * ☀ One Call API から現在＋5日間の天気データを取得
 * @param city 都市名
 */
export async function fetchWeatherFromAPI(city: string): Promise<{ current: WeatherData; forecast: WeatherData[] }> {
  if (!OPENWEATHER_API_KEY) {
    throw new Error("APIキーが設定されていません");
  }

  const { lat, lon } = await fetchLatLon(city);

  const oneCallUrl = `https://api.openweathermap.org/data/3.0/onecall?lat=${lat}&lon=${lon}&exclude=minutely,hourly,alerts&units=metric&lang=ja&appid=${OPENWEATHER_API_KEY}`;

  const response = await axios.get(oneCallUrl);

  // 現在の天気データ
  const current: WeatherData = {
    city,
    temperature: response.data.current.temp,
    humidity: response.data.current.humidity,
    windSpeed: response.data.current.wind_speed,
    description: response.data.current.weather[0].description,
    icon: response.data.current.weather[0].icon,
    timestamp: response.data.current.dt,
  };

  // 5日間の予報データ
  const forecast: WeatherData[] = (response.data.daily.slice(1, 6) as DailyForecast[]).map((day) => ({
    city,
    temperature: day.temp.day,
    minTemp: day.temp.min,
    maxTemp: day.temp.max,
    humidity: day.humidity,
    windSpeed: day.wind_speed,
    description: day.weather[0].description,
    icon: day.weather[0].icon,
    timestamp: day.dt,
  }));

  return { current, forecast };
}

/**
 * Firestoreに現在＋5日間の天気を保存
 * @param city 都市名
 * @param weatherData 取得した天気データ
 */
export async function saveWeatherToFirestore(
  city: string,
  weatherData: { current: WeatherData; forecast: WeatherData[] }
): Promise<void> {
  const cityRef = db.collection("weather").doc(city);

  try {
    // 現在の天気データ保存
    await cityRef.collection("current").doc("data").set(weatherData.current);
    console.log(`Firestoreに${city}の現在の天気を保存`);

    // 5日間の天気予報データ保存
    const batch = db.batch();
    weatherData.forecast.forEach((day) => {
      const forecastRef = cityRef.collection("forecast").doc(day.timestamp.toString());
      batch.set(forecastRef, day);
    });

    await batch.commit();
    console.log(`Firestoreに${city}の5日間の天気予報を保存`);
  } catch (error) {
    console.error("Firestoreへの保存に失敗:", error);
    throw new Error("Firestoreへの保存に失敗しました");
  }
}
