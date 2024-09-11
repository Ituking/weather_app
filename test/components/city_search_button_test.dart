import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/components/city_search_button.dart';
import 'package:weather_app/core/strings/city_search_button_strings.dart';
import 'package:weather_app/view_model/city_search_state.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';
import 'package:weather_app/view_model/providers/text_editing_controller_provider.dart';
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

      // 初期状態で"検索"テキストが表示されていることを確認
      expect(
          find.text(CitySearchButtonStrings.buttonLabelSearch), findsOneWidget);
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

      // 初期状態で"検索"テキストが表示されていることを確認
      expect(
          find.text(CitySearchButtonStrings.buttonLabelSearch), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // 状態をローディング中に変更
      container
          .read(citySearchViewModelProvider.notifier)
          .setState(CitySearchState(isLoading: true));
      await tester.pump();

      // CircularProgressIndicatorが表示されていることを確認
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
          find.text(CitySearchButtonStrings.buttonLabelSearch), findsNothing);
    });

    testWidgets('無効な入力でボタンが無効になる', (WidgetTester tester) async {
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

      // 無効な入力（例: 空文字）を設定
      mockViewModel.updateCityName('');
      await tester.pump();

      // ボタンが無効になっていることを確認
      expect(
          tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
          isNull);
    });

    testWidgets('入力の前後のスペースがトリムされている', (WidgetTester tester) async {
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

      // 入力フィールドに前後のスペースを含む文字列を設定
      final controller = container.read(textEditingControllerProvider);
      controller.text = '  Tokyo  ';

      // 更新を通知
      container
          .read(citySearchViewModelProvider.notifier)
          .updateCityName(controller.text.trim());
      await tester.pump();

      // ボタンが有効になっていることを確認（trim化された'Tokyo'が正しいため）
      expect(
        tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNotNull,
      );
    });
  });
}
