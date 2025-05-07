import 'package:flutter/material.dart';

class TodayWeatherCardTheme extends ThemeExtension<TodayWeatherCardTheme> {
  final Color backgroundCardColor;
  final ShapeBorder cardShape;
  final EdgeInsets cardPadding;

  const TodayWeatherCardTheme({
    required this.backgroundCardColor,
    required this.cardShape,
    required this.cardPadding,
  });

  @override
  ThemeExtension<TodayWeatherCardTheme> copyWith({
    Color? backgroundColor,
    ShapeBorder? shape,
    EdgeInsets? padding,
  }) =>
      TodayWeatherCardTheme(
        backgroundCardColor: backgroundColor ?? backgroundCardColor,
        cardShape: shape ?? cardShape,
        cardPadding: padding ?? cardPadding,
      );

  @override
  TodayWeatherCardTheme lerp(
      ThemeExtension<TodayWeatherCardTheme>? other, double t) {
    if (other is! TodayWeatherCardTheme) {
      return this;
    }
    return TodayWeatherCardTheme(
      backgroundCardColor:
          Color.lerp(backgroundCardColor, other.backgroundCardColor, t)!,
      cardShape: cardShape,
      cardPadding: EdgeInsets.lerp(cardPadding, other.cardPadding, t)!,
    );
  }

  static const defaultTheme = TodayWeatherCardTheme(
    backgroundCardColor: Color(0xFF2C2C2E),
    cardShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    cardPadding: EdgeInsets.all(16),
  );
}
