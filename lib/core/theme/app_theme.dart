import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_elevated_button_theme.dart';
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
    extensions: <ThemeExtension<dynamic>>[
      const TodayWeatherCardTheme(
        backgroundColor: Color(0xFF2C2C2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: EdgeInsets.all(16),
      ),
      DailyForecastCardTheme.defaultTheme,
      const AppElevatedButtonTheme(
        backgroundColor: AppTheme.primaryColor,
        textColor: Colors.white,
        baseColor: Color(0xFFE0E0E0),
        lightShadowColor: Colors.white,
        darkShadowColor: Color(0xFFA3B1C6),
        borderRadius: 30.0,
        elevation: 12.0,
        shadowBlurRadius: 15.0,
        pressedBlurRadius: 8.0,
        pressedScale: 0.96,
        pressDuration: Duration(milliseconds: 100),
        shadowOffset: Offset(5, 5),
        pressedShadowOffset: Offset(-5, -5),
        minimumSize: Size(200, 50),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
