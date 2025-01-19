import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/strings/city_search_button_strings.dart';
import '../view_model/providers/city_name_validator_provider.dart';
import '../view_model/providers/city_search_view_model_provider.dart';
import '../view_model/providers/city_weather_notifier_provider.dart';
import '../view_model/providers/error_view_model_provider.dart';
import '../view_model/providers/text_editing_controller_provider.dart';

/// 都市名を検索するボタンウィジェット。
///
/// 入力された都市名をバリデーションし、天気情報を取得して結果画面に遷移します。
/// エラー発生時はエラー画面に遷移します。
class CitySearchButton extends ConsumerStatefulWidget {
  const CitySearchButton({super.key});

  @override
  ConsumerState<CitySearchButton> createState() => _CitySearchButtonState();
}

class _CitySearchButtonState extends ConsumerState<CitySearchButton> {
  /// 入力内容が有効かどうかを示すフラグ。
  bool isValid = false;

  /// 都市名の入力を管理するコントローラー。
  late TextEditingController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // TextEditingControllerをProviderから取得。
    controller = ref.read(textEditingControllerProvider);

    // 都市名のバリデータをProviderから取得し、入力内容の変更を検知してバリデーションを実行。
    final validator = ref.read(cityNameValidatorProvider);
    controller.addListener(() {
      setState(() {
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
    // 状態を取得
    final cityWeatherNotifier = ref.watch(cityWeatherNotifierProvider.notifier);
    final isLoading = ref.watch(citySearchViewModelProvider).isLoading;

    // テーマを取得
    final theme = Theme.of(context);

    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: isValid
                ? () async {
                    final cityName = controller.text.trim();

                    // 入力が空でない場合のみ処理を実行。
                    if (cityName.isNotEmpty) {
                      await cityWeatherNotifier.fetchWeather(cityName);

                      // APIレスポンスに基づいて遷移を制御。
                      final weatherResult =
                          ref.read(cityWeatherNotifierProvider);

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
                              ref
                                  .read(errorViewModelProvider.notifier)
                                  .setErrorMessage(errorMessage);
                              context.go('/error', extra: errorMessage);
                            },
                          );
                        },
                        loading: () =>
                            const CircularProgressIndicator(), // ローディング中。
                        error: (err, stack) {
                          context.go('/error', extra: {
                            'message': err.toString(),
                          });
                        },
                      );
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: theme.colorScheme.onPrimary,
              backgroundColor: theme.primaryColor,
              minimumSize: const Size(200, 50),
              textStyle: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            child: const Text(
              CitySearchButtonStrings.buttonLabelSearch,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          );
  }
}
