import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:weather_app/core/config/env.dart';
import 'package:weather_app/core/network/response/weather_response.dart';

import 'package:weather_app/services/weather_api_client.dart';

void main() {
  group('WeatherApiClientのテスト', () {
    late Dio dio; // Dioインスタンス
    late DioAdapter dioAdapter; // DioAdapterインスタンス
    late WeatherApiClient client; // WeatherApiClientインスタンス

    // 各テスト前に実行される初期設定
    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio); // DioAdapterの初期化
      dio.httpClientAdapter = dioAdapter; // DioのHTTPクライアントアダプターを設定
      client = WeatherApiClient(dio);
    });

    test('API呼び出しが成功した時、天気データを返す', () async {
      const relativeUrl = 'forecast';
      final queryParameters = {
        // APIリクエストのクエリパラメータ
        'q': 'Kumagaya',
        'appId': Env.apiKey,
        'lang': 'ja',
        'units': 'metric',
      };

      // API呼び出しの成功をシミュレートし、期待される天気データを返すモックの設定
      dioAdapter.onGet(
        relativeUrl,
        (server) => server.reply(200, {
          'city': {
            'name': 'Kumagaya',
          },
          'list': [
            {
              'main': {
                'temp': 20.0,
                'humidity': 65,
              },
              'weather': [
                {'description': 'clear sky'}
              ],
              'wind': {'speed': 5.2},
              'dt': DateTime.now().millisecondsSinceEpoch,
            }
          ]
        }),
        queryParameters: queryParameters,
      );

      final result = await client.fetchWeather(
        'Kumagaya',
        Env.apiKey,
        'ja',
        'metric',
      );

      // アサーション: 結果が期待通りかを確認
      expect(result, isA<WeatherResponse>());
      final firstWeather = result.list.first;
      expect(firstWeather.main.temp, 20.0); // 温度
      expect(firstWeather.main.humidity, 65); // 湿度
      expect(firstWeather.weather.first.description, 'clear sky'); // 天気の説明
      expect(firstWeather.wind.speed, 5.2); // 風速
    });

    test('API呼び出しに失敗した場合、例外を投げる', () async {
      const relativeUrl = 'forecast';
      final queryParameters = {
        'q': 'Kumagaya',
        'appId': Env.apiKey,
        'lang': 'ja',
        'units': 'metric',
      };

      // 404 Not Foundエラーを模倣するモックの設定
      dioAdapter.onGet(
        relativeUrl,
        (server) => server
            .reply(404, {'message': 'Not found'}), // 404 Not Found レスポンスをモック
        queryParameters: queryParameters,
      );

      // 関数が例外を投げることを検証
      expect(
          () async => await client.fetchWeather(
                'Kumagaya',
                Env.apiKey,
                'ja',
                'metric',
              ),
          throwsException);
    });
  });
}
