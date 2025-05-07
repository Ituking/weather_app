import 'package:flutter/material.dart';

import '../../../core/theme/daily_forecast_card_theme.dart';
import 'daily_forecast_row.dart';

class DailyForecastCard extends StatelessWidget {
  final List<DailyForecastRow> forecastRows;

  const DailyForecastCard({
    super.key,
    required this.forecastRows,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<DailyForecastCardTheme>()!;

    return Card(
      color: theme.cardColor,
      shape: theme.cardShape,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: theme.cardPadding,
        child: Column(
          children: forecastRows,
        ),
      ),
    );
  }
}
