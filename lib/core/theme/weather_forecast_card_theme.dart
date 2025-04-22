import 'package:flutter/material.dart';

class WeatherForecastCardTheme
    extends ThemeExtension<WeatherForecastCardTheme> {
  final Color backgroundColor;
  final ShapeBorder shape;
  final EdgeInsets padding;

  const WeatherForecastCardTheme({
    required this.backgroundColor,
    required this.shape,
    required this.padding,
  });

  @override
  ThemeExtension<WeatherForecastCardTheme> copyWith({
    Color? backgroundColor,
    ShapeBorder? shape,
    EdgeInsets? padding,
  }) =>
      WeatherForecastCardTheme(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        shape: shape ?? this.shape,
        padding: padding ?? this.padding,
      );

  @override
  WeatherForecastCardTheme lerp(
      ThemeExtension<WeatherForecastCardTheme>? other, double t) {
    if (other is! WeatherForecastCardTheme) {
      return this;
    }
    return WeatherForecastCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      shape: shape,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
    );
  }
}
