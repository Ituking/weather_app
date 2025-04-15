import 'package:cloud_functions/cloud_functions.dart';

import '../../../../core/logger/app_log.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/network/response/result.dart';
import '../../../../domain/models/weather/models/forecast.dart';
import '../../../services/weather/services/i_weather_api_client.dart';
import 'weather_repository.dart';

/// 天気データを取得するリポジトリの実装クラス。
/// [WeatherRepository]インターフェースを実装し、
/// [IWeatherApiClient]を使用して指定された都市の天気情報を取得します。
class WeatherRepositoryImpl implements WeatherRepository {
  final IWeatherApiClient apiClient;

  WeatherRepositoryImpl({required this.apiClient});

  /// 指定された都市名[cityName]の天気データを取得します。
  ///
  /// [cityName] - 天気データを取得する都市の名前。
  /// 戻り値 - [Result]オブジェクトで、成功時には[Forecast]を含みます。
  @override
  Future<Result<Forecast>> getWeather(String cityName) async {
    try {
      final result = await apiClient.fetchWeather(cityName);

      AppLog.debug(message: 'fetchWeather result: $result');

      final data = result.when(
        success: (weatherResponse) => weatherResponse.toJson(),
        failure: (error) => 'Error: ${error.message}',
      );

      AppLog.debug(message: 'WeatherResponse Data: $data');

      return result;
    } on FirebaseFunctionsException catch (e, stackTrace) {
      AppLog.error(
        message: 'FirebaseFunctionsException in getWeather: ${e.message}',
        exception: e,
        stackTrace: stackTrace,
      );

      return Result.failure(ApiError(
        type: ApiErrorType.internalServerError,
        message: e.message ?? 'Unknown Firebase error',
      ));
    } catch (e, stackTrace) {
      AppLog.error(
        message: 'Unexpected error in getWeather: $e',
        exception: e,
        stackTrace: stackTrace,
      );

      return Result.failure(ApiError(
        type: ApiErrorType.unknown,
        message: e.toString(),
      ));
    }
  }
}
