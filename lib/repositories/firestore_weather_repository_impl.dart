import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/network/api_error.dart';
import '../core/network/response/result.dart';
import '../models/forecast.dart';
import 'firestore_weather_repository.dart';

/// Firestoreから天気データを取得するリポジトリ
class FirestoreWeatherRepositoryImpl implements FirestoreWeatherRepository {
  @override
  Future<Result<Forecast>> fetchForecast(String cityName) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('weather')
          .doc(cityName)
          .collection('forecasts')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return Result.failure(
          ApiError(type: ApiErrorType.notFound, message: 'データが存在しません'),
        );
      }

      final weatherData = snapshot.docs.first.data();

      // 必須フィールドの存在確認
      if (weatherData['temperature'] == null ||
          weatherData['humidity'] == null ||
          weatherData['windSpeed'] == null ||
          weatherData['description'] == null ||
          weatherData['city'] == null) {
        return Result.failure(
          ApiError(
            type: ApiErrorType.unknown,
            message: '天気データの形式が不正です',
          ),
        );
      }

      // Forecastオブジェクト生成
      final forecast = Forecast(
        id: snapshot.docs.first.id,
        city: weatherData['city'],
        description: weatherData['description'],
        temperature: weatherData['temperature'].toDouble(),
        humidity: weatherData['humidity'].toDouble(),
        windSpeed: weatherData['windSpeed'].toDouble(),
      );

      return Result.success(forecast);
    } catch (e) {
      return Result.failure(
        ApiError(type: ApiErrorType.unknown, message: e.toString()),
      );
    }
  }
}
