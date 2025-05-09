import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [WindSpeedText]は、風速を表示するためのテキストウィジェットです。
class WindSpeedText extends StatelessWidget {
  final double windSpeed;
  const WindSpeedText({super.key, required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(
      '${l10n.windSpeedLabel} ${windSpeed.toStringAsFixed(1)}${l10n.windSpeedUnit}',
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}
