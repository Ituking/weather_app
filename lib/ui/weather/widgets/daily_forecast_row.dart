import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'weather_icon.dart';

class DailyForecastRow extends StatelessWidget {
  final String dayLabel;
  final double minTemperature;
  final double maxTemperature;
  final String description;
  final String iconCode;

  const DailyForecastRow({
    super.key,
    required this.dayLabel,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
    required this.iconCode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WeatherIcon(
            iconCode: "$iconCode@2x",
            size: 50,
          ),
          const Gap(12),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(4),
                Text(
                  'Min: ${minTemperature.floor()}°C  Max: ${maxTemperature.floor()}°C',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                description,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
