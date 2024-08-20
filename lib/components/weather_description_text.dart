import 'package:flutter/material.dart';

// WeatherDescriptionTextは、天気の説明を表示するためのテキストウィジェット
class WeatherDescriptionText extends StatelessWidget {
  final String weatherDescription;
  const WeatherDescriptionText({super.key, required this.weatherDescription});

  @override
  Widget build(BuildContext context) {
    return Text(
      '天気: $weatherDescription',
      style: const TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
    );
  }
}
