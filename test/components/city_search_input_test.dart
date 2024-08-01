import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/components/city_search_input.dart';

void main() {
  group('CitySearchInput Tests', () {
    testWidgets('CitySearchInput is displayed', (WidgetTester tester) async {
      final controller = TextEditingController();

      // テストウィジェットを構築
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CitySearchInput(
                controller: controller,
              ),
            ),
          ),
        ),
      );

      // TextFormFieldが表示されていることを確認
      expect(find.byType(TextFormField), findsOneWidget);
      // ヒントテキストが表示されていることを確認
      expect(find.text('Tokyo'), findsOneWidget);
    });

    testWidgets('CitySearchInput accepts text input',
        (WidgetTester tester) async {
      final controller = TextEditingController();

      // テストウィジェットを構築
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CitySearchInput(
                controller: controller,
              ),
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
  });
}
