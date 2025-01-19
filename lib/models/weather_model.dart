import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

/// [WeatherModel]クラスは、天気情報を表す不変のデータクラスです。
@freezed
class WeatherModel with _$WeatherModel {
  /// コンストラクタ。各フィールドは必須です。
  const factory WeatherModel({
    /// 温度を表します。
    required double temperature,

    /// 天気の説明を表します。
    required String description,

    /// 風速を表します。
    required double windSpeed,

    /// 湿度を表します。
    required int humidity,

    /// 都市名を表します。
    required String cityName,
  }) = _WeatherModel;

  /// JSONから[WeatherModel]のインスタンスを生成するファクトリメソッド。
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}
