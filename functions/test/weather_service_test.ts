import {
  fetchWeatherFromAPI,
  saveWeatherToFirestore,
  WeatherData,
} from '../src/weather_service';
import firebaseFunctionsTest from 'firebase-functions-test';
import * as admin from 'firebase-admin';
import * as dotenv from 'dotenv';
import { expect } from 'chai';

dotenv.config();

// FirebaseFunctionsTestを「オンラインモード」で初期化
const testEnv = firebaseFunctionsTest({
  projectId: process.env.FIREBASE_PROJECT_ID, // Firebaseのテスト用プロジェクトID
});

const db = admin.firestore();

after(() => {
  testEnv.cleanup(); // テスト終了後にFirebase接続をクリーンアップ
});

describe('weather_service (オンラインモード)', () => {
  it('fetchWeatherFromAPIが有効な天気データを返す', async () => {
    const city = 'Tokyo';
    const result: WeatherData = await fetchWeatherFromAPI(city);

    console.log('fetchWeatherFromAPI result:', result);

    expect(result).to.have.property('city', city);
    expect(result).to.have.property('temperature');
    expect(result).to.have.property('humidity');
    expect(result).to.have.property('windSpeed');
    expect(result).to.have.property('description');

    expect(result.temperature).to.equal(8.98);
    expect(result.humidity).to.equal(27);
    expect(result.windSpeed).to.equal(9.77);
    expect(result.description).to.equal('雲');
  });

  it('saveWeatherToFirestoreはデータをFirestoreに保存する', async () => {
    const city = 'Tokyo';
    const weatherData: WeatherData = {
      city,
      temperature: 8.98,
      humidity: 27,
      windSpeed: 9.77,
      description: '雲',
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    };

    await saveWeatherToFirestore(city, weatherData);
    console.log('saveWeatherToFirestore 完了:', weatherData);

    // Firestoreからデータを取得して確認
    const snapshot = await db
      .collection('weather')
      .doc(city)
      .collection('forecasts')
      .orderBy('timestamp', 'desc')
      .limit(1)
      .get();

    
    if (snapshot.empty) {
      console.log('Firestoreにデータが存在しません');
    } else {
      const storedData = snapshot.docs[0].data();
      console.log('Firestoreから取得したデータ:', storedData);
    }

    expect(snapshot.empty).to.be.false;
    const storedData = snapshot.docs[0].data();

    expect(storedData.temperature).to.equal(8.98);
    expect(storedData.humidity).to.equal(27);
    expect(storedData.windSpeed).to.equal(9.77);
    expect(storedData.description).to.equal('雲');
  });
});
