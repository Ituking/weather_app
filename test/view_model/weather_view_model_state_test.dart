import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/models/weather_description.dart';
import 'package:weather_app/models/weather_main.dart';
import 'package:weather_app/models/weather_wind.dart';
import 'package:weather_app/view_model/weather_view_model_state.dart';

void main() {
  // WeatherViewModelStateのテストグループ
  group('WeatherViewModelState Test', () {
    // 初期化が正しく行われるかテストする
    test('WeatherViewModelState initializes correctly', () {
      // WeatherViewModelStateのインスタンスを生成
      final state = WeatherViewModelState(
        // Result.successにWeatherListを設定。各プロパティに対する期待値を設定
        weather: Result.success([
          WeatherList(
            main: WeatherMain(temp: 20.0, humidity: 70),
            weather: [WeatherDescription(description: 'Sunny')],
            wind: WeatherWind(speed: 5.0),
          )
        ]),
        isLoading: false,
        errorMessage: null,
      );

      // 期待値と実際の値を検証
      final weather = state.weather;

      weather!.when(
        success: (data) {
          expect(data.first.main.temp, 20.0);
          expect(data.first.weather.first.description, 'Sunny');
          expect(data.first.wind.speed, 5.0);
          expect(data.first.main.humidity, 70);
        },
        failure: (error) => fail('Expected success but got failure'),
      );
      expect(state.isLoading, false);
      expect(state.errorMessage, null);
    });

    // isLoadingプロパティが正しく管理されるかを確認するテスト
    test('Handles loading state correctly', () {
      // isLoadingがtrueに設定されたWeatherViewModelStateを生成
      final state = WeatherViewModelState(isLoading: true);

      // isLoadingがtrueであることを確認
      expect(state.isLoading, true);
    });

    // エラーメッセージの管理が正しく機能するかを確認するテスト
    test('Handles error state correctly', () {
      // エラーメッセージを持つWeatherViewModelStateを生成
      final state = WeatherViewModelState(errorMessage: 'Failed to fetch data');

      // エラーメッセージが正しく設定されていることを確認
      expect(state.errorMessage, 'Failed to fetch data');
    });
  });
}
