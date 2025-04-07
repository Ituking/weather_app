import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/features/weather/models/forecast.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';
import 'package:weather_app/view_model/weather_view_model.dart';

import '../mocks/mock_weather_repository.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeatherViewModelのテスト', () {
    late MockWeatherRepository mockWeatherRepository;

    late ProviderContainer container;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();

      container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
        ],
      );
    });

    test('成功時にForecastと都市名を返す', () async {
      final testForecast = Forecast(
        id: 'forecast_id_001',
        city: 'Tokyo',
        description: 'Sunny',
        temperature: 20.0,
        humidity: 70.0,
        windSpeed: 5.0,
      );

      when(mockWeatherRepository.getWeather(any))
          .thenAnswer((_) async => Result.success(testForecast));

      final viewModel = container.read(weatherViewModelProvider.notifier);

      await viewModel.fetchWeather('Tokyo');

      expect(viewModel.state, isNotNull);

      // Resultの成功時のデータを取得して検証
      final weather = viewModel.state.weather;
      expect(weather, isNotNull);
      weather!.when(
        success: (data) {
          expect(data.temperature, equals(20.0));
          expect(data.description, equals('Sunny'));
          expect(data.windSpeed, equals(5.0));
          expect(data.humidity, equals(70.0));
        },
        failure: (error) => fail('Expected success but got failure'),
      );

      expect(testForecast.city, equals('Tokyo'));
    });

    test('ローディング状態が正しく処理される', () async {
      final testForecast = Forecast(
        id: 'forecast_id_001',
        city: 'Tokyo',
        description: 'Sunny',
        temperature: 20.0,
        humidity: 70.0,
        windSpeed: 5.0,
      );

      when(mockWeatherRepository.getWeather(any))
          .thenAnswer((_) async => Future.delayed(
                const Duration(seconds: 1),
                () => Result.success(testForecast),
              ));

      final viewModel = container.read(weatherViewModelProvider.notifier);

      final future = viewModel.fetchWeather('Tokyo');
      expect(viewModel.state.isLoading, isTrue);

      await future;
      expect(viewModel.state.isLoading, isFalse);
    });

    test('API呼び出し失敗時に例外をスローする', () async {
      when(mockWeatherRepository.getWeather(any))
          .thenAnswer((_) async => const Result.failure(ApiError(
                type: ApiErrorType.unknown,
                message: 'Failed to fetch weather data',
              )));

      final viewModel = container.read(weatherViewModelProvider.notifier);

      await viewModel.fetchWeather('Tokyo');

      final weatherResult = viewModel.state.weather;
      expect(weatherResult, isNotNull);
      weatherResult!.when(
        success: (data) => fail('Expected failure but got success'),
        failure: (error) =>
            expect(error.toString(), contains('Failed to fetch weather data')),
      );

      expect(viewModel.state.errorMessage, isNotNull);
      expect(viewModel.state.errorMessage,
          contains('Failed to fetch weather data'));
    });
  });
}
