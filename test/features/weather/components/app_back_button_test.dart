import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/strings/app_back_button_strings.dart';
import 'package:weather_app/features/weather/components/app_back_button.dart';

void main() {
  group('AppBackButtonのテスト', () {
    testWidgets('AppBackButtonが表示される', (WidgetTester tester) async {
      // テスト対象のウィジェットを構築
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: AppBackButton(),
            ),
          ),
        ),
      );

      // AppBackButtonが表示されていることを確認
      expect(find.byType(AppBackButton), findsOneWidget);
    });

    testWidgets('AppBackButtonに正しいテキストが表示される', (WidgetTester tester) async {
      // テスト対象のウィジェットを構築
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: AppBackButton(),
            ),
          ),
        ),
      );

      // ボタンに"戻る"というテキストが表示されていることを確認
      expect(find.text(AppBackButtonStrings.buttonLabelBack), findsOneWidget);
    });
  });
}
