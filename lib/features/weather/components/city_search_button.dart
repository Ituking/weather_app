import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/api_error_ui_message.dart';
import '../../../core/network/api_error.dart';
import '../../../core/strings/city_search_button_strings.dart';
import '../view_model/providers/async_weather_view_model_provider.dart';
import '../view_model/providers/city_name_validator_provider.dart';
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
    final weatherState = ref.watch(asyncWeatherViewModelProvider);
    final isLoading = weatherState.isLoading;
    final theme = Theme.of(context);

    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: isValid
                ? () async {
                    final cityName = controller.text.trim();
                    if (cityName.isEmpty) {
                      return;
                    }

                    final notifier =
                        ref.read(asyncWeatherViewModelProvider.notifier);

                    await notifier.fetchWeather(cityName);

                    final state = ref.read(asyncWeatherViewModelProvider);

                    state.when(
                      data: (forecast) {
                        controller.clear();

                        context.push('/result');
                      },
                      error: (e, _) {
                        final errorMessage =
                            e is ApiError ? e.uiMessage : '不明なエラーが発生しました';
                        ref
                            .read(errorViewModelProvider.notifier)
                            .setErrorMessage(errorMessage);
                        context.go('/error', extra: errorMessage);
                      },
                      loading: () => const CircularProgressIndicator(),
                    );
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
