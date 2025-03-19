import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/logger/logger_provider.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_response.dart';
import 'package:weather_app/models/city_name.dart';
import 'package:weather_app/models/weather_description.dart';
import 'package:weather_app/models/weather_main.dart';
import 'package:weather_app/models/weather_wind.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';
import 'package:weather_app/view_model/weather_view_model.dart';

import '../core/logger/mock_i_logger.mocks.dart';
import '../mocks/mock_weather_repository.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeatherViewModelのテスト', () {
    late MockWeatherRepository mockWeatherRepository;
    late MockILogger mockLogger;
    late ProviderContainer container;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      mockLogger = MockILogger();
      container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
          loggerProvider.overrideWithValue(mockLogger),
        ],
      );
    });

    test('成功時にWeatherResponseと都市名を返す', () async {
      // WeatherResponseを作成
      final testWeatherResponse = WeatherResponse(
        main: WeatherMain(temp: 20.0, humidity: 70),
        weather: WeatherDescription(
          description: 'Sunny',
          icon: '01d',
        ),
        wind: WeatherWind(speed: 5.0),
        city: CityName(name: 'Tokyo'),
      );

      when(mockWeatherRepository.getWeather(any))
          .thenAnswer((_) async => Result.success(testWeatherResponse));

      final viewModel = container.read(weatherViewModelProvider.notifier);

      await viewModel.fetchWeather('Tokyo');

      expect(viewModel.state, isNotNull);

      // Resultの成功時のデータを取得して検証
      final weather = viewModel.state.weather;
      expect(weather, isNotNull);
      weather!.when(
        success: (data) {
          expect(data.main.temp, equals(20.0));
          expect(data.weather.description, equals('Sunny'));
          expect(data.weather.icon, equals('01d'));
          expect(data.wind.speed, equals(5.0));
          expect(data.main.humidity, equals(70));
        },
        failure: (error) => fail('Expected success but got failure'),
      );

      expect(testWeatherResponse.city.name, equals('Tokyo'));
    });

    test('ローディング状態が正しく処理される', () async {
      final testWeatherResponse = WeatherResponse(
        main: WeatherMain(temp: 20.0, humidity: 70),
        weather: WeatherDescription(
          description: 'Sunny',
          icon: '01d',
        ),
        wind: WeatherWind(speed: 5.0),
        city: CityName(name: 'Tokyo'),
      );

      when(mockWeatherRepository.getWeather(any))
          .thenAnswer((_) async => Future.delayed(
                const Duration(seconds: 1),
                () => Result.success(testWeatherResponse),
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
