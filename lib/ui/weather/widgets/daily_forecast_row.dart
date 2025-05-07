import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/daily_forecast_card_theme.dart';
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
    final theme = Theme.of(context).extension<DailyForecastCardTheme>()!;

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
                  style: theme.dayLabelStyle,
                ),
                const Gap(4),
                Text(
                  'Min: ${minTemperature.floor()}°C  Max: ${maxTemperature.floor()}°C',
                  style: theme.tempRangeStyle,
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
                style: theme.descriptionStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
