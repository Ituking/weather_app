import '../../../../domain/models/weather/forecast.dart';
import '../../../core/network/response/api_result.dart';

/// 天気データを取得するためのインターフェース。
abstract class WeatherRepository {
  /// 指定された都市名の天気データを取得します。
  ///
  /// [cityName] : 天気データを取得する都市の名前。
  Future<ApiResult<List<Forecast>>> getWeather(String cityName);
}
