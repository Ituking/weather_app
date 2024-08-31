import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/view_model/providers/city_name_validator_provider.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';
import 'package:weather_app/view_model/providers/text_editing_controller_provider.dart';

// CitySearchButtonウィジェットは、都市名の検索ボタンを提供します。
class CitySearchButton extends ConsumerWidget {
  const CitySearchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(citySearchViewModelProvider.notifier);
    final state = ref.watch(citySearchViewModelProvider);
    final controller = ref.watch(textEditingControllerProvider);

    // バリデーションプロバイダを使用して入力が有効かどうかをチェック
    final isVailed = ref.watch(cityNameValidatorProvider
        .select((value) => value.validate(controller.text)));

    // 現在のテーマデータを取得してスタイリングに使用
    final theme = Theme.of(context);

    return ElevatedButton(
      // ボタンが押されたときの動作。ローディング中は無効化
      onPressed: state.isLoading || !isVailed
          ? null
          : () async {
              final cityName = controller.text;

              // 入力が空でないことを確認し、天気情報を取得する
              if (cityName.isNotEmpty) {
                viewModel
                    .fetchWeather()
                    .then((_) => context.go('/result/$cityName'));
              }
            },
      // ボタンのスタイルを定義。テーマから色を取得し、最小サイズを設定
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // フォアグラウンドカラーを白に設定
        backgroundColor: theme.primaryColor, // 背景色をテーマのプライマリカラーに設定
        minimumSize: const Size.fromHeight(50), // ボタンの最小サイズを高さ50に設定
      ),
      // ローディング状態に応じて子ウィジェットを切り替え
      child: state.isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ) // ローディング中はCircularProgressIndicatorを表示
          : const Text(
              'Search',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ), // 通常時は"Search"テキストを表示
    );
  }
}
