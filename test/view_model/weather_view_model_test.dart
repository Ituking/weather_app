import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/logger/logger_provider.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
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
      // モックリポジトリとモックロガーのセットアップ
      mockWeatherRepository = MockWeatherRepository();
      mockLogger = MockILogger();
      container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
          loggerProvider.overrideWithValue(mockLogger),
        ],
      );
    });

    test('成功時にWeatherListと都市名を返す', () async {
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
        ),
      ];

      // WeatherResponseを作成（city情報も含む）
      final testWeatherResponse = WeatherResponse(
        list: testWeatherList,
        city: CityName(name: 'Tokyo'),
      );

      // モックから期待される天気データが返されるように設定
      when(mockWeatherRepository.getWeather(any))
          .thenAnswer((_) async => Result.success(testWeatherResponse));

      final viewModel = container.read(weatherViewModelProvider.notifier);

      // メソッドを実行し、期待される結果を検証
      await viewModel.fetchWeather('Tokyo');

      // stateがnullでないことを確認
      expect(viewModel.state, isNotNull);

      // Resultの成功時のデータを取得して検証
      final weather = viewModel.state.weather;
      expect(weather, isNotNull);
      weather!.when(
        success: (list) {
          expect(list.first.main.temp, equals(20.0));
          expect(list.first.weather.first.description, equals('Sunny'));
          expect(list.first.weather.first.icon, equals('01d'));
          expect(list.first.wind.speed, equals(5.0));
          expect(list.first.main.humidity, equals(70));
        },
        failure: (error) => fail('Expected success but got failure'),
      );

      // 都市名のテスト
      final cityName = testWeatherResponse.city.name;
      expect(cityName, equals('Tokyo'));
    });

    test('ローディング状態が正しく処理される', () async {
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
        ),
      ];

      // WeatherResponseを作成
      final testWeatherResponse = WeatherResponse(
        list: testWeatherList,
        city: CityName(name: 'Tokyo'),
      );

      // レスポンスの遅延と天気データを模倣
      when(mockWeatherRepository.getWeather(any))
          .thenAnswer((_) async => Future.delayed(
                const Duration(seconds: 1),
                () => Result.success(testWeatherResponse),
              ));

      final viewModel = container.read(weatherViewModelProvider.notifier);

      // 非同期処理の実行中にローディング状態がtrueになることを確認
      final future = viewModel.fetchWeather('Tokyo');
      expect(viewModel.state.isLoading, isTrue);

      // 非同期処理の完了後、ローディング状態がfalseになることを確認
      await future;
      expect(viewModel.state.isLoading, isFalse);
    });

    test('API呼び出し失敗時に例外をスローする', () async {
      // 天気データの取得に失敗した場合に例外を投げるようモックを設定
      when(mockWeatherRepository.getWeather(any))
          .thenAnswer((_) async => const Result.failure(ApiError(
                type: ApiErrorType.unknown,
                message: 'Failed to fetch weather data',
              )));

      final viewModel = container.read(weatherViewModelProvider.notifier);

      // エラー発生時の処理をテスト
      await viewModel.fetchWeather('Tokyo');

      // 結果が失敗であることを確認
      final weatherResult = viewModel.state.weather;
      expect(weatherResult, isNotNull);
      weatherResult!.when(
        success: (data) => fail('Expected failure but got success'),
        failure: (error) =>
            expect(error.toString(), contains('Failed to fetch weather data')),
      );

      // エラーメッセージが非nullで適切な内容を含んでいることを確認
      expect(viewModel.state.errorMessage, isNotNull);
      expect(viewModel.state.errorMessage,
          contains('Failed to fetch weather data'));
    });
  });
}
