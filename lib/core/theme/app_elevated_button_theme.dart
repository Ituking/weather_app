import 'dart:ui';

import 'package:flutter/material.dart';

class AppElevatedButtonTheme extends ThemeExtension<AppElevatedButtonTheme> {
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final Size minimumSize;
  final TextStyle textStyle;

  const AppElevatedButtonTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.elevation,
    required this.minimumSize,
    required this.textStyle,
  });

  @override
  ThemeExtension<AppElevatedButtonTheme> copyWith({
    Color? backgroundColor,
    Color? textColor,
    double? borderRadius,
    double? elevation,
    Size? minimumSize,
    TextStyle? textStyle,
  }) =>
      AppElevatedButtonTheme(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textColor: textColor ?? this.textColor,
        borderRadius: borderRadius ?? this.borderRadius,
        elevation: elevation ?? this.elevation,
        minimumSize: minimumSize ?? this.minimumSize,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  ThemeExtension<AppElevatedButtonTheme> lerp(
      ThemeExtension<AppElevatedButtonTheme>? other, double t) {
    if (other is! AppElevatedButtonTheme) {
      return this;
    }
    return AppElevatedButtonTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      elevation: lerpDouble(elevation, other.elevation, t)!,
      minimumSize: Size.lerp(minimumSize, other.minimumSize, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
