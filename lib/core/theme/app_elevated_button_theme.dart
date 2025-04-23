import 'dart:ui';

import 'package:flutter/material.dart';

class AppElevatedButtonTheme extends ThemeExtension<AppElevatedButtonTheme> {
  final Color backgroundColor;
  final Color textColor;
  final Color baseColor;
  final Color lightShadowColor;
  final Color darkShadowColor;
  final double borderRadius;
  final double elevation;
  final double shadowBlurRadius;
  final double pressedBlurRadius;
  final double pressedScale;
  final Duration pressDuration;
  final Offset shadowOffset;
  final Offset pressedShadowOffset;
  final Size minimumSize;
  final TextStyle textStyle;

  const AppElevatedButtonTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.baseColor,
    required this.lightShadowColor,
    required this.darkShadowColor,
    required this.borderRadius,
    required this.elevation,
    required this.shadowBlurRadius,
    required this.pressedBlurRadius,
    required this.pressedScale,
    required this.pressDuration,
    required this.shadowOffset,
    required this.pressedShadowOffset,
    required this.minimumSize,
    required this.textStyle,
  });

  @override
  ThemeExtension<AppElevatedButtonTheme> copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? baseColor,
    Color? lightShadowColor,
    Color? darkShadowColor,
    double? borderRadius,
    double? elevation,
    double? shadowBlurRadius,
    double? pressedBlurRadius,
    double? pressedScale,
    Duration? pressDuration,
    Offset? shadowOffset,
    Offset? pressedShadowOffset,
    Size? minimumSize,
    TextStyle? textStyle,
  }) =>
      AppElevatedButtonTheme(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textColor: textColor ?? this.textColor,
        baseColor: baseColor ?? this.baseColor,
        lightShadowColor: lightShadowColor ?? this.lightShadowColor,
        darkShadowColor: darkShadowColor ?? this.darkShadowColor,
        borderRadius: borderRadius ?? this.borderRadius,
        elevation: elevation ?? this.elevation,
        shadowBlurRadius: shadowBlurRadius ?? this.shadowBlurRadius,
        pressedBlurRadius: pressedBlurRadius ?? this.pressedBlurRadius,
        pressedScale: pressedScale ?? this.pressedScale,
        pressDuration: pressDuration ?? this.pressDuration,
        shadowOffset: shadowOffset ?? this.shadowOffset,
        pressedShadowOffset: pressedShadowOffset ?? this.pressedShadowOffset,
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
      baseColor: Color.lerp(baseColor, other.baseColor, t)!,
      lightShadowColor:
          Color.lerp(lightShadowColor, other.lightShadowColor, t)!,
      darkShadowColor: Color.lerp(darkShadowColor, other.darkShadowColor, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      elevation: lerpDouble(elevation, other.elevation, t)!,
      shadowBlurRadius:
          lerpDouble(shadowBlurRadius, other.shadowBlurRadius, t)!,
      pressedBlurRadius:
          lerpDouble(pressedBlurRadius, other.pressedBlurRadius, t)!,
      pressedScale: lerpDouble(pressedScale, other.pressedScale, t)!,
      pressDuration: pressDuration,
      shadowOffset: Offset.lerp(shadowOffset, other.shadowOffset, t)!,
      pressedShadowOffset:
          Offset.lerp(pressedShadowOffset, other.pressedShadowOffset, t)!,
      minimumSize: Size.lerp(minimumSize, other.minimumSize, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
