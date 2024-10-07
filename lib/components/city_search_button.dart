import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/strings/city_search_button_strings.dart';
import 'package:weather_app/view_model/providers/city_name_validator_provider.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';
import 'package:weather_app/view_model/providers/city_weather_notifier_provider.dart';
import 'package:weather_app/view_model/providers/error_view_model_provider.dart';

import 'package:weather_app/view_model/providers/text_editing_controller_provider.dart';

// CitySearchButtonウィジェットは、都市名の検索ボタンを提供します。
class CitySearchButton extends ConsumerStatefulWidget {
  const CitySearchButton({super.key});

  @override
  ConsumerState<CitySearchButton> createState() => _CitySearchButtonState();
}

class _CitySearchButtonState extends ConsumerState<CitySearchButton> {
  bool isValid = false;
  late TextEditingController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // TextEditingControllerをProviderから取得
    controller = ref.read(textEditingControllerProvider);

    // 都市名のバリデータをProviderから取得
    final validator = ref.read(cityNameValidatorProvider);

    // TextEditingControllerのリスナーを追加して、テキストが変更されるたびにバリデーションを行う
    controller.addListener(() {
      setState(() {
        // 都市名が有効かどうかをチェックし、isValidフラグを更新
        isValid = validator.validate(controller.text);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cityWeatherNotifier = ref.watch(cityWeatherNotifierProvider.notifier);
    final isLoading = ref.watch(citySearchViewModelProvider).isLoading;

    // 現在のテーマデータを取得してスタイリングに使用
    final theme = Theme.of(context);

    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            // ボタンが押されたときの動作
            onPressed: !isValid
                ? null
                : () async {
                    final cityName = controller.text.trim();

                    // 入力が空でないことを確認し、天気情報を取得する
                    if (cityName.isNotEmpty) {
                      await cityWeatherNotifier.fetchWeather(cityName);
                      final weatherResult =
                          ref.read(cityWeatherNotifierProvider);

                      // APIレスポンスから都市名を取得して画面遷移
                      weatherResult.when(
                        data: (result) {
                          result.when(
                            success: (weatherResponse) {
                              final cityNameFromApi = weatherResponse.city.name;
                              ref
                                  .read(citySearchViewModelProvider.notifier)
                                  .navigateToResultScreen(cityNameFromApi);
                            },
                            failure: (error) {
                              final errorMessage = error.message;

                              // エラーメッセージを設定してエラー画面に遷移
                              ref
                                  .read(errorViewModelProvider.notifier)
                                  .setErrorMessage(errorMessage);
                              context.go('/error', extra: errorMessage);
                            },
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (err, stack) {
                          // エラーハンドリング: エラーメッセージを渡してエラー画面に遷移
                          context.go('/error', extra: {
                            'message': err.toString(),
                          });
                        },
                      );
                    }
                  },
            // ボタンのスタイルを定義。テーマから色を取得し、最小サイズを設定
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, // フォアグラウンドカラーを白に設定
              backgroundColor: theme.primaryColor, // 背景色をテーマのプライマリカラーに設定
              minimumSize: const Size.fromHeight(50), // ボタンの最小サイズを高さ50に設定
            ),
            child: const Text(
              CitySearchButtonStrings.buttonLabelSearch,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          );
  }
}
