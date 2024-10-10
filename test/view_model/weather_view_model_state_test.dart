import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/models/weather_description.dart';
import 'package:weather_app/models/weather_main.dart';
import 'package:weather_app/models/weather_wind.dart';
import 'package:weather_app/view_model/weather_view_model_state.dart';

void main() {
  group('WeatherViewModelStateのテスト', () {
    test('WeatherViewModelStateが正しく初期化される', () {
      // WeatherListのインスタンスを生成
      final testWeatherList = [
        WeatherList(
          main: WeatherMain(temp: 20.0, humidity: 70),
          weather: [
            WeatherDescription(
              description: 'Sunny',
              icon: '01d',
            ),
          ],
          wind: WeatherWind(speed: 5.0),
        ),
      ];

      // WeatherViewModelStateのインスタンスを生成
      final state = WeatherViewModelState(
        // Result.successにWeatherResponseを設定
        weather: Result.success(testWeatherList),
        isLoading: false,
        errorMessage: null,
      );

      // 期待値と実際の値を検証
      final weather = state.weather;

      weather!.when(
        success: (data) {
          expect(data.first.main.temp, 20.0);
          expect(data.first.weather.first.description, 'Sunny');
          expect(data.first.weather.first.icon, '01d');
          expect(data.first.wind.speed, 5.0);
          expect(data.first.main.humidity, 70);
        },
        failure: (error) => fail('Expected success but got failure'),
      );
      expect(state.isLoading, false);
      expect(state.errorMessage, null);
    });

    test('ローディング状態が正しく管理される', () {
      // isLoadingがtrueに設定されたWeatherViewModelStateを生成
      final state = WeatherViewModelState(isLoading: true);

      // isLoadingがtrueであることを確認
      expect(state.isLoading, true);
    });

    test('エラーメッセージの管理が正しく機能する', () {
      // エラーメッセージを持つWeatherViewModelStateを生成
      final state = WeatherViewModelState(errorMessage: 'Failed to fetch data');

      // エラーメッセージが正しく設定されていることを確認
      expect(state.errorMessage, 'Failed to fetch data');
    });
  });
}
