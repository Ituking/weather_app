import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/ui/weather/widgets/city_search_input.dart';

import '../../../test_helpers/mocks/mock_firebase.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    setupFirebaseMocks();
    await Firebase.initializeApp();
  });

  group('CitySearchInputのテスト', () {
    Future<void> pumpLocalizedWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            locale: Locale('ja'),
            supportedLocales: [Locale('ja')],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: Scaffold(
              body: CitySearchInput(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('CitySearchInputが表示される', (WidgetTester tester) async {
      await pumpLocalizedWidget(tester);
      expect(find.byType(TextFormField), findsOneWidget);

      final context = tester.element(find.byType(CitySearchInput));
      final hintText = AppLocalizations.of(context)!.cityNameHintExample;
      expect(find.text(hintText), findsOneWidget);
    });

    testWidgets('CitySearchInputがテキスト入力を受け付ける', (WidgetTester tester) async {
      await pumpLocalizedWidget(tester);
      await tester.enterText(find.byType(TextFormField), 'Osaka');
      await tester.pump();
      expect(find.text('Osaka'), findsOneWidget);
    });

    testWidgets('無効な入力に対してエラーメッセージが表示される', (WidgetTester tester) async {
      await pumpLocalizedWidget(tester);
      await tester.enterText(find.byType(TextFormField), '12345');
      await tester.pump();

      final context = tester.element(find.byType(CitySearchInput));
      final errorText = AppLocalizations.of(context)!.cityNameInvalidError;
      expect(find.text(errorText), findsOneWidget);
    });

    testWidgets('有効な入力に対してエラーメッセージが表示されない', (WidgetTester tester) async {
      await pumpLocalizedWidget(tester);
      await tester.enterText(find.byType(TextFormField), 'Tokyo');
      await tester.pump();

      final context = tester.element(find.byType(CitySearchInput));
      final errorText = AppLocalizations.of(context)!.cityNameInvalidError;
      expect(find.text(errorText), findsNothing);
    });
  });
}
