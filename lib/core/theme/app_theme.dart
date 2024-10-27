import 'package:flutter/material.dart';

class AppTheme {
  // AppThemeは、アプリケーション全体の外観を設定するための中心的な場所を提供します。
  // 色、テキストスタイルなどを定義し、一貫性と保守性を高めます。

  // アプリ全体で使うライトテーマを定義します。
  static ThemeData lightTheme = ThemeData(
    // プライマリカラーの設定（主要なボタンやUI要素に使用）
    primaryColor: Colors.blue,
    // スキャフォールド（画面の背景色）の設定
    scaffoldBackgroundColor: Colors.white,
    // カラースキームを使用して、プライマリカラーやセカンダリーカラーを統一
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.orange,
    ),
    // テキストスタイルを統一し、フォントサイズや太字設定を追加
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ), // 見出し用の大きなテキスト
      bodyLarge: TextStyle(
        fontSize: 16,
      ), // 一般的な本文テキスト
    ),
  );
}
