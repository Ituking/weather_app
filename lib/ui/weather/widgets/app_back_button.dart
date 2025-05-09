import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_elevated_button.dart';

/// [AppBackButton]は、天気検索画面に遷移するボタンです。
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppElevatedButton(
      text: l10n.backButtonLabel,
      onPressed: () => context.go('/'),
    );
  }
}
