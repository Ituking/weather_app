import 'package:flutter/material.dart';

import 'weather_icon.dart';

class DailyForecastCard extends StatelessWidget {
  final String dayLabel;
  final double minTemperature;
  final double maxTemperature;
  final String description;
  final String iconCode;

  const DailyForecastCard({
    super.key,
    required this.dayLabel,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
    required this.iconCode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: WeatherIcon(iconCode: "$iconCode@2x"),
        title: Text(dayLabel),
        subtitle: Text(
            'Min: ${minTemperature.toStringAsFixed(1)}°C  Max: ${maxTemperature.toStringAsFixed(1)}°C'),
        trailing: Text(description),
      ),
    );
  }
}
