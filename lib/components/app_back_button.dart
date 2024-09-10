import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// AppBackButtonは、天気検索画面に遷移するボタン
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.go('/');
      },
      child: const Text('戻る'),
    );
  }
}
