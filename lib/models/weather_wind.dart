import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_wind.freezed.dart';
part 'weather_wind.g.dart';

// `WeatherWind` クラスは、風の情報を表します。
@freezed
class WeatherWind with _$WeatherWind {
  // コンストラクタ。風速 [speed] を受け取ります。
  factory WeatherWind({
    required double speed, // 風速を表します。
  }) = _WeatherWind;

  // JSON から `WeatherWind` インスタンスを生成するファクトリメソッド。
  factory WeatherWind.fromJson(Map<String, dynamic> json) =>
      _$WeatherWindFromJson(json);
}
