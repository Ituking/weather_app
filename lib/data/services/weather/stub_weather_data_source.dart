import '../../../../core/network/api_error.dart';
import '../../../../core/network/response/result.dart';
import 'i_weather_api_client.dart';

/// [StubWeatherDataSource]クラスは、[IWeatherApiClient]のスタブ実装です。
///
/// テスト目的で使用され、固定されたデータを返します。
class StubWeatherDataSource implements IWeatherApiClient {
  @override
  Future<Result<Map<String, dynamic>>> fetchWeather(String cityName) async {
    // 無効な都市名が指定された場合、エラーレスポンスを返す
    if (cityName == 'InvalidCity') {
      return Result.failure(ApiError(
        type: ApiErrorType.unknown,
        message: 'Failed to fetch weather data',
      ));
    }

    // 有効な都市名が指定された場合、固定された天気データを返します。
    return Result.success(
      {
        'current': {
          'id': 'stub_id_123',
          'city': cityName,
          'description': 'Sunny',
          'temperature': 20.0,
          'humidity': 70.0,
          'windSpeed': 5.0,
          'icon': '01d',
          'timestamp': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        },
        'forecast': [
          {
            'id': 'stub_forecast_1',
            'city': cityName,
            'description': 'Sunny',
            'temperature': 21.0,
            'humidity': 68.0,
            'windSpeed': 4.5,
            'icon': '01d',
            'timestamp':
                DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch ~/
                    1000,
          },
        ],
      },
    );
  }
}
