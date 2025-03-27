import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/view_model/weather_view_model_state.dart';

void main() {
  group('WeatherViewModelStateのテスト', () {
    test('WeatherViewModelStateが正しく初期化される', () {
      final testForecast = Forecast(
        id: 'forecast_id_001',
        city: 'Test City',
        description: 'Sunny',
        temperature: 20.0,
        humidity: 70.0,
        windSpeed: 5.0,
      );

      // WeatherViewModelStateのインスタンスを生成
      final state = WeatherViewModelState(
        weather: Result.success(testForecast),
        isLoading: false,
        errorMessage: null,
      );

      // 期待値と実際の値を検証
      final weather = state.weather;

      weather!.when(
        success: (data) {
          expect(data.temperature, 20.0);
          expect(data.description, 'Sunny');
          expect(data.windSpeed, 5.0);
          expect(data.humidity, 70);
          expect(data.city, 'Test City');
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
