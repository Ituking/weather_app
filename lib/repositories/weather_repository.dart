import '../core/network/response/result.dart';
import '../core/network/response/weather_response.dart';

/// 天気データを取得するためのインターフェース。
abstract class WeatherRepository {
  /// 指定された都市名の天気データを取得します。
  ///
  /// [cityName] : 天気データを取得する都市の名前。
  Future<Result<WeatherResponse>> getWeather(String cityName);
}
