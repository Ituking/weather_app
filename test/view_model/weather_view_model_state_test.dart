import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/view_model/weather_view_model_state.dart';

void main() {
  // WeatherViewModelStateのテストグループ
  group('WeatherViewModelState Test', () {
    // 初期化が正しく行われるかテストする
    test('WeatherViewModelState initializes correctly', () {
      // WeatherViewModelStateのインスタンスを生成
      final state = WeatherViewModelState(
        // WeatherModelを設定。各プロパティに対する期待値を設定
        weather: const WeatherModel(
          temperature: 20.0,
          description: 'Sunny',
          windSpeed: 5.0,
          humidity: 70,
          cityName: 'Tokyo',
        ),
        isLoading: false,
        errorMessage: null,
      );

      // 期待値と実際の値を検証
      expect(state.weather!.temperature, 20.0);
      expect(state.weather!.description, 'Sunny');
      expect(state.weather!.windSpeed, 5.0);
      expect(state.weather!.humidity, 70);
      expect(state.weather!.cityName, 'Tokyo');
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
