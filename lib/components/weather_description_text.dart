import 'package:flutter/material.dart';

import '../core/strings/weather_description_text_strings.dart';

/// [WeatherDescriptionText]は、天気の説明を表示するためのテキストウィジェットです。
class WeatherDescriptionText extends StatelessWidget {
  final String weatherDescription;
  const WeatherDescriptionText({super.key, required this.weatherDescription});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${WeatherDescriptionTextStrings.textLabelWeatherDescription} $weatherDescription',
      style: const TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
    );
  }
}
