import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';

import '../mocks/mock_weather_repository.mocks.dart';

void main() {
  group('CitySearchViewModel Tests', () {
    late MockWeatherRepository mockWeatherRepository;
    late ProviderContainer container;

    setUp(() {
      // モックリポジトリの初期化
      mockWeatherRepository = MockWeatherRepository();
      // ProviderContainerの初期化
      container = ProviderContainer(overrides: [
        // weatherRepositoryProviderをモックリポジトリでオーバーライド
        weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
      ]);
    });

    test('updateCityName updates the city name in the state', () {
      if (kDebugMode) {
        print('Test: updateCityName updates the city name in the state');
      }
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 都市名の更新テスト
      const cityName = 'New York';
      viewModel.updateCityName(cityName);
      if (kDebugMode) {
        print('City name updated to: ${viewModel.state.cityName}');
      }
      // 都市名が正しく更新されたことを確認
      expect(viewModel.state.cityName, cityName);
    });

    test('fetchWeather updates state on success', () async {
      if (kDebugMode) {
        print('Test: fetchWeather updates state on success');
      }
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

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
      if (kDebugMode) {
        print('Weather fetched: ${viewModel.state.weather}');
      }
      // 正常に天気情報が取得されたことを確認
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.weather, isNotNull);
      expect(viewModel.state.weather!.temperature,
          equals(testWeather.temperature));
      expect(viewModel.state.errorMessage, isNull);
    });

    test('fetchWeather handles errors correctly', () async {
      if (kDebugMode) {
        print('Test: fetchWeather handles errors correctly');
      }
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 天気情報取得失敗時のエラーハンドリングをテスト
      const cityName = 'Tokyo';
      viewModel.updateCityName(cityName);
      when(mockWeatherRepository.getWeather(cityName))
          .thenThrow(Exception('Failed to fetch weather'));

      await viewModel.fetchWeather();
      if (kDebugMode) {
        print('Error message: ${viewModel.state.errorMessage}');
      }
      // エラーメッセージが設定されていることを確認
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.weather, isNull);
      expect(viewModel.state.errorMessage, isNotEmpty);
    });

    test('fetchWeather handles empty city name error', () async {
      if (kDebugMode) {
        print('Test: fetchWeather handles empty city name error');
      }
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 都市名が空の場合のエラーメッセージ設定をテスト
      await viewModel.fetchWeather();
      if (kDebugMode) {
        print('Error message: ${viewModel.state.errorMessage}');
      }
      // エラーメッセージが設定されていることを確認
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.errorMessage, isNotEmpty);
    });
  });
}
