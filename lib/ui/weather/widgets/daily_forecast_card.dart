import 'package:flutter/material.dart';

import 'weather_icon.dart';

class DailyForecastCard extends StatelessWidget {
  final double temperature;
  final String description;
  final String iconCode;

  const DailyForecastCard({
    super.key,
    required this.temperature,
    required this.description,
    required this.iconCode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: WeatherIcon(iconCode: "$iconCode@2x"),
        title: Text('$temperature°C'),
        subtitle: Text(description),
      ),
    );
  }
}
