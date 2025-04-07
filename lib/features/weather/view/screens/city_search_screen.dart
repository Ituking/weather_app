import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../components/background_image.dart';
import '../../components/city_search_button.dart';
import '../../components/city_search_input.dart';

/// [CitySearchScreen]は、ユーザーが都市名を入力して天気情報を検索する画面です。
class CitySearchScreen extends ConsumerWidget {
  const CitySearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const KeyboardDismissOnTap(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            BackgroundImage(),
            // 中央に検索インターフェイスを配置
            Center(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap(20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      // 都市名入力用のウィジェット
                      child: CitySearchInput(),
                    ),
                    Gap(20),
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
