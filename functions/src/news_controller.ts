import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { fetchNewsFromAPI, saveNewsToFirestore } from "./news_service";

const db = admin.firestore();

// 型定義
interface NewsRequest {
    city: string;
}

/**
 * ユーザーがリクエストした都市に関連するニュースを取得するCloudFunction
 */
export const getNewsForCity = functions.https.onCall(
  async (request: functions.https.CallableRequest<NewsRequest>) => {
    const city = request.data.city;

    if (!city) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "都市名が必要です。",
      );
    }

    // Firestoreから最新データを取得
    const newsRef = db
      .collection("news")
      .doc(city)
      .collection("articles")
      .orderBy("publishedAt", "desc")
      .limit(1);

    const snapshot = await newsRef.get();

    if (!snapshot.empty) {
      console.log(`Firestoreから${city}のニュースを取得`);
      return snapshot.docs[0].data();
    }

    // Firestoreにない場合、APIから取得して保存
    const articles = await fetchNewsFromAPI(city);
    await saveNewsToFirestore(city, articles);
    return articles;
  },
);
