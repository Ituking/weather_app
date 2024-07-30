import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/models/weather_model.dart';
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
    test('成功時にWeatherModelのリストを返す', () async {
      // weatherRepositoryProviderからリポジトリを取得
      final repository = container.read(weatherRepositoryProvider);

      // 東京の天気データを取得
      final result = await repository.getWeather('Tokyo');

      // 成功かどうかをチェック
      expect(result, isA<Success<List<WeatherModel>>>());

      // 成功時の結果を取得
      final weather = (result as Success<List<WeatherModel>>).value;

      // データが期待通りか確認
      expect(weather, isA<List<WeatherModel>>());
      expect(weather.first.cityName, 'Tokyo');
      expect(weather.first.temperature, 20.0);
      expect(weather.first.description, 'Sunny');
      expect(weather.first.windSpeed, 5.0);
      expect(weather.first.humidity, 70);
    });

    // API呼び出しが失敗した場合に例外がスローされるかのテスト
    test('API呼び出し失敗時に例外をスローする', () {
      // 必要に応じてStubWeatherDataSourceに例外をスローするロジックを追加してテストする
      expect(
          () async => await container
              .read(weatherRepositoryProvider)
              .getWeather('InvalidCity'),
          throwsException);
    });
  });
}
