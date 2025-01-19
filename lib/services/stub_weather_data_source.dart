import '../core/network/response/weather_list.dart';
import '../core/network/response/weather_response.dart';
import '../models/city_name.dart';
import '../models/weather_description.dart';
import '../models/weather_main.dart';
import '../models/weather_wind.dart';
import 'weather_api_client.dart';

/// [StubWeatherDataSource]クラスは、[WeatherApiClient]インターフェースのスタブ実装です。
///
/// テスト目的で使用され、固定されたデータを返します。
class StubWeatherDataSource implements WeatherApiClient {
  @override

  /// 指定された都市名[cityName]、APIキー[apiKey]、言語[lang]、単位[units]を使用して
  /// 天気情報を取得します。このスタブ実装では固定されたデータを返します。
  ///
  /// - Parameters:
  ///  [cityName] : 取得する都市の名前。
  ///  [apiKey] : 使用するAPIキー。
  ///  [lang] : レスポンスの言語設定。
  ///  [units] : 温度などの単位設定。
  /// - Returns: [WeatherResponse]を含む[Future]。
  /// - Throws: もし[cityName]が`'InvalidCity'`の場合、例外をスローします。
  Future<WeatherResponse> fetchWeather(
    String cityName,
    String apiKey,
    String lang,
    String units,
  ) async {
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
