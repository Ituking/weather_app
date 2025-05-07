import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * 毎日0時過ぎに呼び出される天気データ削除処理
 */
export const clearAllWeatherData = async () => {
  const weatherSnapshot = await db.collection("weather").listDocuments();

  for (const cityDoc of weatherSnapshot) {
    const currentRef = cityDoc.collection("current").doc("data");
    const forecastSnapshot = await cityDoc.collection("forecast").listDocuments();

    await currentRef.delete();
    const batch = db.batch();
    forecastSnapshot.forEach((doc) => batch.delete(doc));
    await batch.commit();
  }

  console.log("[Batch]:全都市の天気データを削除しました。");
};
