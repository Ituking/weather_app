import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/core/network/response/weather_response.dart';
import 'package:weather_app/models/city_name.dart';
import 'package:weather_app/models/weather_description.dart';
import 'package:weather_app/models/weather_main.dart';
import 'package:weather_app/models/weather_wind.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';
import 'package:weather_app/view_model/providers/city_search_view_model_provider.dart';

import '../mocks/mock_weather_repository.mocks.dart';

void main() {
  group('CitySearchViewModelのテスト', () {
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

    test('updateCityNameで都市名が正しく更新される', () {
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 都市名の更新テスト
      const cityName = 'New York';
      viewModel.updateCityName(cityName);

      // 都市名が正しく更新されたことを確認
      expect(viewModel.state.cityName, cityName);
    });

    test('fetchWeatherが成功時に状態を更新する', () async {
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 天気情報取得成功時の状態更新をテスト
      const cityName = 'Tokyo';
      viewModel.updateCityName(cityName);

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
        )
      ];

      final testWeatherResponse = WeatherResponse(
        list: testWeatherList,
        city: CityName(name: cityName),
      );

      when(mockWeatherRepository.getWeather(cityName))
          .thenAnswer((_) async => Result.success(testWeatherResponse));

      await viewModel.fetchWeather();

      // 正常に天気情報が取得されたことを確認
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.weather, isNotNull);
      expect(viewModel.state.weather!.list.first.main.temp,
          equals(testWeatherList.first.main.temp));
      expect(viewModel.state.weather!.city.name, cityName);
      expect(viewModel.state.weather!.list.first.weather.first.icon, '01d');
      expect(viewModel.state.errorMessage, isNull);
    });

    test('fetchWeatherがエラーを正しく処理する', () async {
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 天気情報取得失敗時のエラーハンドリングをテスト
      const cityName = 'Tokyo';
      viewModel.updateCityName(cityName);
      when(mockWeatherRepository.getWeather(cityName))
          .thenAnswer((_) async => const Result.failure(ApiError(
                type: ApiErrorType.unknown,
                message: 'Failed to fetch weather',
              )));

      await viewModel.fetchWeather();

      // エラーメッセージが設定されていることを確認
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.weather, isNull);
      expect(viewModel.state.errorMessage, isNotEmpty);
    });

    test('fetchWeatherが空の都市名のエラーを処理する', () async {
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
