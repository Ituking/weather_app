import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/firebase/providers/firebase_functions_provider.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/ui/core/widgets/app_elevated_button.dart';
import 'package:weather_app/ui/weather/view_model/providers/text_editing_controller_provider.dart';
import 'package:weather_app/ui/weather/widgets/city_search_button.dart';

import '../../../test_helpers/mocks/custom_mock_city_search_view_model.dart';
import '../../../test_helpers/mocks/mock_firebase_functions.mocks.dart';
import '../view_model/providers/custom_mock_city_search_view_model_provider.dart';

void main() {
  group('CitySearchButtonのテスト', () {
    late ProviderContainer container;
    late MockFirebaseFunctions mockFirebaseFunctions;

    setUp(() {
      mockFirebaseFunctions = MockFirebaseFunctions();

      container = ProviderContainer(overrides: [
        customMockCitySearchViewModelProvider
            .overrideWith(CustomMockCitySearchViewModel.new),
        firebaseFunctionsProvider.overrideWithValue(mockFirebaseFunctions),
      ]);
    });

    testWidgets('CitySearchButtonが表示される', (WidgetTester tester) async {
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('ja'),
          supportedLocales: const [Locale('ja')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const Scaffold(
            body: CitySearchButton(),
          ),
        ),
      ));

      final controller = container.read(textEditingControllerProvider);
      controller.text = 'Tokyo';

      await tester.pump();

      expect(find.byType(AppElevatedButton), findsOneWidget);
    });

    testWidgets('初期状態で"Search"が表示され、CircularProgressIndicatorが表示されない',
        (WidgetTester tester) async {
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('ja'),
          supportedLocales: const [Locale('ja')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Scaffold(
            body: CitySearchButton(),
          ),
        ),
      ));

      final controller = container.read(textEditingControllerProvider);
      controller.text = 'Tokyo';
      await tester.pump();

      final localizedText =
          AppLocalizations.of(tester.element(find.byType(CitySearchButton)))!
              .searchButtonLabel;

      expect(find.text(localizedText), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
