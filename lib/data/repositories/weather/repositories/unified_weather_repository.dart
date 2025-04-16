import '../../../../core/network/response/result.dart';
import '../../../../domain/models/weather/forecast.dart';
import 'firestore_weather_repository.dart';
import 'weather_repository.dart';

/// Firestore優先で天気情報を取得し、失敗時にはAPIから取得するリポジトリ。
class UnifiedWeatherRepository implements WeatherRepository {
  final FirestoreWeatherRepository firestoreRepository;
  final WeatherRepository apiRepository;

  UnifiedWeatherRepository({
    required this.firestoreRepository,
    required this.apiRepository,
  });

  @override
  Future<Result<Forecast>> getWeather(String cityName) async {
    final firestoreResult = await firestoreRepository.fetchForecast(cityName);

    return firestoreResult.maybeWhen(
      success: (forecast) => Result.success(forecast),
      orElse: () => apiRepository.getWeather(cityName),
    );
  }
}
