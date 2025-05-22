import '../../../../domain/models/weather/forecast.dart';
import '../../../core/network/response/api_result.dart';

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
  /// - 成功時は [Forecast] を含む [ApiResult.success]。
  /// - データが存在しない場合やエラー発生時は [ApiError] を含む [ApiResult.failure]。
  Future<ApiResult<List<Forecast>>> fetchForecast(String cityName);
}
