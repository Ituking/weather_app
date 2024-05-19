import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_api_client.dart';

// WeatherRepositoryクラスは、天気データのデータソースを抽象化し、必要に応じてアプリケーションのロジックに提供します。
class WeatherRepository {
  final WeatherApiClient apiClient;

  // [WeatherApiClient]を使用してデータ取得操作を行う
  // [WeatherRepository]を構築します。
  WeatherRepository({required this.apiClient});

  // 指定された[cityName]の天気データを取得し、[WeatherModel]に変換します。
  // データ取得または変換に失敗した場合は[Exception]をスローします。
  Future<WeatherModel> getWeather(String cityName) async {
    try {
      final jsonData = await apiClient.fetchWeather(cityName);
      return WeatherModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
}
