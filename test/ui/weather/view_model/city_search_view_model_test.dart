import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/data/repositories/weather/firestore_weather_repository_provider.dart';
import 'package:weather_app/domain/models/weather/forecast.dart';
import 'package:weather_app/ui/weather/view_model/providers/city_search_view_model_provider.dart';

import '../../../features/weather/mocks/mock_firestore_weather_repository.mocks.dart';

void main() {
  group('CitySearchViewModelのテスト', () {
    late MockFirestoreWeatherRepository mockFirestoreWeatherRepository;
    late ProviderContainer container;

    setUp(() {
      // モックリポジトリの初期化
      mockFirestoreWeatherRepository = MockFirestoreWeatherRepository();
      // ProviderContainerの初期化
      container = ProviderContainer(overrides: [
        firestoreWeatherRepositoryProvider
            .overrideWithValue(mockFirestoreWeatherRepository),
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

      final testForecast = Forecast(
        id: 'forecast_id_001',
        city: cityName,
        description: 'Sunny',
        temperature: 20.0,
        humidity: 70.0,
        windSpeed: 5.0,
      );

      when(mockFirestoreWeatherRepository.fetchForecast(cityName))
          .thenAnswer((_) async => Result.success(testForecast));

      await viewModel.fetchWeather();

      // 正常に天気情報が取得されたことを確認
      expect(viewModel.state.isLoading, isFalse);
      expect(viewModel.state.weather, isNotNull);
      expect(viewModel.state.weather!.temperature,
          equals(testForecast.temperature));
      expect(viewModel.state.weather!.city, cityName);
      expect(viewModel.state.weather!.description, 'Sunny');
      expect(viewModel.state.weather!.windSpeed, 5.0);
      expect(viewModel.state.weather!.humidity, 70.0);
      expect(viewModel.state.errorMessage, isNull);
    });

    test('fetchWeatherがエラーを正しく処理する', () async {
      // ViewModelをプロバイダーから取得
      final viewModel = container.read(citySearchViewModelProvider.notifier);

      // 天気情報取得失敗時のエラーハンドリングをテスト
      const cityName = 'Tokyo';
      viewModel.updateCityName(cityName);
      when(mockFirestoreWeatherRepository.fetchForecast(cityName))
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
