import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/models/weather_description.dart';
import 'package:weather_app/models/weather_main.dart';
import 'package:weather_app/models/weather_wind.dart';
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
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 都市名の更新テスト
      const cityName = 'New York';
      viewModel.updateCityName(cityName);

      // 都市名が正しく更新されたことを確認
      expect(viewModel.state.cityName, cityName);
    });

    test('fetchWeather updates state on success', () async {
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 天気情報取得成功時の状態更新をテスト
      const cityName = 'Tokyo';
      viewModel.updateCityName(cityName);
      final testWeatherList = [
        WeatherList(
          main: WeatherMain(temp: 20.0, humidity: 70),
          weather: [WeatherDescription(description: 'Sunny')],
          wind: WeatherWind(speed: 5.0),
        )
      ];

      when(mockWeatherRepository.getWeather(cityName))
          .thenAnswer((_) async => Result.success(testWeatherList));

      await viewModel.fetchWeather();

      // 正常に天気情報が取得されたことを確認
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.weather, isNotNull);
      expect(viewModel.state.weather!.first.main.temp,
          equals(testWeatherList.first.main.temp));
      expect(viewModel.state.errorMessage, isNull);
    });

    test('fetchWeather handles errors correctly', () async {
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 天気情報取得失敗時のエラーハンドリングをテスト
      const cityName = 'Tokyo';
      viewModel.updateCityName(cityName);
      when(mockWeatherRepository.getWeather(cityName))
          .thenAnswer((_) async => Result.failure(DioException(
                requestOptions: RequestOptions(path: ''),
                error: 'Failed to fetch weather',
              )));

      await viewModel.fetchWeather();

      // エラーメッセージが設定されていることを確認
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.weather, isNull);
      expect(viewModel.state.errorMessage, isNotEmpty);
    });

    test('fetchWeather handles empty city name error', () async {
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 都市名が空の場合のエラーメッセージ設定をテスト
      await viewModel.fetchWeather();

      // エラーメッセージが設定されていることを確認
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.errorMessage, isNotEmpty);
    });
  });
}
