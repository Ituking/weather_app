import '../../../core/network/response/api_result.dart';

/// 天気データを取得するAPIクライアントのインターフェース
abstract class IWeatherApiClient {
  /// 指定された都市の天気情報を取得する
  Future<ApiResult<Map<String, dynamic>>> fetchWeather(String cityName);
}
