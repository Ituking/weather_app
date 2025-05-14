import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [WeatherDescriptionText]は、天気の説明を表示するためのテキストウィジェットです。
class WeatherDescriptionText extends StatelessWidget {
  final String weatherDescription;
  const WeatherDescriptionText({super.key, required this.weatherDescription});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(
      '${l10n.weatherDescriptionLabel} $weatherDescription',
      style: const TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
    );
  }
}
