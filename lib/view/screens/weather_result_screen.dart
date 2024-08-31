import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/components/city_name_text.dart';
import 'package:weather_app/components/humidity_text.dart';
import 'package:weather_app/components/temperature_text.dart';
import 'package:weather_app/components/weather_description_text.dart';
import 'package:weather_app/components/wind_speed_text.dart';
import 'package:weather_app/view_model/providers/city_weather_provider.dart';

// WeatherResultScreenは、指定された都市の天気情報を表示する画面です。
class WeatherResultScreen extends ConsumerWidget {
  final String cityName;

  // コンストラクタ：必須のcityNameパラメータを受け取る
  const WeatherResultScreen({super.key, required this.cityName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // cityWeatherProviderを利用して天気情報を取得
    final weatherResult = ref.watch(cityWeatherProvider(cityName));

    return Scaffold(
      body: Stack(
        children: [
          // 背景に画像を全画面で表示
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              child: Image.asset(
                'assets/images/clouds-4215608_1280.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            // データの状態に応じたウィジェットを返す
            child: weatherResult.when(
              // データ取得成功時の処理
              data: (data) {
                // 成功時のResultをさらに確認
                return data.when(
                  success: (weatherList) {
                    if (weatherList.isEmpty) {
                      // 天気データが空の場合の処理
                      return const Text('天気データが利用できません');
                    }
                    // 最初の天気情報を取得
                    final weather = weatherList.first;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CityNameText(cityName: cityName), // 都市名を表示
                        const SizedBox(height: 8), // スペースを追加
                        TemperatureText(
                            temperature: weather.main.temp), // 気温を表示
                        const SizedBox(height: 8), // スペースを追加
                        HumidityText(humidity: weather.main.humidity), // 湿度を表示
                        const SizedBox(height: 8), // スペースを追加
                        WindSpeedText(windSpeed: weather.wind.speed), // 風速を表示
                        const SizedBox(height: 8), // スペースを追加
                        WeatherDescriptionText(
                            weatherDescription:
                                weather.weather.first.description), // 天気の説明を表示
                      ],
                    );
                  },
                  failure: (error) {
                    // データ取得失敗時のエラーメッセージを表示
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('エラー: ${error.message}'), // エラーメッセージを表示
                      ],
                    );
                  },
                );
              },
              // 非同期処理でエラーが発生した場合の処理
              error: (e, s) {
                // 例外発生時のエラーメッセージを表示
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('例外が発生しました: $e'),
                  ],
                );
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
