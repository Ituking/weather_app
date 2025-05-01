import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../ui/weather/view_model/providers/async_weather_view_model_provider.dart';
import '../../../../ui/weather/widgets/background_image.dart';
import '../widgets/app_back_button.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/today_weather_card.dart';
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
          weatherResult.when(
            data: (forecasts) {
              debugPrint('取得できた件数: ${forecasts.length}件');
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 32),
                children: [
                  TodayWeatherCard(
                    cityName: forecasts.first.city,
                    temperature: forecasts.first.temperature,
                    humidity: forecasts.first.humidity.toInt(),
                    windSpeed: forecasts.first.windSpeed,
                    description: forecasts.first.description,
                    iconCode: forecasts.first.icon,
                  ),
                  const Gap(20),
                  ...forecasts.skip(1).map(
                        (forecast) => DailyForecastCard(
                          temperature: forecast.temperature,
                          description: forecast.description,
                          iconCode: forecast.icon,
                        ),
                      ),
                  const Gap(20),
                  const AppBackButton(),
                ],
              );
            },
            error: (e, s) => const ErrorDisplayScreen(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
