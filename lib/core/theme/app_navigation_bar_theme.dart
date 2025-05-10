import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppNavigationBarTheme extends ThemeExtension<AppNavigationBarTheme> {
  final Color indicatorColor;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final TextStyle labelTextStyle;

  const AppNavigationBarTheme({
    required this.indicatorColor,
    required this.backgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.labelTextStyle,
  });

  @override
  AppNavigationBarTheme copyWith({
    Color? indicatorColor,
    Color? backgroundColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    TextStyle? labelTextStyle,
  }) {
    return AppNavigationBarTheme(
      indicatorColor: indicatorColor ?? this.indicatorColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    );
  }

  @override
  ThemeExtension<AppNavigationBarTheme> lerp(
      ThemeExtension<AppNavigationBarTheme>? other, double t) {
    if (other is! AppNavigationBarTheme) {
      return this;
    }
    return AppNavigationBarTheme(
      indicatorColor: Color.lerp(indicatorColor, other.indicatorColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      selectedItemColor:
          Color.lerp(selectedItemColor, other.selectedItemColor, t)!,
      unselectedItemColor:
          Color.lerp(unselectedItemColor, other.unselectedItemColor, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
    );
  }

  static const defaultTheme = AppNavigationBarTheme(
    indicatorColor: AppTheme.primaryColor,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black87,
    unselectedItemColor: Colors.black45,
    labelTextStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  );
}
