import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';

// CitySearchInputウィジェットは、都市名の検索入力フィールドを提供します。
class CitySearchInput extends ConsumerWidget {
  const CitySearchInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // citySearchViewModelProviderからViewModelを取得します。
    final viewModel = ref.watch(citySearchViewModelProvider.notifier);
    // 現在のテーマデータを取得します。
    final theme = Theme.of(context);

    // テキスト入力フィールドを構築します。
    return TextFormField(
      // 入力フィールドのデコレーションを設定します。
      decoration: InputDecoration(
        filled: true, // 背景を塗りつぶします。
        fillColor: Colors.white.withOpacity(0.8), // 背景色を白の半透明に設定します。
        hintText: 'Tokyo', // ヒントテキストを設定します。
        labelStyle:
            TextStyle(color: theme.hintColor), // ラベルスタイルをテーマのヒントカラーに設定します。
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // 境界線を丸くします。
          borderSide: BorderSide.none, // 境界線を非表示にします。
        ),
      ),
      // テキストが変更された時にViewModelのメソッドを呼び出します。
      onChanged: (value) => viewModel.updateCityName(value),
    );
  }
}
