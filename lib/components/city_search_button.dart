import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';

class CitySearchButton extends ConsumerWidget {
  const CitySearchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ViewModelと状態をProviderから取得
    final viewModel = ref.watch(citySearchViewModelProvider.notifier);
    final state = ref.watch(citySearchViewModelProvider);

    // 現在のテーマデータを取得してスタイリングに使用
    final theme = Theme.of(context);

    return ElevatedButton(
      // ボタンが押されたときの動作。ローディング中は無効化
      onPressed: state.isLoading ? null : () => viewModel.fetchWeather(),
      // ボタンのスタイルを定義。テーマから色を取得し、最小サイズを設定
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: theme.primaryColor,
        minimumSize: const Size.fromHeight(50),
      ),
      // ローディング状態に応じて子ウィジェットを切り替え
      child: state.isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text('Search',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    );
  }
}
