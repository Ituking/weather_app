import 'package:freezed_annotation/freezed_annotation.dart';

import '../weather_description.dart';

class WeatherDescriptionConverter
    implements JsonConverter<WeatherDescription, Map<String, dynamic>?> {
  const WeatherDescriptionConverter();

  @override
  WeatherDescription fromJson(Map<String, dynamic>? json) => WeatherDescription(
        description: json?['description'] as String? ?? '不明',
        icon: json?['icon'] as String? ?? '01d',
      );

  @override
  Map<String, dynamic> toJson(WeatherDescription description) => {
        'description': description.description,
        'icon': description.icon,
      };
}
