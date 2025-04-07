import '../../../core/network/api_error.dart';
import '../../../core/network/response/result.dart';
import '../models/forecast.dart';
import 'i_weather_api_client.dart';

/// [StubWeatherDataSource]クラスは、[IWeatherApiClient]のスタブ実装です。
///
/// テスト目的で使用され、固定されたデータを返します。
class StubWeatherDataSource implements IWeatherApiClient {
  @override
  Future<Result<Forecast>> fetchWeather(String cityName) async {
    // 無効な都市名が指定された場合、エラーレスポンスを返す
    if (cityName == 'InvalidCity') {
      return Result.failure(ApiError(
        type: ApiErrorType.unknown,
        message: 'Failed to fetch weather data',
      ));
    }

    // 有効な都市名が指定された場合、固定された天気データを返します。
    return Result.success(Forecast(
      id: 'stub_id_123',
      city: cityName, // 都市名
      description: 'Sunny', // 天気の説明
      temperature: 20.0, // 気温
      humidity: 70.0, // 湿度
      windSpeed: 5.0, // 風速
    ));
  }
}
