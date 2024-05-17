import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/repositories/weather_repository_impl.dart';

import '../mocks/mock_weather_api_client.mocks.dart';

void main() {
  group('WeatherRepositoryImpl', () {
    // モックのWeatherApiClientとWeatherRepositoryImplのインスタンスを保持する変数
    late MockWeatherApiClient mockApiClient;
    late WeatherRepositoryImpl repository;

    // 各テストの前に実行されるセットアップ処理
    setUp(() {
      // MockWeatherApiClientのインスタンスを作成
      mockApiClient = MockWeatherApiClient();
      // WeatherRepositoryImplのインスタンスを作成し、MockWeatherApiClientを注入
      repository = WeatherRepositoryImpl(apiClient: mockApiClient);
    });

    // 成功時にWeatherModelを返すテストケース
    test('成功時にWeatherModelを返す', () async {
      // MockWeatherApiClientがfetchWeatherを呼び出した際に返すデータを設定
      when(mockApiClient.fetchWeather('Tokyo')).thenAnswer((_) async => {
            'cityName': 'Tokyo',
            'temperature': 20.0,
            'description': 'Sunny',
            'windSpeed': 5.0,
            'humidity': 70,
          });

      // WeatherRepositoryImplを使用して天気データを取得
      final weather = await repository.getWeather('Tokyo');

      // 取得したデータが期待通りか確認
      expect(weather.cityName, 'Tokyo');
      expect(weather.temperature, 20.0);
      expect(weather.description, 'Sunny');
      expect(weather.windSpeed, 5.0);
      expect(weather.humidity, 70);
    });

    // API呼び出し失敗時に例外をスローするテストケース
    test('API呼び出し失敗時に例外をスローする', () async {
      // MockWeatherApiClientがfetchWeatherを呼び出した際に例外をスローするように設定
      when(mockApiClient.fetchWeather('Tokyo'))
          .thenThrow(Exception('天気データの取得に失敗'));

      // 例外がスローされることを確認
      expect(() async => await repository.getWeather('Tokyo'), throwsException);
    });
  });
}
