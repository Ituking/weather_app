import 'package:freezed_annotation/freezed_annotation.dart';

import '../weather_description.dart';
import '../weather_list.dart';
import '../weather_main.dart';
import '../weather_wind.dart';

class WeatherListConverter
    implements JsonConverter<WeatherList, Map<String, dynamic>?> {
  const WeatherListConverter();

  @override
  WeatherList fromJson(Map<String, dynamic>? json) => WeatherList(
        main: WeatherMain(
          temp: (json?['temperature'] as num?)?.toDouble() ?? 0.0,
          humidity: json?['humidity'] as int? ?? 0,
        ),
        weather: [
          WeatherDescription(
            description: json?['description'] as String? ?? '不明',
            icon: '01d', // `icon` はFirestoreには存在しないため仮のデータ
          )
        ],
        wind: WeatherWind(
          speed: (json?['windSpeed'] as num?)?.toDouble() ?? 0.0,
        ),
      );

  @override
  Map<String, dynamic> toJson(WeatherList weatherList) => {
        'temperature': weatherList.main.temp,
        'humidity': weatherList.main.humidity,
        'description': weatherList.weather.first.description,
        'windSpeed': weatherList.wind.speed,
      };
}
