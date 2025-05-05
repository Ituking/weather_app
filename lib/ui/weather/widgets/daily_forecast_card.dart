import 'package:flutter/material.dart';

import 'daily_forecast_row.dart';

class DailyForecastCard extends StatelessWidget {
  final List<DailyForecastRow> forecastRows;

  const DailyForecastCard({
    super.key,
    required this.forecastRows,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: forecastRows,
        ),
      ),
    );
  }
}
