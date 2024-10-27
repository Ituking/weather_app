import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/routing/app_router.dart';
import 'package:weather_app/core/theme/app_theme.dart';

// アプリケーションのエントリーポイント
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// MyAppウィジェットの定義。アプリのルートウィジェットです。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // アプリのタイトル
      title: 'Weather App',
      // アプリのテーマ設定
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      // ルーティングの設定
      routerConfig: AppRouter.router,
    );
  }
}
