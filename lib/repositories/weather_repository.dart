import '../core/network/response/result.dart';
import '../core/network/response/weather_response.dart';

// WeatherRepositoryインターフェースは、天気データを取得するための契約を定義します。
// 具体的な実装クラスは、このインターフェースを実装し、天気データの取得ロジックを提供します。
abstract class WeatherRepository {
  // 指定された都市名 [cityName] の天気データを取得します。
  // 成功した場合は [WeatherResponse] のインスタンスを返します。
  // データ取得または変換に失敗した場合は例外をスローします。
  //
  // [cityName] - 天気データを取得する都市の名前
  // 戻り値 - 取得した天気データを含む Future<Result<WeatherResponse>>
  Future<Result<WeatherResponse>> getWeather(String cityName);
}
