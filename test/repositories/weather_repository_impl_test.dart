import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/core/network/response/weather_response.dart';
import 'package:weather_app/models/weather_description.dart';
import 'package:weather_app/models/weather_main.dart';
import 'package:weather_app/models/weather_wind.dart';
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

    // 成功時にWeatherListのリストを返すテストケース
    test('成功時にWeatherListのリストを返す', () async {
      // モックのWeatherResponseを作成
      final weatherResponse = WeatherResponse(list: [
        WeatherList(
          main: WeatherMain(temp: 20.0, humidity: 70),
          weather: [WeatherDescription(description: 'Sunny')],
          wind: WeatherWind(speed: 5.0),
        )
      ]);

      // MockWeatherApiClientがfetchWeatherを呼び出した際に返すデータを設定
      when(mockApiClient.fetchWeather('Tokyo', any, any, any))
          .thenAnswer((_) async => weatherResponse);

      // WeatherRepositoryImplを使用して天気データを取得
      final result = await repository.getWeather('Tokyo');

      // 成功かどうかをチェック
      expect(result, isA<Success<List<WeatherList>>>());

      // 成功時の結果を取得
      final weatherList = (result as Success<List<WeatherList>>).value;

      // 取得したデータが期待通りか確認
      expect(weatherList.first.main.temp, 20.0);
      expect(weatherList.first.weather.first.description, 'Sunny');
      expect(weatherList.first.wind.speed, 5.0);
      expect(weatherList.first.main.humidity, 70);
    });

    // API呼び出し失敗時に例外をスローするテストケース
    test('無効な都市名で失敗時に例外をスローする', () async {
      // MockWeatherApiClientがfetchWeatherを呼び出した際に例外をスローするように設定
      when(mockApiClient.fetchWeather('InvalidCity', any, any, any))
          .thenThrow(Exception('天気データの取得に失敗'));

      final result = await repository.getWeather('InvalidCity');

      // 失敗かどうかをチェック
      expect(result, isA<Failure<List<WeatherList>>>());
    });
  });
}
