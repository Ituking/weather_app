import axios from "axios";
import * as admin from "firebase-admin";

// Firestoreインスタンス
const db = admin.firestore();

/**
 * NODE_ENVに応じて適切なNewsAPIキーを返す
 * 
 * @returns {string} 環境変数から取得したAPIキー
 */
const getNewsApiKey = (): string => {
  switch (process.env.NODE_ENV) {
  case "prod":
    return process.env.NEWS_API_KEY_PROD || "";
  case "stg":
    return process.env.NEWS_API_KEY_STG || "";
  case "dev":
  default:
    return process.env.NEWS_API_KEY_DEV || "";
  }
};

const NEWS_API_KEY = getNewsApiKey();

/**
 * NewsAPIから返される生のニュース記事データ構造
 */
export interface RawArticle {
  title: string;
  description: string;
  url: string;
  publishedAt: string;
  source: { name: string };
}

/**
 * アプリ内で利用する整形済みニュース記事データの型
 */
export interface NewsArticle {
  title: string;
  description: string;
  url: string;
  publishedAt: string;
  source: string;
}

/**
 * NewsAPIから指定された都市に関連するニュース記事を取得する
 * 
 * @param {string} city - ニュースを取得したい都市名
 * @returns {Promise<NewsArticle[]>} 整形されたニュース記事の配列
 * @throws {Error} APIキー未設定またはAPI呼び出し失敗時にエラーをスロー
 */
export async function fetchNewsFromAPI(city: string): Promise<NewsArticle[]> {
  if (!NEWS_API_KEY) throw new Error("APIキーが設定されていません");

  try {
    const res = await axios.get<{ articles: RawArticle[] }>(
      `https://newsapi.org/v2/everything?q=${encodeURIComponent(city)}&apiKey=${NEWS_API_KEY}&language=en&pageSize=5`
    );

    return res.data.articles.map((a) => ({
      title: a.title,
      description: a.description,
      url: a.url,
      publishedAt: a.publishedAt,
      source: a.source.name,
    }));
  } catch (error) {
    console.error(`${city}のニュース取得に失敗:`, error);
    throw new Error("ニュースの取得に失敗しました");
  }
}

/**
 * ニュース記事データをFirestoreに保存する
 * 
 * @param {string} city - 都市名（ドキュメントIDとして使用）
 * @param {NewsArticle[]} articles - 保存するニュース記事データの配列
 * @returns {Promise<void>} Firestoreへの保存処理の完了を示すPromise
 * @throws {Error} 保存失敗時にエラーをスロー
 */
export async function saveNewsToFirestore(city: string, articles: NewsArticle[]): Promise<void> {
  const batch = db.batch();
  const cityRef = db.collection("news").doc(city);

  articles.forEach((article, i) => {
    const docRef = cityRef.collection("articles").doc(`news_${i}`);
    batch.set(docRef, article);
  });

  try {
    await batch.commit();
    console.log(`Firestoreに${city}のニュースを保存`);
  } catch (error) {
    console.error("Firestore保存に失敗:", error);
    throw new Error("Firestoreへの保存に失敗しました");
  }
}
