import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/components/city_search_input.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';

import '../mocks/view_model/mock_city_search_view_model.dart';

void main() {
  group('CitySearchInput Tests', () {
    // モックのCitySearchViewModelを格納する変数
    late MockCitySearchViewModel mockViewModel;

    setUp(() {
      // モックのCitySearchViewModelを初期化
      mockViewModel = MockCitySearchViewModel();
    });

    testWidgets('CitySearchInput is displayed', (WidgetTester tester) async {
      // テストウィジェットを構築し、必要なプロバイダーをオーバーライド
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            citySearchViewModelProvider.overrideWith((ref) => mockViewModel),
          ],
          child: const MaterialApp(
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

    testWidgets('CitySearchInput calls updateCityName on text change',
        (WidgetTester tester) async {
      // テストウィジェットを構築し、必要なプロバイダーをオーバーライド
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            citySearchViewModelProvider.overrideWith((ref) => mockViewModel),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: CitySearchInput(),
            ),
          ),
        ),
      );

      // TextFormFieldにテキストを入力
      await tester.enterText(find.byType(TextFormField), 'Osaka');
      await tester.pump();

      // updateCityNameメソッドが呼び出されることを確認
      verify(mockViewModel.updateCityName('Osaka')).called(1);
    });
  });
}
