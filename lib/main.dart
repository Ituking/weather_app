import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/routing/app_router.dart';

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
      theme: ThemeData(
        // カラースキームの設定。深い紫色を基調にしています。
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // Material 3の使用を有効化
        useMaterial3: true,
      ),
      // ルーティングの設定
      routerConfig: AppRouter.router,
    );
  }
}
