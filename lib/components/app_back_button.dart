import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/strings/app_back_button_strings.dart';

/// [AppBackButton]は、天気検索画面に遷移するボタンです。
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    // 現在のテーマデータを取得してスタイリングに使用
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: () {
        context.go('/');
      },
      // ボタンのスタイルをテーマに基づいて設定
      style: ElevatedButton.styleFrom(
        foregroundColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.primaryColor,
        minimumSize: const Size(200, 50),
        textStyle:
            theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      child: const Text(
        AppBackButtonStrings.buttonLabelBack,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
