import 'package:freezed_annotation/freezed_annotation.dart';

import '../weather_description.dart';
import '../weather_list.dart';
import '../weather_main.dart';
import '../weather_wind.dart';

class WeatherListConverter
    implements JsonConverter<WeatherList, Map<String, dynamic>?> {
  const WeatherListConverter();

  @override
  WeatherList fromJson(Map<String, dynamic>? json) {
    final weatherData = json?['weather'];

    final weatherDescription = (weatherData is String)
        ? weatherData
        : weatherData?['description'] as String? ?? '不明';

    return WeatherList(
      main: WeatherMain(
        temp: (json?['temperature'] as num?)?.toDouble() ?? 0.0,
        humidity: json?['humidity'] as int? ?? 0,
      ),
      weather: WeatherDescription(
        description: weatherDescription,
        icon: weatherData is Map<String, dynamic>
            ? weatherData['icon'] as String? ?? '01d'
            : '01d',
      ),
      wind: WeatherWind(
        speed: (json?['windSpeed'] as num?)?.toDouble() ?? 0.0,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson(WeatherList weatherList) => {
        'temperature': weatherList.main.temp,
        'humidity': weatherList.main.humidity,
        'weather': {
          'description': weatherList.weather.description,
          'icon': weatherList.weather.icon,
        },
        'windSpeed': weatherList.wind.speed,
      };
}
