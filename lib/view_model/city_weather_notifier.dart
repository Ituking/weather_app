import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/logger/logger_provider.dart';
import '../core/network/api_error.dart';
import '../core/network/response/result.dart';
import '../core/network/response/weather_response.dart';
import '../repositories/weather_repository.dart';
import '../repositories/weather_repository_provider.dart';
import 'providers/dio_error_handler_provider.dart';
import 'providers/text_editing_controller_provider.dart';

/// [CityWeatherNotifier]は、指定された都市の天気情報を非同期に取得し、
/// その結果を管理するための[Notifier]クラスです。
class CityWeatherNotifier
    extends Notifier<AsyncValue<Result<WeatherResponse>>> {
  late final WeatherRepository _weatherRepository;

  @override
  AsyncValue<Result<WeatherResponse>> build() {
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
    final logger = ref.read(loggerProvider);
    state = const AsyncLoading();

    try {
      // TextEditingControllerから都市名を取得
      final cityName = ref.read(textEditingControllerProvider).text.trim();

      // 指定された都市の天気情報を非同期に取得し、結果をresultに格納
      final result = await _weatherRepository.getWeather(cityName);

      result.when(
        success: (weatherResponse) {
          state = AsyncData(Result.success(weatherResponse));
        },
        failure: (error) {
          logger.logError(
            'Failed to fetch weather for city: $cityName. Error: ${error.message}',
            StackTrace.current,
          );

          state = AsyncData(Result.failure(error));
        },
      );
    } on DioException catch (e, stackTrace) {
      // DioExceptionをキャッチし、エラーハンドラーを使用して適切なApiErrorを生成
      final dioErrorHandler = ref.read(dioErrorHandlerProvider);
      final apiError = dioErrorHandler.handle(e);

      logger.logError(
        'DioException while fetching weather for city: $cityName. Message: ${e.message}',
        stackTrace,
      );

      state = AsyncData(Result.failure(apiError));
    } catch (e, stackTrace) {
      // その他のエラー処理
      logger.logError(
        'Unexpected error while fetching weather for city: $cityName. Error: $e',
        stackTrace,
      );

      state = AsyncData(Result.failure(
          ApiError(type: ApiErrorType.unknown, message: e.toString())));
    }
  }
}
