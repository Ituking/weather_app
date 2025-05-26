import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

import { waitForTranslations } from "../services/wait_for_translation_ready";
import { fetchWeatherFromAPI, saveWeatherToFirestore } from "../services/weather_service";

const db = admin.firestore();

// 型定義
interface WeatherRequest {
  city: string;
}

const CACHE_DURATION_SECONDS = 1 * 60 * 60; // 1時間（3600秒）

/**
 * 都市の天気を取得するCloud Function
 */
export const getWeatherForCity = functions.https.onCall(
  async (request: functions.https.CallableRequest<WeatherRequest>) => {
    const city = request.data.city;

    if (!city) {
      throw new functions.https.HttpsError("invalid-argument", "都市名が必要です。");
    }

    const now = Date.now() / 1000; // 秒単位の現在時刻

    try {
      const cityDoc = db.collection("weather").doc(city);

      // Firestoreから現在の天気を取得
      const currentRef = cityDoc.collection("current").doc("data");
      const currentSnapshot = await currentRef.get();

      if (currentSnapshot.exists) {
        const currentData = currentSnapshot.data();
        const dataTimestamp = currentData?.timestamp ?? 0;

        const currentDataDate = new Date(dataTimestamp * 1000).toDateString(); // 秒→ms
        const nowDate = new Date().toDateString(); // 現在のUTC日付
        const diff = now - dataTimestamp;

        // 6時間以内かつデータが今日のものである場合のみキャッシュを使用
        if (diff < CACHE_DURATION_SECONDS && currentDataDate === nowDate) {
          console.log(`Firestoreキャッシュから${city}の天気データを取得（再取得不要）`);

          // Firestoreから5日間の予報を取得
          const forecastSnapshot = await cityDoc.collection("forecast").orderBy("timestamp").get();
          const forecastList = forecastSnapshot.docs.map((doc) => doc.data());

          return {
            current: currentData,
            forecast: forecastList,
          };
        }
      }

      // キャッシュが古い、または存在しない場合 → APIから取得
      const weatherData = await fetchWeatherFromAPI(city);
      await saveWeatherToFirestore(city, weatherData);

      console.log(`APIから取得してFirestoreに保存: ${city}`);

      // 翻訳が揃うまで待機して読み込み
      const currentTranslated = await waitForTranslations(cityDoc.collection("current").doc("data"));
      const forecastSnapshot = await cityDoc.collection("forecast").orderBy("timestamp").get();
      const forecastTranslated = await Promise.all(
        forecastSnapshot.docs.map((doc) => waitForTranslations(doc.ref))
      );

      return {
        current: currentTranslated,
        forecast: forecastTranslated,
      };
    } catch (error) {
      console.error(`${city}の天気データ取得・保存に失敗:`, error);
      throw new functions.https.HttpsError("internal", "天気データの取得または保存に失敗しました");
    }
  }
);
