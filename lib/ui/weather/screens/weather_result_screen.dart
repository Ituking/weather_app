import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../ui/weather/view_model/providers/async_weather_view_model_provider.dart';
import '../../../../ui/weather/widgets/background_image.dart';
import '../../../../ui/weather/widgets/city_name_text.dart';
import '../../../../ui/weather/widgets/humidity_text.dart';
import '../../../../ui/weather/widgets/weather_description_text.dart';
import '../../../../ui/weather/widgets/wind_speed_text.dart';
import '../widgets/app_back_button.dart';
import '../widgets/temperature_text.dart';
import '../widgets/weather_icon.dart';
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
          Align(
            alignment: Alignment.center,
            child: weatherResult.when(
              data: (forecast) => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: CityNameText(cityName: forecast.city),
                          ),
                          Gap(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WeatherIcon(iconCode: "${forecast.icon}@2x"),
                              Gap(16),
                              TemperatureText(
                                  temperature: forecast.temperature),
                            ],
                          ),
                          Gap(16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              HumidityText(humidity: forecast.humidity.toInt()),
                              WindSpeedText(windSpeed: forecast.windSpeed),
                              WeatherDescriptionText(
                                  weatherDescription: forecast.description),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20),
                  const AppBackButton(),
                ],
              ),
              error: (e, s) => const ErrorDisplayScreen(),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
