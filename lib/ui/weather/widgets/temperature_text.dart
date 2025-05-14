import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [TemperatureText]は、気温を表示するためのテキストウィジェットです。
class TemperatureText extends StatelessWidget {
  final double temperature;
  const TemperatureText({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(
      '${temperature.toStringAsFixed(1)} ${l10n.temperatureUnit}',
      style: const TextStyle(
        fontSize: 26,
        color: Colors.white,
      ),
    );
  }
}
