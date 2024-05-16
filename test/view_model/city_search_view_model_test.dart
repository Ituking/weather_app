import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/view_model/city_search_view_model.dart';

import '../mocks/mock_weather_repository.mocks.dart';

void main() {
  group('CitySearchViewModel Tests', () {
    late MockWeatherRepository mockWeatherRepository;
    late CitySearchViewModel viewModel;

    setUp(() {
      // モックリポジトリの初期化とビューモデルのインスタンス化
      mockWeatherRepository = MockWeatherRepository();
      viewModel = CitySearchViewModel(mockWeatherRepository);
      // 初期化後の状態を検証
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.errorMessage, isNull);
    });

    test('updateCityName updates the city name in the state', () {
      // 都市名の更新テスト
      const cityName = 'New York';
      viewModel.updateCityName(cityName);
      expect(viewModel.state.cityName, cityName);
    });

    test('fetchWeather updates state on success', () async {
      // 天気情報取得成功時の状態更新をテスト
      const cityName = 'Tokyo';
      viewModel.updateCityName(cityName);
      const testWeather = WeatherModel(
        temperature: 20.0,
        description: 'Sunny',
        windSpeed: 5.0,
        humidity: 70,
        cityName: cityName,
      );
      when(mockWeatherRepository.getWeather(cityName))
          .thenAnswer((_) async => testWeather);

      await viewModel.fetchWeather();
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.weather, isNotNull);
      expect(viewModel.state.weather!.temperature,
          equals(testWeather.temperature));
      expect(viewModel.state.errorMessage, isNull);
    });

    test('fetchWeather handles errors correctly', () async {
      // 天気情報取得失敗時のエラーハンドリングをテスト
      const cityName = 'Tokyo';
      viewModel.updateCityName(cityName);
      when(mockWeatherRepository.getWeather(cityName))
          .thenThrow(Exception('Failed to fetch weather'));

      await viewModel.fetchWeather();
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.weather, isNull);
      expect(viewModel.state.errorMessage, isNotEmpty);
    });

    test('fetchWeather handles empty city name error', () async {
      // 都市名が空の場合のエラーハンドリングをテスト
      await viewModel.fetchWeather();
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.errorMessage, isNotEmpty);
    });
  });
}
