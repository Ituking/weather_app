import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/ui/weather/widgets/app_back_button.dart';

void main() {
  group('AppBackButtonのテスト', () {
    testWidgets('AppBackButtonが表示される', (WidgetTester tester) async {
      // テスト対象のウィジェットを構築
      await tester.pumpWidget(
        ProviderScope(
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
        ProviderScope(
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
              body: AppBackButton(),
            ),
          ),
        ),
      );

      // ボタンに"戻る"というテキストが表示されていることを確認
      expect(
          find.text(
              AppLocalizations.of(tester.element(find.byType(AppBackButton)))!
                  .backButtonLabel),
          findsOneWidget);
    });
  });
}
