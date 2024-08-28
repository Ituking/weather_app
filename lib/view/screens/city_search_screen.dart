import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/components/city_search_button.dart';
import 'package:weather_app/components/city_search_input.dart';

// CitySearchScreenは、ユーザーが都市名を入力して天気情報を検索する画面です。
class CitySearchScreen extends ConsumerWidget {
  const CitySearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // 背景画像
            Image.asset(
              'assets/images/clouds-4215608_1280.jpg',
              fit: BoxFit.cover,
            ),
            // 中央に検索インターフェイスを配置
            const Center(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      // 都市名入力用のウィジェット
                      child: CitySearchInput(),
                    ),
                    SizedBox(height: 20),
                    // 検索ボタンウィジェット
                    CitySearchButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
