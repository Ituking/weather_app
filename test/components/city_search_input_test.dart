import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/components/city_search_input.dart';

void main() {
  group('CitySearchInputのテスト', () {
    testWidgets('CitySearchInputが表示される', (WidgetTester tester) async {
      // テストウィジェットを構築
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CitySearchInput(),
            ),
          ),
        ),
      );

      // TextFormFieldが表示されていることを確認
      expect(find.byType(TextFormField), findsOneWidget);
      // ヒントテキストが表示されていることを確認
      expect(find.text('Tokyo'), findsOneWidget);
    });

    testWidgets('CitySearchInputがテキスト入力を受け付ける', (WidgetTester tester) async {
      // テストウィジェットを構築
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CitySearchInput(),
            ),
          ),
        ),
      );

      // TextFormFieldにテキストを入力
      await tester.enterText(find.byType(TextFormField), 'Osaka');
      await tester.pump();

      // 入力されたテキストが反映されていることを確認
      expect(find.text('Osaka'), findsOneWidget);
    });

    testWidgets('無効な入力に対してエラーメッセージが表示される', (WidgetTester tester) async {
      // テストウィジェットを構築
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CitySearchInput(),
            ),
          ),
        ),
      );

      // 不正なテキストを入力してバリデーションエラーをトリガー
      await tester.enterText(find.byType(TextFormField), '12345');
      await tester.pump();

      // エラーメッセージが表示されていることを確認
      expect(find.text('都市名は英字とスペースのみを使用してください。'), findsOneWidget);
    });

    testWidgets('有効な入力に対してエラーメッセージが表示されない', (WidgetTester tester) async {
      // テストウィジェットを構築
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CitySearchInput(),
            ),
          ),
        ),
      );

      // 有効なテキストを入力
      await tester.enterText(find.byType(TextFormField), 'Tokyo');
      await tester.pump();

      // エラーメッセージが表示されていないことを確認
      expect(find.text('都市名は英字とスペースのみを使用してください。'), findsNothing);
    });
  });
}
