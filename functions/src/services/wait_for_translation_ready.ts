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

/**
 * Firestoreドキュメントから都市名および天気の説明の翻訳フィールドを待機的に取得します。
 *
 * Firestoreに保存された翻訳対象ドキュメント（description_translations, city_translations）に
 * 拡張機能による翻訳が反映されるまで最大10秒間ポーリングします。
 * 翻訳が揃った段階でデータを返却します。
 * 翻訳が完了しないまま10回の試行を超えた場合はエラーをスローします。
 *
 * @param docRef - Firestoreのドキュメント参照（`get()` メソッドを持つ）
 * @returns 翻訳されたフィールドを含むForecastData型のデータ
 * @throws Error - 翻訳が完了しない場合にエラーをスロー
 */

export async function waitForTranslations(
  docRef: Pick<admin.firestore.DocumentReference, "get">
): Promise<ForecastData> {
  for (let i = 0; i < 10; i++) {
    const snapshot = await docRef.get();
    const data = snapshot.data();

    if (data?.city_translations && data?.description_translations) {
      return data as ForecastData;
    }

    await new Promise((resolve) => setTimeout(resolve, 1000)); // 1秒待機
  }

  throw new Error("複数回の試行後も翻訳が完了していません。");
}
