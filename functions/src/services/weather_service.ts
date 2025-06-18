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
  console.log(`${city}の緯度経度情報を取得中...`);

  try {
    const geoUrl = `https://api.openweathermap.org/geo/1.0/direct?q=${city}&limit=1&appid=${OPENWEATHER_API_KEY}`;

    const geoRes = await axios.get(geoUrl);
    if (geoRes.data.length === 0) {
      throw new Error(`${city} の緯度経度情報が取得できませんでした`);
    }

    const { lat, lon } = geoRes.data[0];
    console.log(`${city}の緯度経度情報を取得完了: lat=${lat}, lon=${lon}`);
    return { lat, lon };
  } catch (error) {
    console.error(`${city}の緯度経度情報取得に失敗:`, error);
    throw error;
  }
}

/**
 * ☀ One Call API から現在＋5日間の天気データを取得
 * @param city 都市名
 */
export async function fetchWeatherFromAPI(city: string): Promise<{ current: WeatherData; forecast: WeatherData[] }> {
  console.log(`${city}の天気データをAPIから取得開始`);

  if (!OPENWEATHER_API_KEY) {
    console.error("APIキーが設定されていません");
    throw new Error("APIキーが設定されていません");
  }

  try {
    const { lat, lon } = await fetchLatLon(city);

    const oneCallUrl = `https://api.openweathermap.org/data/3.0/onecall?lat=${lat}&lon=${lon}&exclude=minutely,hourly,alerts&units=metric&lang=en&appid=${OPENWEATHER_API_KEY}`;

    console.log(`${city}のOne Call APIを呼び出し中...`);
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

    console.log(`${city}の天気データ取得完了: 現在の天気=${current.description}, 予報件数=${forecast.length}`);
    return { current, forecast };
  } catch (error) {
    console.error(`${city}の天気データ取得に失敗:`, error);
    throw error;
  }
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
  console.log(`${city}の天気データをFirestoreに保存開始`);

  const cityRef = db.collection("weather").doc(city);

  try {
    // 現在の天気データ保存
    await cityRef.collection("current").doc("data").set(weatherData.current);
    console.log(`Firestoreに${city}の現在の天気を保存完了`);

    // 5日間の天気予報データ保存
    const batch = db.batch();
    weatherData.forecast.forEach((day) => {
      const forecastRef = cityRef.collection("forecast").doc(day.timestamp.toString());
      batch.set(forecastRef, day);
    });

    await batch.commit();
    console.log(`Firestoreに${city}の5日間の天気予報を保存完了`);

    // 翻訳処理の準備完了をログ出力
    console.log(`${city}のデータがFirestoreに保存されました。Firebase Extensionによる翻訳処理が開始される予定です。`);
  } catch (error) {
    console.error(`${city}のFirestore保存に失敗:`, error);
    throw new Error("Firestoreへの保存に失敗しました");
  }
}
