import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';
import 'package:weather_app/services/stub_weather_data_source.dart';
import 'package:weather_app/services/weather_api_client_provider.dart';

void main() {
  group('WeatherRepositoryImpl with StubWeatherDataSource', () {
    late ProviderContainer container;

    // 各テスト前に実行されるセットアップ処理
    setUp(() {
      // ProviderContainerを作成し、weatherApiClientProviderをStubWeatherDataSourceでオーバーライド
      container = ProviderContainer(overrides: [
        weatherApiClientProvider.overrideWithValue(StubWeatherDataSource())
      ]);
    });

    // 正常に天気データが取得できるかのテスト
    test('成功時にWeatherListのリストを返す', () async {
      // weatherRepositoryProviderからリポジトリを取得
      final repository = container.read(weatherRepositoryProvider);

      // 東京の天気データを取得
      final result = await repository.getWeather('Tokyo');

      // 成功かどうかをチェック
      expect(result, isA<Success<List<WeatherList>>>());

      // 成功時の結果を取得
      final weatherList = (result as Success<List<WeatherList>>).value;

      // データが期待通りか確認
      expect(weatherList, isA<List<WeatherList>>());
      expect(weatherList.first.main.temp, 20.0);
      expect(weatherList.first.weather.first.description, 'Sunny');
      expect(weatherList.first.wind.speed, 5.0);
      expect(weatherList.first.main.humidity, 70);
    });

    // API呼び出しが失敗した場合に例外がスローされるかのテスト
    test('API呼び出し失敗時にResult.failureを返す', () async {
      // weatherRepositoryProviderからリポジトリを取得
      final repository = container.read(weatherRepositoryProvider);

      // 無効な都市名の天気データを取得
      final result = await repository.getWeather('InvalidCity');

      // 失敗かどうかをチェック
      expect(result, isA<Failure<List<WeatherList>>>());
    });
  });
}
