import '../core/network/response/result.dart';
import '../features/weather/models/forecast.dart';

/// 天気データを取得するAPIクライアントのインターフェース
abstract class IWeatherApiClient {
  /// 指定された都市の天気情報を取得する
  Future<Result<Forecast>> fetchWeather(String cityName);
}
