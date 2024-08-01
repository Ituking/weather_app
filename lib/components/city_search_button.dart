import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';

// CitySearchButtonウィジェットは、都市名の検索ボタンを提供します。
class CitySearchButton extends ConsumerWidget {
  final TextEditingController controller;

  const CitySearchButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ViewModelと状態をProviderから取得
    final viewModel = ref.watch(citySearchViewModelProvider.notifier);
    final state = ref.watch(citySearchViewModelProvider);

    // 現在のテーマデータを取得してスタイリングに使用
    final theme = Theme.of(context);

    return ElevatedButton(
      // ボタンが押されたときの動作。ローディング中は無効化
      onPressed: state.isLoading
          ? null
          : () async {
              final cityName = controller.text;
              if (cityName.isNotEmpty) {
                // 天気情報を取得し、成功した場合は結果画面に遷移
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
