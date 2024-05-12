import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/repositories/weather_repository.dart';

import '../mocks/mock_weather_api_client.mocks.dart';

void main() {
  group('WeatherRepository', () {
    late MockWeatherApiClient mockApiClient;
    late WeatherRepository repository;

    // テストの前準備: モックのインスタンスを作成し、リポジトリに依存性を注入
    setUp(() {
      mockApiClient = MockWeatherApiClient();
      repository = WeatherRepository(apiClient: mockApiClient);
    });

    // テストケース: API呼び出し成功時にWeatherModelが正しく生成されるかテスト
    test('成功時にWeatherModelを返す', () async {
      // APIからの応答を模倣するモックの設定
      when(mockApiClient.fetchWeather('Tokyo'))
          .thenAnswer((_) async => Future.value({
                'cityName': 'Tokyo',
                'temperature': 20.0,
                'description': 'Sunny',
                'windSpeed': 5.0,
                'humidity': 70
              }));

      // リポジトリを通じて天気データを取得
      final weather = await repository.getWeather('Tokyo');

      // 取得したデータが期待通りか確認
      expect(weather.cityName, 'Tokyo');
      expect(weather.temperature, 20.0);
      expect(weather.description, 'Sunny');
      expect(weather.windSpeed, 5.0);
      expect(weather.humidity, 70);
    });

    // テストケース: API呼び出し失敗時に適切な例外がスローされるかテスト
    test('API呼び出し失敗時に例外をスローする', () async {
      // 失敗時の応答を模倣するモックの設定
      when(mockApiClient.fetchWeather('Tokyo'))
          .thenThrow(Exception('天気データの取得に失敗'));

      // 例外がスローされることを確認
      expect(() async => await repository.getWeather('Tokyo'), throwsException);
    });
  });
}
