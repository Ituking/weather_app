import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/extensions/api_error_ui_message.dart';
import '../../../../view_model/providers/error_view_model_provider.dart';
import '../../components/app_back_button.dart';
import '../../components/background_image.dart';

/// [ErrorDisplayScreen]は、APIからのエラーメッセージを取得し、それを画面中央に表示する画面です。
class ErrorDisplayScreen extends ConsumerWidget {
  const ErrorDisplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ErrorViewModelからエラー情報を取得
    final error = ref.watch(errorViewModelProvider).error;

    final errorMessage = error?.uiMessage;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // エラーメッセージを表示
                Text(
                  errorMessage ?? '予期しないエラーが発生しました。',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(20),
                const AppBackButton(), // 戻るボタン
              ],
            ),
          ),
        ],
      ),
    );
  }
}
