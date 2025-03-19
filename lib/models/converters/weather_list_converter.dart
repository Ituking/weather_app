import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../weather_description.dart';
import '../weather_list.dart';
import '../weather_main.dart';
import '../weather_wind.dart';

class WeatherListConverter
    implements JsonConverter<List<WeatherList>, List<dynamic>?> {
  const WeatherListConverter();

  @override
  List<WeatherList> fromJson(List<dynamic>? json) {
    debugPrint('Received JSON for WeatherListConverter: $json');

    if (json == null || json.isEmpty) {
      debugPrint('JSON data is null or empty.');
      return [];
    }

    return json.map((entry) {
      final weatherData = (entry['weather'] as List<dynamic>?) ?? [];
      debugPrint('Entry Data: $entry');
      debugPrint('Weather Data: $weatherData');

      return WeatherList(
        main: WeatherMain(
          temp: (entry['main']?['temp'] as num?)?.toDouble() ?? 0.0,
          humidity: entry['main']?['humidity'] as int? ?? 0,
        ),
        weather: weatherData
            .map((weatherEntry) => WeatherDescription(
                  description: weatherEntry['description'] as String? ?? '不明',
                  icon: weatherEntry['icon'] as String? ?? '01d',
                ))
            .toList(),
        wind: WeatherWind(
          speed: (entry['wind']?['speed'] as num?)?.toDouble() ?? 0.0,
        ),
      );
    }).toList();
  }

  @override
  List<dynamic> toJson(List<WeatherList> weatherList) => weatherList
      .map((weather) => {
            'main': {
              'temp': weather.main.temp,
              'humidity': weather.main.humidity,
            },
            'weather': weather.weather
                .map((w) => {
                      'description': w.description,
                      'icon': w.icon,
                    })
                .toList(),
            'wind': {
              'speed': weather.wind.speed,
            }
          })
      .toList();
}
