import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_elevated_button_theme.dart';
import 'app_navigation_bar_theme.dart';
import 'daily_forecast_card_theme.dart';
import 'today_weather_card_theme.dart';

/// アプリケーション全体のテーマ設定を提供します。
class AppTheme {
  static const Color primaryColor = Color(0xFF1DABED);
  static const Color secondaryColor = Color(0xFFFFA726);
  static const Color backgroundColor = Color(0xFFE5F7FD);

  /// ライトテーマの定義。
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: backgroundColor,
    ),
    textTheme: GoogleFonts.notoSansJpTextTheme().copyWith(
      displayLarge: GoogleFonts.notoSansJp(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      bodyLarge: GoogleFonts.notoSansJp(
        fontSize: 16,
        color: Colors.black87,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppNavigationBarTheme.defaultTheme.backgroundColor,
      indicatorColor: AppNavigationBarTheme.defaultTheme.indicatorColor,
      labelTextStyle: WidgetStateProperty.all(
        AppNavigationBarTheme.defaultTheme.labelTextStyle,
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: AppNavigationBarTheme.defaultTheme.selectedItemColor,
            );
          }
          return IconThemeData(
            color: AppNavigationBarTheme.defaultTheme.unselectedItemColor,
          );
        },
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      TodayWeatherCardTheme.defaultTheme,
      DailyForecastCardTheme.defaultTheme,
      AppElevatedButtonTheme.defaultTheme,
      AppNavigationBarTheme.defaultTheme,
    ],
  );
}
