import 'package:cloud_functions/cloud_functions.dart';

import '../../../../core/logger/app_log.dart';
import '../../../../core/network/api_error.dart';
import '../../../../domain/models/weather/forecast.dart';
import '../../../core/network/response/api_result.dart';
import '../../services/weather/i_weather_api_client.dart';
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
  /// 戻り値 - [ApiResult]オブジェクトで、成功時には[Forecast]を含みます。
  @override
  Future<ApiResult<List<Forecast>>> getWeather(String cityName) async {
    try {
      final result = await apiClient.fetchWeather(cityName);

      AppLog.debug(message: 'fetchWeather result: $result');

      final wrappedResult = result.when<ApiResult<List<Forecast>>>(
        success: (apiData) {
          final current =
              Forecast.fromJson(Map<String, dynamic>.from(apiData['current']));
          final forecastList = (apiData['forecast'] as List)
              .map((item) => Forecast.fromJson(Map<String, dynamic>.from(item)))
              .toList();

          return ApiResult.success([current, ...forecastList]);
        },
        failure: (error) => ApiResult.failure(error),
      );

      return wrappedResult;
    } on FirebaseFunctionsException catch (e, stackTrace) {
      AppLog.error(
        message: 'FirebaseFunctionsException in getWeather: ${e.message}',
        exception: e,
        stackTrace: stackTrace,
      );
      return ApiResult.failure(ApiError(
        type: ApiErrorType.internalServerError,
        message: e.message ?? 'Unknown Firebase error',
      ));
    } catch (e, stackTrace) {
      AppLog.error(
        message: 'Unexpected error in getWeather: $e',
        exception: e,
        stackTrace: stackTrace,
      );
      return ApiResult.failure(
        ApiError(
          type: ApiErrorType.unknown,
          message: e.toString(),
        ),
      );
    }
  }
}
