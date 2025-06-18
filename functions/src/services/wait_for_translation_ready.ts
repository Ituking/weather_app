import * as admin from "firebase-admin";

interface TranslationFields {
  city_translations?: Record<string, string>;
  description_translations?: Record<string, string>;
}

interface ForecastData extends TranslationFields {
  city: string;
  description: string;
  humidity: number;
  temperature: number;
  minTemp?: number;
  maxTemp?: number;
  windSpeed: number;
  icon: string;
  timestamp: number;
}

// 翻訳処理の設定
const TRANSLATION_TIMEOUT_SECONDS = 30;
const POLLING_INTERVAL_MS = 2000;
const MAX_RETRY_COUNT = Math.floor(TRANSLATION_TIMEOUT_SECONDS * 1000 / POLLING_INTERVAL_MS);

/**
 * Firestoreドキュメントから都市名および天気の説明の翻訳フィールドを待機的に取得します。
 *
 * Firestoreに保存された翻訳対象ドキュメント（description_translations, city_translations）に
 * 拡張機能による翻訳が反映されるまで最大30秒間ポーリングします。
 * 翻訳が揃った段階でデータを返却します。
 * 翻訳が完了しない場合は元のデータを返すフォールバック機能を提供します。
 *
 * @param docRef - Firestoreのドキュメント参照（`get()` メソッドを持つ）
 * @returns 翻訳されたフィールドを含むForecastData型のデータ（翻訳失敗時は元のデータ）
 */
export async function waitForTranslations(
  docRef: Pick<admin.firestore.DocumentReference, "get">
): Promise<ForecastData> {
  console.log("=== waitForTranslations 開始 ===");
  console.log(`設定: タイムアウト=${TRANSLATION_TIMEOUT_SECONDS}秒, ポーリング間隔=${POLLING_INTERVAL_MS}ms, 最大試行回数=${MAX_RETRY_COUNT}`);

  try {
    for (let i = 0; i < MAX_RETRY_COUNT; i++) {
      console.log(`翻訳チェック試行 ${i + 1}/${MAX_RETRY_COUNT}`);

      const snapshot = await docRef.get();
      const data = snapshot.data();

      console.log(`データ取得完了: ${snapshot.exists ? "存在しています" : "存在していません"}`);

      if (data) {
        console.log("翻訳フィールド確認:");
        console.log(`- city_translations: ${data.city_translations ? "存在しています" : "存在していません"}`);
        console.log(`- description_translations: ${data.description_translations ? "存在しています" : "存在していません"}`);

        if (data.city_translations && data.description_translations) {
          console.log(`=== 翻訳処理完了（試行回数: ${i + 1}）===`);
          console.log("翻訳データ:", {
            city_translations: Object.keys(data.city_translations),
            description_translations: Object.keys(data.description_translations)
          });
          return data as ForecastData;
        }
      }

      if (i < MAX_RETRY_COUNT - 1) { // 最後の試行では待機しない
        console.log(`翻訳処理待機中... ${POLLING_INTERVAL_MS}ms後に再試行`);
        await new Promise((resolve) => setTimeout(resolve, POLLING_INTERVAL_MS));
      }
    }

    // 翻訳が完了しない場合は元のデータを返す
    console.warn("=== 翻訳処理タイムアウト ===");
    console.warn(`${MAX_RETRY_COUNT}回の試行後も翻訳が完了しませんでした。元のデータを返します。`);

    const fallbackSnapshot = await docRef.get();
    const fallbackData = fallbackSnapshot.data();

    if (!fallbackData) {
      console.error("フォールバックデータが存在しません");
      throw new Error("ドキュメントデータが見つかりません");
    }

    console.log("=== フォールバックデータ返却 ===");
    return fallbackData as ForecastData;
  } catch (error) {
    console.error("=== waitForTranslations でエラーが発生 ===");
    console.error("翻訳処理中にエラーが発生しました:", error);
    console.error(`エラーメッセージ: ${error instanceof Error ? error.message : "Unknown error"}`);
    console.error(`エラースタック: ${error instanceof Error ? error.stack : "No stack trace"}`);

    // エラーが発生した場合も元のデータを取得して返す
    try {
      console.log("フォールバック処理を試行中...");
      const fallbackSnapshot = await docRef.get();
      const fallbackData = fallbackSnapshot.data();

      if (!fallbackData) {
        console.error("フォールバックデータの取得に失敗しました");
        throw new Error("フォールバックデータの取得に失敗しました");
      }

      console.log("=== エラー後のフォールバック成功 ===");
      return fallbackData as ForecastData;
    } catch (fallbackError) {
      console.error("=== フォールバック処理も失敗 ===");
      console.error("フォールバック処理にも失敗しました:", fallbackError);
      console.error(`フォールバックエラーメッセージ: ${fallbackError instanceof Error ? fallbackError.message : "Unknown error"}`);
      console.error(`フォールバックエラースタック: ${fallbackError instanceof Error ? fallbackError.stack : "No stack trace"}`);
      throw new Error("翻訳処理とフォールバック処理の両方に失敗しました");
    }
  }
}
