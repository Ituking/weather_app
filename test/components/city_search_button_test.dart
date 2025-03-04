import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/components/city_search_button.dart';
import 'package:weather_app/core/firebase/providers/firebase_functions_provider.dart';
import 'package:weather_app/core/strings/city_search_button_strings.dart';
import 'package:weather_app/view_model/city_search_state.dart';

import '../mocks/custom_mock_city_search_view_model.dart';
import '../mocks/mock_firebase_functions.mocks.dart';
import '../view_model/providers/custom_mock_city_search_view_model_provider.dart';

void main() {
  group('CitySearchButtonのテスト', () {
    late CustomMockCitySearchViewModel mockViewModel;
    late ProviderContainer container;
    late MockFirebaseFunctions mockFirebaseFunctions;

    // Firebaseをモック
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
    });

    setUp(() {
      mockViewModel = CustomMockCitySearchViewModel();
      mockFirebaseFunctions = MockFirebaseFunctions();

      container = ProviderContainer(overrides: [
        customMockCitySearchViewModelProvider.overrideWithValue(mockViewModel),
        firebaseFunctionsProvider.overrideWithValue(mockFirebaseFunctions),
      ]);
    });

    testWidgets('CitySearchButtonが表示される', (WidgetTester tester) async {
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: CitySearchButton(),
          ),
        ),
      ));

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('初期状態で"Search"が表示され、CircularProgressIndicatorが表示されない',
        (WidgetTester tester) async {
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: CitySearchButton(),
          ),
        ),
      ));

      expect(
          find.text(CitySearchButtonStrings.buttonLabelSearch), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('ローディング状態に遷移するとCircularProgressIndicatorが表示される',
        (WidgetTester tester) async {
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: CitySearchButton(),
          ),
        ),
      ));

      expect(
          find.text(CitySearchButtonStrings.buttonLabelSearch), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      mockViewModel.setState(CitySearchState(isLoading: true));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
          find.text(CitySearchButtonStrings.buttonLabelSearch), findsNothing);
    });
  });
}
