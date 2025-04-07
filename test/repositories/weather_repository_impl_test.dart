import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/features/weather/models/forecast.dart';
import 'package:weather_app/repositories/weather_repository_impl.dart';

import '../mocks/mock_weather_api_client.mocks.dart';

void main() {
  group('WeatherRepositoryImplのテスト', () {
    late MockWeatherApiClient mockApiClient; // WeatherApiClientのモック
    late WeatherRepositoryImpl repository; // テスト対象のリポジトリ

    final forecast = Forecast(
      id: 'forecast_id_001',
      city: 'Tokyo',
      description: 'Sunny',
      temperature: 20.0,
      humidity: 70.0,
      windSpeed: 5.0,
    );

    setUp(() {
      mockApiClient = MockWeatherApiClient();

      // WeatherRepositoryImplのインスタンスを作成
      repository = WeatherRepositoryImpl(apiClient: mockApiClient);
    });

    test('成功時にWeatherResponseを返す', () async {
      // fetchWeatherのモック設定
      when(mockApiClient.fetchWeather('Tokyo'))
          .thenAnswer((_) async => Result.success(forecast));

      // 天気データを取得
      final result = await repository.getWeather('Tokyo');

      // 成功したかを検証
      expect(result, isA<Success<Forecast>>());
      final weatherData = (result as Success<Forecast>).value;

      // 取得したデータの検証
      expect(weatherData.city, 'Tokyo');
      expect(weatherData.temperature, 20.0);
      expect(weatherData.description, 'Sunny');
      expect(weatherData.windSpeed, 5.0);
      expect(weatherData.humidity, 70);
    });

    test('無効な都市名で失敗時に適切なエラーを返す', () async {
      // fetchWeatherがエラーを返すようにモック設定
      when(mockApiClient.fetchWeather('InvalidCity')).thenAnswer((_) async =>
          Result.failure(
              ApiError(type: ApiErrorType.unknown, message: '天気データの取得に失敗')));

      // 天気データ取得を試みる
      final result = await repository.getWeather('InvalidCity');

      // 失敗したかを検証
      expect(result, isA<Failure<Forecast>>());
      final error = (result as Failure<Forecast>).error;

      // エラーメッセージが正しいか確認
      expect(error.message, '天気データの取得に失敗');
    });
  });
}
