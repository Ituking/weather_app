import 'package:flutter/material.dart';

import '../core/strings/temperature_text_strings.dart';

/// [TemperatureText]は、気温を表示するためのテキストウィジェットです。
class TemperatureText extends StatelessWidget {
  final double temperature;
  const TemperatureText({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${TemperatureTextStrings.textLabelTemperature} ${temperature.toStringAsFixed(1)} ${TemperatureTextStrings.unitCelsius}',
      style: const TextStyle(
        fontSize: 26,
        color: Colors.white,
      ),
    );
  }
}
