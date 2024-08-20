import 'package:flutter/material.dart';

// HumidityTextは、湿度を表示するためのテキストウィジェット
class HumidityText extends StatelessWidget {
  final int humidity;
  const HumidityText({super.key, required this.humidity});

  @override
  Widget build(BuildContext context) {
    return Text(
      '湿度: $humidity%',
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}
