import 'package:freezed_annotation/freezed_annotation.dart';

import '../weather_main.dart';

class WeatherMainConverter
    implements JsonConverter<WeatherMain, Map<String, dynamic>> {
  const WeatherMainConverter();

  @override
  WeatherMain fromJson(Map<String, dynamic> json) => WeatherMain.fromJson(json);

  @override
  Map<String, dynamic> toJson(WeatherMain main) => main.toJson();
}
