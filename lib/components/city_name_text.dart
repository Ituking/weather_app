import 'package:flutter/material.dart';

// CityNameTextは、都市名を表示するためのテキストウィジェット
class CityNameText extends StatelessWidget {
  final String cityName;
  const CityNameText({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Text(
      cityName,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
