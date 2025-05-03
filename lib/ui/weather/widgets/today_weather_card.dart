import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/today_weather_card_theme.dart';
import 'city_name_text.dart';
import 'humidity_text.dart';
import 'temperature_text.dart';
import 'weather_description_text.dart';
import 'weather_icon.dart';
import 'wind_speed_text.dart';

class TodayWeatherCard extends StatelessWidget {
  final String cityName;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final String iconCode;

  const TodayWeatherCard({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.iconCode,
  });

  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).extension<TodayWeatherCardTheme>()!;

    return Card(
      color: cardTheme.backgroundColor,
      shape: cardTheme.shape,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: cardTheme.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CityNameText(cityName: cityName),
            ),
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WeatherIcon(iconCode: "$iconCode@2x"),
                const Gap(12),
                TemperatureText(temperature: temperature),
              ],
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HumidityText(humidity: humidity),
                WindSpeedText(windSpeed: windSpeed),
                WeatherDescriptionText(weatherDescription: description),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
