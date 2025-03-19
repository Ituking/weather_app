import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/models/converters/city_name_converter.dart';

import '../../../models/city_name.dart';
import '../../../models/converters/weather_list_converter.dart';
import '../../../models/weather_list.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

/// [WeatherResponse] クラスは、天気情報のレスポンス全体を表します。
@freezed
class WeatherResponse with _$WeatherResponse {
  /// コンストラクタ。
  factory WeatherResponse({
    @WeatherListConverter() required List<WeatherList> list,
    @CityNameConverter() required CityName city,
  }) = _WeatherResponse;

  /// JSON から [WeatherResponse] インスタンスを生成
  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
