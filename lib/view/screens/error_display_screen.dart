import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/components/app_back_button.dart';
import 'package:weather_app/core/strings/dio_error_handler_strings.dart';
import 'package:weather_app/view_model/providers/error_view_model_provider.dart';

class ErrorDisplayScreen extends ConsumerWidget {
  const ErrorDisplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(errorViewModelProvider).error;
    final errorMessage = error?.message ?? DioErrorHandlerStrings.unknownError;

    return Scaffold(
      body: Stack(
        children: [
          // 背景に画像を全画面で表示
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              child: Image.asset(
                'assets/images/clouds-4215608_1280.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  errorMessage,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const AppBackButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
