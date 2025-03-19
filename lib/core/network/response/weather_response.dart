import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/models/converters/city_name_converter.dart';

import '../../../models/city_name.dart';
import '../../../models/converters/weather_description_converter.dart';
import '../../../models/converters/weather_main_converter.dart';
import '../../../models/converters/weather_wind_converter.dart';
import '../../../models/weather_description.dart';
import '../../../models/weather_main.dart';
import '../../../models/weather_wind.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

/// [WeatherResponse] クラスは、天気情報のレスポンス全体を表します。
@freezed
class WeatherResponse with _$WeatherResponse {
  /// コンストラクタ。
  factory WeatherResponse({
    @WeatherMainConverter() required WeatherMain main,
    @WeatherDescriptionConverter() required WeatherDescription weather,
    @WeatherWindConverter() required WeatherWind wind,
    @CityNameConverter() required CityName city,
  }) = _WeatherResponse;

  /// JSON から [WeatherResponse] インスタンスを生成
  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
