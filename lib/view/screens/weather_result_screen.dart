import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../components/app_back_button.dart';
import '../../components/background_image.dart';
import '../../components/city_name_text.dart';
import '../../components/humidity_text.dart';
import '../../components/temperature_text.dart';
import '../../components/weather_description_text.dart';
import '../../components/weather_icon.dart';
import '../../components/wind_speed_text.dart';
import 'error_display_screen.dart';
import '../../view_model/providers/city_weather_notifier_provider.dart';

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
    // cityWeatherNotifierProviderを利用して天気情報を取得
    final weatherResult = ref.watch(cityWeatherNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Center(
            // データの状態に応じたウィジェットを返す
            child: weatherResult.when(
              // データ取得成功時の処理
              data: (data) {
                // 成功時のResultをさらに確認
                return data.when(
                  success: (weatherResponse) {
                    // 最初の天気情報を取得
                    final weather = weatherResponse.list.first;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CityNameText(
                            cityName: weatherResponse.city.name), // 都市名
                        Gap(8),
                        TemperatureText(temperature: weather.main.temp), // 気温
                        Gap(8),
                        HumidityText(humidity: weather.main.humidity), // 湿度
                        Gap(8),
                        WindSpeedText(windSpeed: weather.wind.speed), // 風速
                        Gap(8),
                        WeatherDescriptionText(
                            weatherDescription:
                                weather.weather.first.description), // 天気の説明
                        Gap(8),
                        WeatherIcon(
                            iconCode:
                                "${weather.weather.first.icon}@2x"), // 天気アイコン
                        Gap(20),
                        const AppBackButton(), // 戻るボタン
                      ],
                    );
                  },
                  failure: (error) {
                    // データ取得失敗時のエラーメッセージを表示
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(error.message), // エラーメッセージを表示
                      ],
                    );
                  },
                );
              },
              // 非同期処理でエラーが発生した場合の処理
              error: (e, s) {
                return const ErrorDisplayScreen();
              },
              // データ取得中の処理
              loading: () =>
                  const CircularProgressIndicator(), // ローディングインジケーターを表示
            ),
          ),
        ],
      ),
    );
  }
}
