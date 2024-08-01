import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/view_model/providers/city_weather_provider.dart';

// WeatherResultScreenは、指定された都市の天気情報を表示する画面です。
class WeatherResultScreen extends ConsumerWidget {
  final String cityName;

  const WeatherResultScreen({super.key, required this.cityName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FutureProviderを利用して天気情報を取得
    final weatherResult = ref.watch(cityWeatherProvider(cityName));

    return Scaffold(
      body: Center(
        child: weatherResult.when(
          // データ取得成功時の処理
          data: (data) {
            return data.when(success: (weatherList) {
              if (weatherList.isEmpty) {
                return const Text('No weather data available');
              }
              final weather = weatherList.first;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('都市名: $cityName'), // 都市名を表示
                  Text(
                      '気温: ${weather.main.temp.toStringAsFixed(1)}°C'), // 気温を表示
                  Text('湿度: ${weather.main.humidity}%'), // 湿度を表示
                  Text(
                      '風速: ${weather.wind.speed.toStringAsFixed(1)}m/s'), // 風速を表示
                  Text('天気: ${weather.weather.first.description}'), // 天気の説明を表示
                ],
              );
            }, failure: (error) {
              return Text('Error: ${error.message}'); // データ取得失敗時のエラーメッセージ
            });
          },
          // エラー発生時の処理
          error: (e, s) {
            return Text('Error: $e'); // 例外発生時のエラーメッセージ
          },
          // ローディング中の処理
          loading: () => const CircularProgressIndicator(), // ローディングインジケーターを表示
        ),
      ),
    );
  }
}
