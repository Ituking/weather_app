import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/network/api_error.dart';
import '../core/network/response/result.dart';
import '../core/network/response/weather_response.dart';
import 'firestore_weather_repository.dart';

/// Firestoreから天気データを取得するリポジトリ
class FirestoreWeatherRepositoryImpl implements FirestoreWeatherRepository {
  @override
  Future<Result<WeatherResponse>> getWeather(String cityName) async {
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

      // データ構造確認用のログ
      debugPrint('Firestore weather data: $weatherData');

      // 必須フィールドの存在確認
      if (weatherData['temperature'] == null ||
          weatherData['humidity'] == null ||
          weatherData['windSpeed'] == null ||
          weatherData['description'] == null) {
        return Result.failure(
          ApiError(
            type: ApiErrorType.unknown,
            message: '天気データの形式が不正です',
          ),
        );
      }

      // WeatherResponse 生成用のデータ整形
      final formattedData = {
        "main": {
          "temp": weatherData['temperature'],
          "humidity": weatherData['humidity'],
        },
        "wind": {
          "speed": weatherData['windSpeed'],
        },
        "weather": [
          {
            "description": weatherData['description'],
            "icon": "01d" // Firestoreにはアイコン情報がないため、仮で固定値
          }
        ],
      };

      final weatherResponse = WeatherResponse.fromJson(formattedData);

      return Result.success(weatherResponse);
    } catch (e) {
      return Result.failure(
        ApiError(type: ApiErrorType.unknown, message: e.toString()),
      );
    }
  }
}
