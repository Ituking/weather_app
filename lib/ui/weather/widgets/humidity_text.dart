import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [HumidityText]は、湿度を表示するためのテキストウィジェットです。
class HumidityText extends StatelessWidget {
  final int humidity;
  const HumidityText({super.key, required this.humidity});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(
      '${l10n.humidityLabel} $humidity${l10n.humidityUnit}',
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}
