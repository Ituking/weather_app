import 'package:flutter/material.dart';

// WeatherIconは、天気アイコンを表示するウィジェット
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
