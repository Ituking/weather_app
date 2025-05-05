import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/data/repositories/weather/weather_repository_provider.dart';
import 'package:weather_app/data/services/weather/stub_weather_data_source.dart';
import 'package:weather_app/data/services/weather/weather_api_client_provider.dart';
import 'package:weather_app/domain/models/weather/forecast.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('StubWeatherDataSourceを使用したWeatherRepositoryImplのテスト', () {
    late ProviderContainer container;

    // 各テスト前に実行されるセットアップ処理
    setUp(() {
      container = ProviderContainer(overrides: [
        weatherApiClientProvider.overrideWithValue(StubWeatherDataSource()),
      ]);
    });

    test('成功時にWeatherResponseを返す', () async {
      // weatherRepositoryProviderからリポジトリを取得
      final repository = container.read(weatherRepositoryProvider);

      // 東京の天気データを取得
      final result = await repository.getWeather('Tokyo');

      // 成功かどうかをチェック
      expect(result, isA<Success<List<Forecast>>>());

      // 成功時の結果を取得
      final weatherResponse = (result as Success<List<Forecast>>).value;

      // データが期待通りか確認
      expect(weatherResponse, isA<List<Forecast>>());
      expect(weatherResponse.first.temperature, 20.0);
      expect(weatherResponse.first.description, 'Sunny');
      expect(weatherResponse.first.windSpeed, 5.0);
      expect(weatherResponse.first.humidity, 70);
    });

    test('API呼び出し失敗時にResult.failureを返す', () async {
      // weatherRepositoryProviderからリポジトリを取得
      final repository = container.read(weatherRepositoryProvider);

      // 無効な都市名の天気データを取得
      final result = await repository.getWeather('InvalidCity');

      // 失敗かどうかをチェック
      expect(result, isA<Failure<List<Forecast>>>());
    });
  });
}
