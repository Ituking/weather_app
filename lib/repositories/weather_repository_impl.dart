import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_client.dart';

// WeatherRepositoryImplクラスは、WeatherRepositoryインターフェースの具体的な実装を提供します。
// WeatherApiClientを使用して、指定された都市の天気データを取得します。
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiClient apiClient;

  // WeatherRepositoryImplのコンストラクタ。
  // [apiClient]を受け取り、フィールドに設定します。
  WeatherRepositoryImpl({required this.apiClient});

  // 指定された都市名 [cityName] の天気データを取得し、WeatherModelに変換して返します。
  // データ取得または変換に失敗した場合は例外をスローします。
  //
  // [cityName] - 天気データを取得する都市の名前
  // 戻り値 - 取得した天気データを含むWeatherModel
  // 例外 - データ取得または変換に失敗した場合に例外をスロー
  @override
  Future<WeatherModel> getWeather(String cityName) async {
    try {
      // WeatherApiClientを使用して指定された都市の天気データを取得
      final jsonData = await apiClient.fetchWeather(cityName);
      // 取得したJSONデータをWeatherModelに変換して返す
      return WeatherModel.fromJson(jsonData);
    } catch (e) {
      // データ取得または変換に失敗した場合は例外をスロー
      throw Exception('Failed to load weather data: $e');
    }
  }
}
