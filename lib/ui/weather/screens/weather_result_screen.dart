import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../ui/weather/view_model/providers/async_weather_view_model_provider.dart';
import '../../../../ui/weather/widgets/background_image.dart';
import '../../../core/utils/date_format_util.dart';
import '../widgets/app_back_button.dart';
import '../widgets/daily_forecast_block.dart';
import '../widgets/daily_forecast_row.dart';
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
              final today = forecasts.first;

              final forecastRows = forecasts
                  .skip(1)
                  .take(5)
                  .map(
                    (forecast) => DailyForecastRow(
                      dayLabel:
                          DateFormatUtil.formatToDayLabel(forecast.timestamp),
                      minTemperature: forecast.minTemp,
                      maxTemperature: forecast.maxTemp,
                      description: forecast.description,
                      iconCode: forecast.icon,
                    ),
                  )
                  .toList();

              return SafeArea(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  children: [
                    TodayWeatherCard(
                      cityName: today.city,
                      temperature: today.temperature,
                      humidity: today.humidity.toInt(),
                      windSpeed: today.windSpeed,
                      description: today.description,
                      iconCode: today.icon,
                    ),
                    const Gap(20),
                    DailyForecastBlock(forecastRows: forecastRows),
                    const Gap(20),
                    const AppBackButton(),
                  ],
                ),
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
