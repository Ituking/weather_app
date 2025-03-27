import '../core/network/response/result.dart';
import '../models/forecast.dart';
import '../repositories/firestore_weather_repository.dart';
import '../repositories/weather_repository.dart';

/// 天気データの取得とビジネスロジックを管理するサービス
class WeatherService {
  final WeatherRepository apiRepository;
  final FirestoreWeatherRepository firestoreRepository;

  WeatherService({
    required this.apiRepository,
    required this.firestoreRepository,
  });

  /// Firestore優先でデータ取得し、なければCloud Functionsから取得
  Future<Result<Forecast>> getWeatherData(String cityName) async {
    final firestoreResult = await firestoreRepository.fetchForecast(cityName);

    return firestoreResult.maybeWhen(
      success: (weatherResponse) => Result.success(weatherResponse),
      orElse: () => apiRepository.getWeather(cityName), // Firestore失敗時
    );
  }
}
