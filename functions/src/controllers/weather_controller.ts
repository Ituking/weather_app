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
    console.log("=== getWeatherForCity 開始 ===");
    const city = request.data.city;
    console.log(`リクエスト都市: ${city}`);

    if (!city) {
      console.error("都市名が指定されていません");
      throw new functions.https.HttpsError("invalid-argument", "都市名が必要です。");
    }

    const now = Date.now() / 1000; // 秒単位の現在時刻
    console.log(`現在時刻: ${now}`);

    try {
      console.log(`=== ${city}の処理開始 ===`);
      const cityDoc = db.collection("weather").doc(city);

      // Firestoreから現在の天気を取得
      console.log(`${city}のFirestoreから現在の天気データを取得中...`);
      const currentRef = cityDoc.collection("current").doc("data");
      const currentSnapshot = await currentRef.get();

      if (currentSnapshot.exists) {
        console.log(`${city}の現在の天気データが存在します`);
        const currentData = currentSnapshot.data();
        const dataTimestamp = currentData?.timestamp ?? 0;
        console.log(`データタイムスタンプ: ${dataTimestamp}`);

        const currentDataDate = new Date(dataTimestamp * 1000).toDateString(); // 秒→ms
        const nowDate = new Date().toDateString(); // 現在のUTC日付
        const diff = now - dataTimestamp;
        console.log(`データ日付: ${currentDataDate}, 現在日付: ${nowDate}, 差分: ${diff}秒`);

        // 6時間以内かつデータが今日のものである場合のみキャッシュを使用
        if (diff < CACHE_DURATION_SECONDS && currentDataDate === nowDate) {
          console.log(`=== ${city}のキャッシュデータを使用 ===`);
          console.log(`Firestoreキャッシュから${city}の天気データを取得（再取得不要）`);

          try {
            console.log(`${city}の翻訳処理を開始（キャッシュデータ）`);
            // 翻訳処理を試行（失敗してもフォールバック）
            const currentTranslated = await waitForTranslations(currentRef);
            console.log(`${city}の現在の天気データの翻訳完了`);

            // Firestoreから5日間の予報を取得
            console.log(`${city}の予報データを取得中...`);
            const forecastSnapshot = await cityDoc.collection("forecast").orderBy("timestamp").get();
            console.log(`${city}の予報データ件数: ${forecastSnapshot.docs.length}`);

            // 予報データの翻訳処理を試行（失敗してもフォールバック）
            console.log(`${city}の予報データの翻訳処理を開始...`);
            const forecastTranslated = await Promise.allSettled(
              forecastSnapshot.docs.map((doc) => waitForTranslations(doc.ref))
            );

            // 翻訳成功したデータと失敗したデータを処理
            const forecastList = forecastTranslated.map((result, index) => {
              if (result.status === "fulfilled") {
                console.log(`${city}の予報データ${index}の翻訳成功`);
                return result.value;
              } else {
                console.warn(`${city}の予報データ${index}の翻訳に失敗、元のデータを使用:`, result.reason);
                return forecastSnapshot.docs[index].data();
              }
            });

            console.log(`=== ${city}のキャッシュデータ処理完了 ===`);
            return {
              current: currentTranslated,
              forecast: forecastList,
            };
          } catch (translationError) {
            console.error(`${city}の翻訳処理でエラーが発生:`, translationError);
            console.error(`エラーメッセージ: ${translationError instanceof Error ? translationError.message : "Unknown error"}`);
            console.error(`エラースタック: ${translationError instanceof Error ? translationError.stack : "No stack trace"}`);
            console.warn(`${city}の翻訳処理に失敗しましたが、元のデータを返します`);

            // 翻訳失敗時は元のデータを返す
            const forecastSnapshot = await cityDoc.collection("forecast").orderBy("timestamp").get();
            const forecastList = forecastSnapshot.docs.map((doc) => doc.data());

            console.log(`=== ${city}のフォールバック処理完了 ===`);
            return {
              current: currentData,
              forecast: forecastList,
            };
          }
        } else {
          console.log(`${city}のキャッシュデータが古いため、APIから再取得します`);
        }
      } else {
        console.log(`${city}の現在の天気データが存在しません`);
      }

      // キャッシュが古い、または存在しない場合 → APIから取得
      console.log(`=== ${city}のAPI取得処理開始 ===`);
      console.log(`${city}の天気データをAPIから取得します`);

      try {
        const weatherData = await fetchWeatherFromAPI(city);
        console.log(`${city}のAPI取得完了`);

        await saveWeatherToFirestore(city, weatherData);
        console.log(`APIから取得してFirestoreに保存: ${city}`);

        try {
          // 翻訳が揃うまで待機して読み込み
          console.log(`=== ${city}の翻訳処理開始 ===`);
          console.log(`${city}の翻訳処理を開始します`);

          const currentTranslated = await waitForTranslations(cityDoc.collection("current").doc("data"));
          console.log(`${city}の現在の天気データの翻訳完了`);

          const forecastSnapshot = await cityDoc.collection("forecast").orderBy("timestamp").get();
          console.log(`${city}の予報データ件数: ${forecastSnapshot.docs.length}`);

          const forecastTranslated = await Promise.allSettled(
            forecastSnapshot.docs.map((doc) => waitForTranslations(doc.ref))
          );

          // 翻訳成功したデータと失敗したデータを処理
          const forecastList = forecastTranslated.map((result, index) => {
            if (result.status === "fulfilled") {
              console.log(`${city}の予報データ${index}の翻訳成功`);
              return result.value;
            } else {
              console.warn(`${city}の予報データ${index}の翻訳に失敗、元のデータを使用:`, result.reason);
              return forecastSnapshot.docs[index].data();
            }
          });

          console.log(`=== ${city}の翻訳処理完了 ===`);
          return {
            current: currentTranslated,
            forecast: forecastList,
          };
        } catch (translationError) {
          console.error(`${city}の翻訳処理でエラーが発生:`, translationError);
          console.error(`エラーメッセージ: ${translationError instanceof Error ? translationError.message : "Unknown error"}`);
          console.error(`エラースタック: ${translationError instanceof Error ? translationError.stack : "No stack trace"}`);
          console.warn(`${city}の翻訳処理に失敗しましたが、元のデータを返します`);

          // 翻訳失敗時は元のデータを返す
          const currentData = await cityDoc.collection("current").doc("data").get();
          const forecastSnapshot = await cityDoc.collection("forecast").orderBy("timestamp").get();

          console.log(`=== ${city}のフォールバック処理完了 ===`);
          return {
            current: currentData.data(),
            forecast: forecastSnapshot.docs.map((doc) => doc.data()),
          };
        }
      } catch (apiError) {
        console.error(`${city}のAPI取得処理でエラーが発生:`, apiError);
        console.error(`エラーメッセージ: ${apiError instanceof Error ? apiError.message : "Unknown error"}`);
        console.error(`エラースタック: ${apiError instanceof Error ? apiError.stack : "No stack trace"}`);
        throw apiError;
      }
    } catch (error) {
      console.error(`=== ${city}の処理でエラーが発生 ===`);
      console.error(`${city}の天気データ取得・保存に失敗:`, error);
      console.error(`エラーメッセージ: ${error instanceof Error ? error.message : "Unknown error"}`);
      console.error(`エラースタック: ${error instanceof Error ? error.stack : "No stack trace"}`);
      console.error(`エラータイプ: ${error?.constructor?.name || "Unknown"}`);

      if (error instanceof functions.https.HttpsError) {
        throw error;
      } else {
        throw new functions.https.HttpsError("internal", "天気データの取得または保存に失敗しました");
      }
    }
  }
);
