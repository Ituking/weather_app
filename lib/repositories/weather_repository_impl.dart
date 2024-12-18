import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/env.dart';
import '../core/logger/logger_provider.dart';
import '../core/network/api_error.dart';
import '../core/network/response/result.dart';
import '../core/network/response/weather_response.dart';
import '../services/weather_api_client.dart';
import '../view_model/providers/dio_error_handler_provider.dart';
import 'weather_repository.dart';

// WeatherRepositoryImplクラスは、WeatherRepositoryインターフェースの具体的な実装を提供します。
// WeatherApiClientを使用して、指定された都市の天気データを取得します。
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiClient apiClient;
  final Ref ref;

  // WeatherRepositoryImplのコンストラクタ。
  // [apiClient] と [ref] を受け取り、フィールドに設定します。
  WeatherRepositoryImpl({required this.apiClient, required this.ref});

  // 指定された都市名 [cityName] の天気データを取得し、WeatherListに変換して返します。
  // データ取得または変換に失敗した場合は例外をスローします。
  // [cityName] - 天気データを取得する都市の名前
  // 戻り値 - 取得した天気データを含むWeatherResponseオブジェクト
  // 例外 - データ取得または変換に失敗した場合に例外をスロー
  @override
  Future<Result<WeatherResponse>> getWeather(String cityName) async {
    final logger = ref.read(loggerProvider);

    try {
      // WeatherApiClientを使用して指定された都市の天気データを取得
      final WeatherResponse weatherResponse = await apiClient.fetchWeather(
        cityName,
        Env.openWeatherMapApiKeyDev,
        'ja',
        'metric',
      );

      // 取得した天気データを成功結果として返す
      return Result.success(weatherResponse);
    } on DioException catch (e, stackTrace) {
      // DioExceptionをキャッチし、エラーハンドラーを使用して適切なApiErrorを生成
      final dioErrorHandler = ref.read(dioErrorHandlerProvider);
      final apiError = dioErrorHandler.handle(e);

      logger.logError(
        'DioException in getWeather: ${e.message}, Response: ${e.response?.data}',
        stackTrace,
      );

      return Result.failure(apiError);
    } catch (e, stackTrace) {
      logger.logError(
        'Unexpected error in getWeather: $e',
        stackTrace,
      );

      // その他のエラー処理
      return Result.failure(
          ApiError(type: ApiErrorType.unknown, message: e.toString()));
    }
  }
}
