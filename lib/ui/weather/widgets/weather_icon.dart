import 'package:flutter/material.dart';

/// [WeatherIcon]は、天気アイコンを表示するウィジェットです。
class WeatherIcon extends StatelessWidget {
  final String iconCode;
  final double size;

  const WeatherIcon({
    super.key,
    required this.iconCode,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    // アイコンのURLを生成
    final iconUrl = 'https://openweathermap.org/img/wn/$iconCode.png';

    return Image.network(
      iconUrl,
      width: size,
      height: size,
    );
  }
}
