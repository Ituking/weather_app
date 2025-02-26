import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

import { fetchWeatherFromAPI, saveWeatherToFirestore } from './weather_service';

const db = admin.firestore();

// 型定義
interface WeatherRequest {
  city: string;
}

/**
 * ユーザーがリクエストした都市の天気を取得するCloudFunction
 */
export const getWeatherForCity = functions.https.onCall(
  async (request: functions.https.CallableRequest<WeatherRequest>) => {
    const city = request.data.city;

    if (!city) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        '都市名が必要です。',
      );
    }

    // Firestoreから最新データを取得
    const weatherRef = db
      .collection('weather')
      .doc(city)
      .collection('forecasts')
      .orderBy('timestamp', 'desc')
      .limit(1);

    const snapshot = await weatherRef.get();

    if (!snapshot.empty) {
      console.log(`Firestoreから${city}の天気データを取得`);
      return snapshot.docs[0].data();
    }

    // Firestoreにない場合、APIから取得して保存
    const weatherData = await fetchWeatherFromAPI(city);
    await saveWeatherToFirestore(city, weatherData);
    return weatherData;
  },
);
