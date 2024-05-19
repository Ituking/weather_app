// AppThemeは、アプリケーションの全体的な外観を設定するための中心的な場所を提供します。
// 色、テキストスタイル、入力装飾テーマなどの定義を含み、アプリケーション全体で使用することで
// 一貫性と保守性を保ちます。
import 'package:flutter/material.dart';

class AppTheme {
  // lightModeはアプリケーションのライトテーマ設定を定義します。
  // ライトモードに適した色、明るさ、テキストテーマなどの視覚的な側面を設定します。
  static ThemeData get lightMode {
    return ThemeData(
      // ライトモードのためのアプリケーションUIの全体的な明るさを設定します。
      brightness: Brightness.light,
      // ボタンやプログレスバーなど、アプリ全体で使用される主要な色。
      primaryColor: Colors.blue,
      // プライマリーカラーを使用する要素と対照的に使用されるセカンダリーカラー。
      hintColor: Colors.black,
      // アプリの主要部分の背景色、例えばスキャフォールドなど。
      scaffoldBackgroundColor: Colors.grey.shade400,
      // アプリ全体で使用される各種テキストウィジェットのテキストスタイルを指定します。
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black), // 主要なボディテキストのスタイル。
        bodyMedium: TextStyle(color: Colors.blue), // サブボディテキストのスタイル。
      ),

      // テキスト入力フィールド関連のスタイル設定
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.blueAccent, width: 2.0), // ボーダーの色と幅
          borderRadius: BorderRadius.circular(8.0), // ボーダーの角丸設定
        ),
        labelStyle: const TextStyle(color: Colors.blue), // 入力フィールド内のラベルのスタイル。
        hintStyle: const TextStyle(color: Colors.grey), // 入力フィールドのヒントテキストのスタイル。
        floatingLabelStyle: const TextStyle(
          color: Colors.blue, // フローティングラベルの色
          fontWeight: FontWeight.bold, // フローティングラベルの太字設定
        ),
      ),

      // TextSelectionThemeを使用してテキストフィールド内のカーソルの色を指定します。
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.blue, // カーソルの色を指定
      ),
    );
  }
}
