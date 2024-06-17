import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/components/city_search_button.dart';
import 'package:weather_app/view_model/city_search_state.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';
import '../mocks/custom_mock_city_search_view_model.dart';
import '../view_model/providers/custom_mock_city_search_view_model_provider.dart';

void main() {
  group('CitySearchButtonのテスト', () {
    late CustomMockCitySearchViewModel mockViewModel;
    late ProviderContainer container;

    setUp(() {
      // モックのViewModelを初期化
      mockViewModel = CustomMockCitySearchViewModel();
      // ProviderContainerの初期化
      container = ProviderContainer(overrides: [
        customMockCitySearchViewModelProvider.overrideWithValue(mockViewModel),
      ]);
    });

    testWidgets('CitySearchButtonが表示される', (WidgetTester tester) async {
      // ViewModelの状態を設定
      mockViewModel.setState(CitySearchState(isLoading: false));

      // テスト対象のウィジェットを構築
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: CitySearchButton(),
          ),
        ),
      ));

      // ElevatedButtonが表示されていることを確認
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('初期状態で"Search"が表示され、CircularProgressIndicatorが表示されない',
        (WidgetTester tester) async {
      // 初期状態設定
      when(mockViewModel.state).thenReturn(CitySearchState(isLoading: false));

      // テスト対象のウィジェットを構築
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: CitySearchButton(),
          ),
        ),
      ));

      // 初期状態で"Search"テキストが表示されていることを確認
      expect(find.text('Search'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('ローディング状態に遷移するとCircularProgressIndicatorが表示される',
        (WidgetTester tester) async {
      // 初期状態設定
      when(mockViewModel.state).thenReturn(CitySearchState(isLoading: false));

      // テスト対象のウィジェットを構築
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: CitySearchButton(),
          ),
        ),
      ));

      // 初期状態で"Search"テキストが表示されていることを確認
      expect(find.text('Search'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // 状態をローディング中に変更
      container
          .read(citySearchViewModelProvider.notifier)
          .setState(CitySearchState(isLoading: true));
      await tester.pump();

      // CircularProgressIndicatorが表示されていることを確認
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Search'), findsNothing);
    });
  });
}
