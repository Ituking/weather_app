import 'package:freezed_annotation/freezed_annotation.dart';

import '../weather_main.dart';

class WeatherMainConverter
    implements JsonConverter<WeatherMain, Map<String, dynamic>?> {
  const WeatherMainConverter();

  @override
  WeatherMain fromJson(Map<String, dynamic>? json) => WeatherMain(
        temp: (json?['temperature'] as num?)?.toDouble() ?? 0.0,
        humidity: json?['humidity'] as int? ?? 0,
      );

  @override
  Map<String, dynamic> toJson(WeatherMain main) => {
        'temperature': main.temp,
        'humidity': main.humidity,
      };
}
