import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/strings/app_back_button_strings.dart';
import '../../core/widgets/app_elevated_button.dart';

/// [AppBackButton]は、天気検索画面に遷移するボタンです。
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      text: AppBackButtonStrings.buttonLabelBack,
      onPressed: () => context.go('/'),
    );
  }
}
