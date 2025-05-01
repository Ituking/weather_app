import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/network/response/result.dart';
import '../../../../domain/models/weather/forecast.dart';
import 'firestore_weather_repository.dart';

/// Firestoreから天気データを取得するリポジトリ
class FirestoreWeatherRepositoryImpl implements FirestoreWeatherRepository {
  @override
  Future<Result<List<Forecast>>> fetchForecast(String cityName) async {
    {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('weather')
            .doc(cityName)
            .collection('forecasts')
            .orderBy('timestamp', descending: true)
            .limit(5)
            .get();

        if (snapshot.docs.isEmpty) {
          return Result.failure(
            ApiError(type: ApiErrorType.notFound, message: 'データが存在しません'),
          );
        }

        final forecasts = snapshot.docs.map((doc) {
          final data = doc.data();

          return Forecast(
            id: doc.id,
            city: data['city'] ?? '',
            description: data['description'] ?? '',
            temperature: (data['temperature'] ?? 0).toDouble(),
            humidity: (data['humidity'] ?? 0).toDouble(),
            windSpeed: (data['windSpeed'] ?? 0).toDouble(),
            icon: data['icon'] ?? '',
            timestamp: data['timestamp'] ?? 0,
          );
        }).toList();

        return Result.success(forecasts);
      } catch (e) {
        return Result.failure(
          ApiError(type: ApiErrorType.unknown, message: e.toString()),
        );
      }
    }
  }
}
