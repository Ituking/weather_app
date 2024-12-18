import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/app_back_button.dart';
import '../../components/background_image.dart';
import '../../core/strings/dio_error_handler_strings.dart';
import '../../view_model/providers/error_view_model_provider.dart';

// ErrorDisplayScreenは、APIからのエラーメッセージを取得し、それを画面中央に表示する画面です。
class ErrorDisplayScreen extends ConsumerWidget {
  const ErrorDisplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ErrorViewModelからエラー情報を取得
    final error = ref.watch(errorViewModelProvider).error;

    // エラーメッセージがnullの場合、デフォルトメッセージを表示
    final errorMessage = error?.message ?? DioErrorHandlerStrings.unknownError;

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
                  errorMessage,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const AppBackButton(), // 戻るボタン
              ],
            ),
          ),
        ],
      ),
    );
  }
}
