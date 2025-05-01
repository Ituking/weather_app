import 'package:flutter/material.dart';

class TodayWeatherCardTheme extends ThemeExtension<TodayWeatherCardTheme> {
  final Color backgroundColor;
  final ShapeBorder shape;
  final EdgeInsets padding;

  const TodayWeatherCardTheme({
    required this.backgroundColor,
    required this.shape,
    required this.padding,
  });

  @override
  ThemeExtension<TodayWeatherCardTheme> copyWith({
    Color? backgroundColor,
    ShapeBorder? shape,
    EdgeInsets? padding,
  }) =>
      TodayWeatherCardTheme(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        shape: shape ?? this.shape,
        padding: padding ?? this.padding,
      );

  @override
  TodayWeatherCardTheme lerp(
      ThemeExtension<TodayWeatherCardTheme>? other, double t) {
    if (other is! TodayWeatherCardTheme) {
      return this;
    }
    return TodayWeatherCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      shape: shape,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
    );
  }
}
