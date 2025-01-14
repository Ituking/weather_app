import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/api_config.dart';
import '../core/logger/logger_provider.dart';
import '../core/network/api_error.dart';
import '../core/network/response/result.dart';
import '../core/network/response/weather_response.dart';
import '../services/weather_api_client.dart';
import '../view_model/providers/dio_error_handler_provider.dart';
import 'weather_repository.dart';

/// 天気データを取得するリポジトリの実装クラス。
/// [WeatherRepository] インターフェースを実装し、
/// [WeatherApiClient] を使用して指定された都市の天気情報を取得します。
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiClient apiClient;
  final ApiConfig apiConfig;
  final Ref ref;

  WeatherRepositoryImpl(
      {required this.apiClient, required this.apiConfig, required this.ref});

  /// 指定された都市名 [cityName] の天気データを取得します。
  ///
  /// [cityName] - 天気データを取得する都市の名前。
  /// 戻り値は [Result] オブジェクトで、成功時には [WeatherResponse] を含みます。
  /// エラー発生時には適切な [ApiError] を返します。
  @override
  Future<Result<WeatherResponse>> getWeather(String cityName) async {
    final logger = ref.read(loggerProvider);

    try {
      // WeatherApiClientを使用して指定された都市の天気データを取得
      final WeatherResponse weatherResponse = await apiClient.fetchWeather(
        cityName,
        apiConfig.apiKey,
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
