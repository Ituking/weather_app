import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/core/network/response/weather_list.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

// `WeatherResponse` クラスは、天気情報のレスポンス全体を表します。
@freezed
class WeatherResponse with _$WeatherResponse {
  // コンストラクタ。リスト [list] を受け取ります。
  factory WeatherResponse({
    required List<WeatherList> list, // 天気情報のリストを表します。
  }) = _WeatherResponse;

  // JSON から `WeatherResponse` インスタンスを生成するファクトリメソッド。
  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
