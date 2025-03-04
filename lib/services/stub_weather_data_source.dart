import 'package:weather_app/core/network/response/result.dart';

import '../core/network/api_error.dart';
import '../core/network/response/weather_list.dart';
import '../core/network/response/weather_response.dart';
import '../models/city_name.dart';
import '../models/weather_description.dart';
import '../models/weather_main.dart';
import '../models/weather_wind.dart';
import 'i_weather_api_client.dart';

/// [StubWeatherDataSource]クラスは、[IWeatherApiClient]のスタブ実装です。
///
/// テスト目的で使用され、固定されたデータを返します。
class StubWeatherDataSource implements IWeatherApiClient {
  @override
  Future<Result<WeatherResponse>> fetchWeather(String cityName) async {
    // 無効な都市名が指定された場合、エラーレスポンスを返す
    if (cityName == 'InvalidCity') {
      return Result.failure(ApiError(
        type: ApiErrorType.unknown,
        message: 'Failed to fetch weather data',
      ));
    }

    // 有効な都市名が指定された場合、固定された天気データを返します。
    return Result.success(WeatherResponse(
      list: [
        WeatherList(
          main: WeatherMain(temp: 20.0, humidity: 70), // 気温と湿度
          weather: [
            WeatherDescription(
              description: 'Sunny',
              icon: '01d',
            ),
          ], // 天気の説明
          wind: WeatherWind(speed: 5.0), // 風速
        ),
      ],
      city: CityName(name: cityName), // 都市名
    ));
  }
}
