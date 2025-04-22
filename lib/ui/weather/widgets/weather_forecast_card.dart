import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/weather_forecast_card_theme.dart';
import 'city_name_text.dart';
import 'humidity_text.dart';
import 'temperature_text.dart';
import 'weather_description_text.dart';
import 'weather_icon.dart';
import 'wind_speed_text.dart';

class WeatherForecastCard extends StatelessWidget {
  final String cityName;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final String iconCode;

  const WeatherForecastCard({
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
    final cardTheme = Theme.of(context).extension<WeatherForecastCardTheme>()!;

    return Card(
      color: cardTheme.backgroundColor,
      shape: cardTheme.shape,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: cardTheme.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: CityNameText(cityName: cityName),
            ),
            Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WeatherIcon(iconCode: "$iconCode@2x"),
                Gap(16),
                TemperatureText(temperature: temperature),
              ],
            ),
            Gap(16),
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
