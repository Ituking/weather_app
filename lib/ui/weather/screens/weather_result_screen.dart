import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../ui/weather/view_model/providers/async_weather_view_model_provider.dart';
import '../../../../ui/weather/widgets/app_back_button.dart';
import '../../../../ui/weather/widgets/background_image.dart';
import '../../../../ui/weather/widgets/city_name_text.dart';
import '../../../../ui/weather/widgets/humidity_text.dart';
import '../../../../ui/weather/widgets/temperature_text.dart';
import '../../../../ui/weather/widgets/weather_description_text.dart';
import '../../../../ui/weather/widgets/weather_icon.dart';
import '../../../../ui/weather/widgets/wind_speed_text.dart';
import 'error_display_screen.dart';

/// [WeatherResultScreen]は、指定された都市の天気情報を表示する画面です。
class WeatherResultScreen extends ConsumerStatefulWidget {
  const WeatherResultScreen({super.key});

  @override
  ConsumerState<WeatherResultScreen> createState() =>
      _WeatherResultScreenState();
}

class _WeatherResultScreenState extends ConsumerState<WeatherResultScreen> {
  @override
  Widget build(BuildContext context) {
    final weatherResult = ref.watch(asyncWeatherViewModelProvider);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Center(
            child: weatherResult.when(
              data: (forecast) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CityNameText(cityName: forecast.city),
                  Gap(8),
                  TemperatureText(temperature: forecast.temperature),
                  Gap(8),
                  HumidityText(humidity: forecast.humidity.toInt()),
                  Gap(8),
                  WindSpeedText(windSpeed: forecast.windSpeed),
                  Gap(8),
                  WeatherDescriptionText(
                      weatherDescription: forecast.description),
                  Gap(8),
                  WeatherIcon(iconCode: "${forecast.icon}@2x"),
                  Gap(20),
                  const AppBackButton(),
                ],
              ),
              error: (e, s) => const ErrorDisplayScreen(),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
