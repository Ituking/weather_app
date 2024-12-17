import 'package:flutter/material.dart';

import '../core/strings/wind_speed_text_strings.dart';

// WindSpeedTextは、風速を表示するためのテキストウィジェット
class WindSpeedText extends StatelessWidget {
  final double windSpeed;
  const WindSpeedText({super.key, required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${WindSpeedTextStrings.textLabelWindSpeed} ${windSpeed.toStringAsFixed(1)}${WindSpeedTextStrings.unitMetersPerSecond}',
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}
