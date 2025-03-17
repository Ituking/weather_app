import 'package:freezed_annotation/freezed_annotation.dart';

import '../weather_wind.dart';

class WeatherWindConverter
    implements JsonConverter<WeatherWind, Map<String, dynamic>> {
  const WeatherWindConverter();

  @override
  WeatherWind fromJson(Map<String, dynamic> json) => WeatherWind(
        speed: (json['windSpeed'] as num?)?.toDouble() ?? 0.0,
      );

  @override
  Map<String, dynamic> toJson(WeatherWind wind) => {
        'windSpeed': wind.speed,
      };
}
