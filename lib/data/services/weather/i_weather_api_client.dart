import '../../../../core/network/response/result.dart';

/// 天気データを取得するAPIクライアントのインターフェース
abstract class IWeatherApiClient {
  /// 指定された都市の天気情報を取得する
  Future<Result<Map<String, dynamic>>> fetchWeather(String cityName);
}
