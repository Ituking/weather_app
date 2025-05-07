import 'package:flutter/material.dart';

class DailyForecastCardTheme extends ThemeExtension<DailyForecastCardTheme> {
  final Color cardColor;
  final ShapeBorder cardShape;
  final EdgeInsets cardPadding;
  final TextStyle dayLabelStyle;
  final TextStyle tempRangeStyle;
  final TextStyle descriptionStyle;

  const DailyForecastCardTheme({
    required this.cardColor,
    required this.cardShape,
    required this.cardPadding,
    required this.dayLabelStyle,
    required this.tempRangeStyle,
    required this.descriptionStyle,
  });

  @override
  DailyForecastCardTheme copyWith({
    Color? cardColor,
    ShapeBorder? cardShape,
    EdgeInsets? cardPadding,
    TextStyle? dayLabelStyle,
    TextStyle? tempRangeStyle,
    TextStyle? descriptionStyle,
  }) {
    return DailyForecastCardTheme(
      cardColor: cardColor ?? this.cardColor,
      cardShape: cardShape ?? this.cardShape,
      cardPadding: cardPadding ?? this.cardPadding,
      dayLabelStyle: dayLabelStyle ?? this.dayLabelStyle,
      tempRangeStyle: tempRangeStyle ?? this.tempRangeStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
    );
  }

  @override
  DailyForecastCardTheme lerp(
      ThemeExtension<DailyForecastCardTheme>? other, double t) {
    if (other is! DailyForecastCardTheme) return this;
    return DailyForecastCardTheme(
      cardColor: Color.lerp(cardColor, other.cardColor, t) ?? cardColor,
      cardShape: cardShape,
      cardPadding:
          EdgeInsets.lerp(cardPadding, other.cardPadding, t) ?? cardPadding,
      dayLabelStyle: TextStyle.lerp(dayLabelStyle, other.dayLabelStyle, t) ??
          dayLabelStyle,
      tempRangeStyle: TextStyle.lerp(tempRangeStyle, other.tempRangeStyle, t) ??
          tempRangeStyle,
      descriptionStyle:
          TextStyle.lerp(descriptionStyle, other.descriptionStyle, t) ??
              descriptionStyle,
    );
  }

  static const defaultTheme = DailyForecastCardTheme(
    cardColor: Color(0xFF2C2C2E),
    cardShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    cardPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    dayLabelStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    tempRangeStyle: TextStyle(
      color: Colors.white70,
      fontSize: 14,
    ),
    descriptionStyle: TextStyle(
      color: Colors.white,
      fontSize: 13,
    ),
  );
}
