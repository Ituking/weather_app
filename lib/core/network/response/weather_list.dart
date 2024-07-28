import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/models/weather_main.dart';
import 'package:weather_app/models/weather_description.dart';
import 'package:weather_app/models/weather_wind.dart';

part 'weather_list.freezed.dart';
part 'weather_list.g.dart';

// `WeatherList` クラスは、天気情報のリスト項目を表します。
@freezed
class WeatherList with _$WeatherList {
  // コンストラクタ。メイン情報 [main]、天気の詳細 [weather]、風情報 [wind] を受け取ります。
  factory WeatherList({
    required WeatherMain main, // メインの天気情報を表します。
    required List<WeatherDescription> weather, // 天気の詳細情報を表します。
    required WeatherWind wind, // 風の情報を表します。
  }) = _WeatherList;

  // JSON から `WeatherList` インスタンスを生成するファクトリメソッド。
  factory WeatherList.fromJson(Map<String, dynamic> json) =>
      _$WeatherListFromJson(json);
}
