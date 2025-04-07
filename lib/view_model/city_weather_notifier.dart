import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/logger/app_log.dart';
import '../core/network/api_error.dart';
import '../core/network/response/result.dart';
import '../features/weather/models/forecast.dart';
import '../features/weather/repositories/weather_repository.dart';
import '../features/weather/repositories/weather_repository_provider.dart';

/// [CityWeatherNotifier]は、指定された都市の天気情報を非同期に取得し、
/// その結果を管理するための[Notifier]クラスです。
class CityWeatherNotifier extends Notifier<AsyncValue<Result<Forecast>>> {
  late final WeatherRepository _weatherRepository;

  @override
  AsyncValue<Result<Forecast>> build() {
    _weatherRepository = ref.read(weatherRepositoryProvider);
    return const AsyncLoading();
  }

  /// 指定された都市名の天気情報を取得し、状態を更新します。
  ///
  /// [cityName] : 天気情報を取得する都市の名前。
  ///
  /// このメソッドは、都市名をトリムし、[WeatherRepository]を使用して
  /// 天気情報を取得します。取得結果は[state]に格納されます。
  Future<void> fetchWeather(String cityName) async {
    state = const AsyncLoading();

    try {
      // 指定された都市の天気情報を非同期に取得し、結果をresultに格納
      final result = await _weatherRepository.getWeather(cityName);

      result.when(
        success: (weatherResponse) {
          state = AsyncData(Result.success(weatherResponse));
        },
        failure: (error) {
          AppLog.error(
            message:
                'Failed to fetch weather for city: $cityName. Error: ${error.message}',
            exception: error,
            stackTrace: StackTrace.current,
          );

          state = AsyncData(Result.failure(error));
        },
      );
    } catch (e, stackTrace) {
      AppLog.error(
        message:
            'Unexpected error while fetching weather for city: $cityName. Error: $e',
        exception: e,
        stackTrace: stackTrace,
      );

      state = AsyncData(Result.failure(
          ApiError(type: ApiErrorType.unknown, message: e.toString())));
    }
  }
}
