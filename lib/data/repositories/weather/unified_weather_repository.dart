import '../../../core/network/response/api_result.dart';
import '../../../domain/models/weather/forecast.dart';
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
  Future<ApiResult<List<Forecast>>> getWeather(String cityName) async {
    final firestoreResult = await firestoreRepository.fetchForecast(cityName);

    return firestoreResult.maybeWhen(
      success: (forecastList) => ApiResult.success(forecastList),
      orElse: () async {
        final apiResult = await apiRepository.getWeather(cityName);

        return apiResult.when(
          success: (forecastList) => ApiResult.success(forecastList),
          failure: (error) => ApiResult.failure(error),
        );
      },
    );
  }
}
