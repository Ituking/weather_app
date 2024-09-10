import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_response.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';
import 'package:weather_app/view_model/providers/dio_error_handler_provider.dart';
import 'package:weather_app/view_model/providers/text_editing_controller_provider.dart';

// CityWeatherNotifierは、都市名に基づいて天気情報を取得するNotifier
class CityWeatherNotifier
    extends Notifier<AsyncValue<Result<WeatherResponse>>> {
  late final WeatherRepository _weatherRepository;

  @override
  AsyncValue<Result<WeatherResponse>> build() {
    _weatherRepository = ref.read(weatherRepositoryProvider);
    return const AsyncLoading();
  }

  // 都市名を設定して天気情報を取得
  Future<void> fetchWeather(String cityName) async {
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
          state = AsyncData(Result.failure(error));
        },
      );
    } on DioException catch (e) {
      // DioExceptionをキャッチし、エラーハンドラーを使用して適切なApiErrorを生成
      final dioErrorHandler = ref.read(dioErrorHandlerProvider);
      final apiError = dioErrorHandler.handle(e);
      state = AsyncData(Result.failure(apiError));
    } catch (e) {
      // その他のエラー処理
      state = AsyncData(Result.failure(
          ApiError(type: ApiErrorType.unknown, message: e.toString())));
    }
  }
}
