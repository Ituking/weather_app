import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/core/network/response/weather_response.dart';
import 'package:weather_app/models/city_name.dart';
import 'package:weather_app/models/weather_description.dart';
import 'package:weather_app/models/weather_main.dart';
import 'package:weather_app/models/weather_wind.dart';
import 'package:weather_app/services/weather_api_client.dart';

// StubWeatherDataSourceクラスは、WeatherApiClientインターフェースのスタブ実装です。
// テスト目的で使用され、固定されたデータを返します。
class StubWeatherDataSource implements WeatherApiClient {
  @override
  // fetchWeatherメソッドは、指定された都市名、APIキー、言語、単位を使用して
  // 天気情報を取得するメソッドです。このスタブ実装では固定されたデータを返します。
  Future<WeatherResponse> fetchWeather(
      String cityName, String apiKey, String lang, String units) async {
    // 無効な都市名が指定された場合、例外をスローします。
    if (cityName == 'InvalidCity') {
      throw Exception('Failed to fetch weather data');
    }

    // 有効な都市名が指定された場合、固定された天気データを返します。
    return WeatherResponse(
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
    );
  }
}
