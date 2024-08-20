import 'package:flutter/material.dart';

// WindSpeedTextは、風速を表示するためのテキストウィジェット
class WindSpeedText extends StatelessWidget {
  final double windSpeed;
  const WindSpeedText({super.key, required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    return Text(
      '風速: ${windSpeed.toStringAsFixed(1)}m/s',
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}
