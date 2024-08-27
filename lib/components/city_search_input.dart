import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/validator/validator.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';

// CitySearchInputウィジェットは、都市名の検索入力フィールドを提供し、
// バリデーション機能を備えたカスタム入力ウィジェットです。
class CitySearchInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final Validator<String> validator;
  const CitySearchInput({
    required this.controller,
    required this.validator,
    super.key,
  });

  @override
  ConsumerState<CitySearchInput> createState() => CitySearchInputState();
}

class CitySearchInputState extends ConsumerState<CitySearchInput> {
  String? errorMessage; // バリデーションエラーメッセージ

  @override
  Widget build(BuildContext context) {
    // citySearchViewModelProviderからViewModelを取得します。
    final viewModel = ref.watch(citySearchViewModelProvider.notifier);
    // 現在のテーマデータを取得します。
    final theme = Theme.of(context);

    // テキスト入力フィールドを構築します。
    return TextFormField(
      controller: widget.controller,
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
        // バリデーションの結果に基づいてエラーメッセージを表示
        errorText: errorMessage,
      ),
      // テキストが変更された時にViewModelとバリデーションを更新します。
      onChanged: (value) {
        viewModel.updateCityName(value);

        // バリデーションの結果を取得し、エラーメッセージを更新します。
        setState(() {
          if (!widget.validator.validate(value)) {
            errorMessage = widget.validator.getMessage();
          } else {
            errorMessage = null;
          }
        });
      },
      validator: (value) {
        // フォームのバリデーション時にエラーメッセージを返します。
        return widget.validator.validate(value ?? '')
            ? null
            : widget.validator.getMessage();
      },
    );
  }
}
