import 'package:cloud_functions/cloud_functions.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/network/response/result.dart';
import '../../../../domain/models/weather/models/forecast.dart';
import 'i_weather_api_client.dart';

/// [FirebaseFunctions]を利用するAPIクライアント
class WeatherApiClient implements IWeatherApiClient {
  final FirebaseFunctions _functions;

  WeatherApiClient(this._functions);

  /// 指定された都市の天気情報を[FirebaseFunctions]経由で取得
  @override
  Future<Result<Forecast>> fetchWeather(String cityName) async {
    try {
      final callable = _functions.httpsCallable('getWeatherForCity');
      final response = await callable.call({'city': cityName});

      final forecast = Forecast(
        id: response.data['id'] ?? '',
        city: response.data['city'] ?? '不明な都市',
        description: response.data['description'] ?? '情報なし',
        temperature: (response.data['temperature'] as num?)?.toDouble() ?? 0.0,
        humidity: (response.data['humidity'] as num?)?.toDouble() ?? 0.0,
        windSpeed: (response.data['windSpeed'] as num?)?.toDouble() ?? 0.0,
        icon: response.data['icon'] ?? '',
      );

      return Result.success(forecast);
    } on FirebaseFunctionsException catch (e) {
      return Result.failure(ApiError(
          type: ApiErrorType.internalServerError,
          message: e.message ?? 'Unknown Firebase error'));
    } catch (e) {
      return Result.failure(
          ApiError(type: ApiErrorType.unknown, message: e.toString()));
    }
  }
}
