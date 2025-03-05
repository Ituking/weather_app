import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/logger/logger_provider.dart';
import '../core/network/api_error.dart';
import '../core/network/response/result.dart';
import '../core/network/response/weather_response.dart';
import '../services/i_weather_api_client.dart';
import 'weather_repository.dart';

/// 天気データを取得するリポジトリの実装クラス。
/// [WeatherRepository]インターフェースを実装し、
/// [IWeatherApiClient]を使用して指定された都市の天気情報を取得します。
class WeatherRepositoryImpl implements WeatherRepository {
  final IWeatherApiClient apiClient;
  final Ref ref;

  WeatherRepositoryImpl({required this.apiClient, required this.ref});

  /// 指定された都市名[cityName]の天気データを取得します。
  ///
  /// [cityName] - 天気データを取得する都市の名前。
  /// 戻り値 - [Result]オブジェクトで、成功時には[WeatherResponse]を含みます。
  @override
  Future<Result<WeatherResponse>> getWeather(String cityName) async {
    final logger = ref.read(loggerProvider);

    try {
      final result = await apiClient.fetchWeather(cityName);
      return result;
    } on FirebaseFunctionsException catch (e, stackTrace) {
      logger.logError(
        'FirebaseFunctionsException in getWeather: ${e.message}',
        stackTrace,
      );

      return Result.failure(ApiError(
        type: ApiErrorType.internalServerError,
        message: e.message ?? 'Unknown Firebase error',
      ));
    } catch (e, stackTrace) {
      logger.logError(
        'Unexpected error in getWeather: $e',
        stackTrace,
      );

      return Result.failure(ApiError(
        type: ApiErrorType.unknown,
        message: e.toString(),
      ));
    }
  }
}
