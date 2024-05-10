import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:weather_app/core/config/env.dart';
import 'package:weather_app/services/weather_api_client.dart';

void main() {
  group('WeatherApiClientのテスト', () {
    late Dio dio; // Dioインスタンス
    late DioAdapter dioAdapter; // DioAdapterインスタンス
    late WeatherApiClient client; // WeatherApiClientインスタンス

    // 各テスト前に実行される初期設定
    setUp(() {
      dio = Dio(BaseOptions());
      dioAdapter = DioAdapter(dio: dio); // DioAdapterの初期化
      client = WeatherApiClient(dio: dio); // WeatherApiClientの初期化
      dio.httpClientAdapter = dioAdapter; // DioのHTTPクライアントアダプターを設定
    });

    // 天気情報取得のAPI呼び出しが正常に動作することを検証
    test('API呼び出しが成功した時、天気データを返す', () async {
      const url = 'https://api.openweathermap.org/data/2.5/forecast';
      final queryParameters = {
        // APIリクエストのクエリパラメータ
        'q': 'Kumagaya',
        'appId': Env.apiKey,
        'lang': 'ja',
        'units': 'metric',
      };

      // API呼び出しの成功をシミュレートし、期待される天気データを返すモックの設定
      dioAdapter.onGet(
        url,
        (server) => server.reply(200, {
          'name': 'Kumagaya',
          'weather': [
            {'description': 'clear sky', 'icon': '01d'}
          ],
          'main': {'temp': 20.0, 'humidity': 65},
          'wind': {'speed': 5.2}
        }),
        queryParameters: queryParameters,
      );

      final result = await client.fetchWeather('Kumagaya');

      // アサーション: 結果が期待通りかを確認
      expect(result['name'], 'Kumagaya'); // 都市名
      expect(result['weather'][0]['description'], 'clear sky'); // 天気の説明
      expect(result['main']['temp'], 20.0); // 温度
      expect(result['main']['humidity'], 65); // 湿度
      expect(result['wind']['speed'], 5.2); // 風速
    });

    // API呼び出しに失敗した場合、例外が投げられることを確認するテストケース
    test('API呼び出しに失敗した場合、例外を投げる', () async {
      const url = 'https://api.openweathermap.org/data/2.5/forecast';
      final queryParameters = {
        'q': 'Kumagaya',
        'appId': Env.apiKey,
        'lang': 'ja',
        'units': 'metric',
      };

      // 404 Not Foundエラーを模倣するモックの設定
      dioAdapter.onGet(
        url,
        (server) => server
            .reply(404, {'message': 'Not found'}), // 404 Not Found レスポンスをモック
        queryParameters: queryParameters,
      );

      // 関数が例外を投げることを検証
      expect(
          () async => await client.fetchWeather('Kumagaya'), throwsException);
    });
  });
}
