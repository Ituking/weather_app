import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_description.freezed.dart';
part 'weather_description.g.dart';

// `WeatherDescription` クラスは、天気の詳細な説明を表します。
@freezed
class WeatherDescription with _$WeatherDescription {
  // コンストラクタ。天気の詳細な説明 [description] を受け取ります。
  factory WeatherDescription({
    required String description, // 天気の詳細な説明を表します。
  }) = _WeatherDescription;

  // JSON から `WeatherDescription` インスタンスを生成するファクトリメソッド。
  factory WeatherDescription.fromJson(Map<String, dynamic> json) =>
      _$WeatherDescriptionFromJson(json);
}
