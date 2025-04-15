import 'package:flutter/material.dart';

/// [WeatherIcon]は、天気アイコンを表示するウィジェットです。
class WeatherIcon extends StatelessWidget {
  final String iconCode;

  const WeatherIcon({super.key, required this.iconCode});

  @override
  Widget build(BuildContext context) {
    // アイコンのURLを生成
    final iconUrl = 'https://openweathermap.org/img/wn/$iconCode.png';

    return Image.network(iconUrl);
  }
}
