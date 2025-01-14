import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/city_name.dart';
import 'weather_list.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

// `WeatherResponse` クラスは、天気情報のレスポンス全体を表します。
@freezed
class WeatherResponse with _$WeatherResponse {
  // コンストラクタ。天気情報のリスト [list] と都市情報 [city] を受け取ります。
  factory WeatherResponse({
    required List<WeatherList> list, // 天気情報のリストを表します。
    required CityName city, // 都市の情報を表します。
  }) = _WeatherResponse;

  // JSON から `WeatherResponse` インスタンスを生成するファクトリメソッド。
  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
