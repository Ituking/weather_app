import 'package:freezed_annotation/freezed_annotation.dart';

// freezedとjson_serializableの自動生成ファイルへの参照
part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

// `freezed`アノテーションを使用して不変のデータクラスを定義
@freezed
class WeatherModel with _$WeatherModel {
  // WeatherModelのコンストラクタ。各フィールドは必須。
  const factory WeatherModel({
    required double temperature, // 温度
    required String description, // 天気の説明
    required double windSpeed, // 風速
    required int humidity, // 湿度
    required String cityName, // 都市名
  }) = _WeatherModel;

  // JSONからWeatherModelのインスタンスを生成するファクトリメソッド
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}
