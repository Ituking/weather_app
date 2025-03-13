import '../core/network/response/result.dart';
import '../core/network/response/weather_response.dart';

/// Firestoreから天気データを取得するためのリポジトリインターフェース。
///
/// Firestoreから指定された都市の最新の天気データを取得します。
/// データが存在しない場合は失敗として処理します。
abstract class FirestoreWeatherRepository {
  /// 指定された都市名の天気データを取得します。
  ///
  /// [cityName] : 天気データを取得する都市の名前。
  ///
  /// 戻り値 :
  /// - 成功時は [WeatherResponse] を含む [Result.success]。
  /// - データが存在しない場合やエラー発生時は [ApiError] を含む [Result.failure]。
  Future<Result<WeatherResponse>> getWeather(String cityName);
}
