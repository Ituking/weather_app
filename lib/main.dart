import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/firebase/firebase_options_manager.dart';
import 'core/i18n/providers/locale_notifier_provider.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

/// アプリケーションのエントリーポイント。
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebaseの初期化
  await Firebase.initializeApp(
    options: FirebaseOptionsManager.options,
  );

  // Flutterフレームワーク内のエラーをキャッチして報告
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // 非同期エラーをキャッチして報告
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const ProviderScope(child: MyApp()));
}

/// アプリケーションのルートウィジェット。
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);

    return MaterialApp.router(
      title: 'Weather App',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
        Locale('vi'),
        Locale('es'),
        Locale('fr'),
        Locale('zh'),
        Locale('hi'),
        Locale('ar'),
        Locale('de'),
        Locale('ru'),
        Locale('bn'),
        Locale('pt'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
