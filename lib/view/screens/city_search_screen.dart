import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/components/city_search_button.dart';
import 'package:weather_app/components/city_search_input.dart';

// CitySearchScreenは、ユーザーが都市名を入力して天気情報を検索する画面です。
class CitySearchScreen extends ConsumerWidget {
  final TextEditingController controller = TextEditingController();

  CitySearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardDismissOnTap(
        child: Scaffold(
      // キーボードが表示された時にタップでキーボードを閉じる設定
      body: Center(
          child: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              // 都市名入力用のウィジェット
              child: CitySearchInput(controller: controller),
            ),
            const SizedBox(height: 20),
            // 検索ボタンウィジェット
            CitySearchButton(controller: controller),
          ],
        ),
      )),
    ));
  }
}
