import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/components/city_search_button.dart';
import 'package:weather_app/view_model/city_search_state.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';

import '../mocks/mock_city_search_view_model.mocks.dart';

void main() {
  group('CitySearchButton Tests', () {
    late MockCitySearchViewModel mockViewModel;
    late ProviderContainer container;

    setUp(() {
      // モックのViewModelを初期化
      mockViewModel = MockCitySearchViewModel();
      // ProviderContainerの初期化
      container = ProviderContainer(overrides: [
        citySearchViewModelProvider.overrideWith(() => mockViewModel),
      ]);
    });

    testWidgets('CitySearchButton is displayed', (WidgetTester tester) async {
      // ViewModelの状態を設定
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

      // ElevatedButtonが表示されていることを確認
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('displays CircularProgressIndicator when isLoading is true',
        (WidgetTester tester) async {
      // ViewModelの状態を設定（ローディング中）
      when(mockViewModel.state).thenReturn(CitySearchState(isLoading: true));

      // テスト対象のウィジェットを構築
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: CitySearchButton(),
          ),
        ),
      ));

      // CircularProgressIndicatorが表示されていることを確認
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'displays "Search" text and is clickable when isLoading is false',
        (WidgetTester tester) async {
      // ViewModelの状態を設定（ローディング中ではない）
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

      // ElevatedButtonが表示されていることを確認
      expect(find.byType(ElevatedButton), findsOneWidget);
      // "Search"テキストが表示されていることを確認
      expect(find.text('Search'), findsOneWidget);

      // ボタンをタップ可能か確認し、fetchWeatherメソッドが呼び出されることを確認
      await tester.tap(find.byType(ElevatedButton));
      verify(mockViewModel.fetchWeather()).called(1);
    });

    testWidgets('Button is disabled when isLoading is true',
        (WidgetTester tester) async {
      // ViewModelの状態を設定（ローディング中）
      when(mockViewModel.state).thenReturn(CitySearchState(isLoading: true));

      // テスト対象のウィジェットを構築
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: CitySearchButton(),
          ),
        ),
      ));

      // ElevatedButtonが無効化されていることを確認
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('Button is enabled when isLoading is false',
        (WidgetTester tester) async {
      // ViewModelの状態を設定（ローディング中ではない）
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

      // ElevatedButtonが有効化されていることを確認
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });
  });
}
