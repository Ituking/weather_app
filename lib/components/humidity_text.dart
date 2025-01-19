import 'package:flutter/material.dart';

import '../core/strings/humidity_text_strings.dart';

/// [HumidityText]は、湿度を表示するためのテキストウィジェットです。
class HumidityText extends StatelessWidget {
  final int humidity;
  const HumidityText({super.key, required this.humidity});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${HumidityTextStrings.textLabelHumidity} $humidity${HumidityTextStrings.unitPercentage}',
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}
