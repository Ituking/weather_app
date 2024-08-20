import 'package:flutter/material.dart';

// TemperatureTextは、気温を表示するためのテキストウィジェット
class TemperatureText extends StatelessWidget {
  final double temperature;
  const TemperatureText({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Text(
      '気温: ${temperature.toStringAsFixed(1)}°C',
      style: const TextStyle(
        fontSize: 26,
        color: Colors.white,
      ),
    );
  }
}
