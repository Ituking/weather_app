import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_main.freezed.dart';
part 'weather_main.g.dart';

/// [WeatherMain]クラスは、天気データの中の「メイン」データ（温度や湿度など）を表します。
@freezed
class WeatherMain with _$WeatherMain {
  /// コンストラクタ。温度[temp]と湿度[humidity]を受け取ります。
  factory WeatherMain({
    /// 温度を表します。
    required double temp,

    /// 湿度を表します。
    required int humidity,
  }) = _WeatherMain;

  /// JSONから[WeatherMain]インスタンスを生成するファクトリメソッド。
  factory WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);
}
