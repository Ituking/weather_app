import 'package:dio/dio.dart';
import 'package:weather_app/core/config/env.dart';

// WeatherApiClientクラスは、外部の天気情報APIを呼び出して天気データを取得する責任を持ちます。
class WeatherApiClient {
  final Dio dio; // Dio HTTPクライアントのインスタンス。外部から依存性を注入することでテストが容易になります。

  // コンストラクタでは、Dioインスタンスを必須パラメータとして受け取ります。
  // [dio] Dioインスタンスを注入することで、HTTPリクエストのカスタマイズやモック化が可能になります。
  WeatherApiClient({required this.dio});

  // 天気情報を取得する非同期関数です。
  // [cityName] には、天気情報を取得したい都市の名前を指定します。
  // この関数は、成功時には天気データのMapを、失敗時には例外を返します。
  Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    // OpenWeatherMapのエンドポイントURL
    const url = 'https://api.openweathermap.org/data/2.5/forecast';
    // APIリクエストのクエリパラメータ。都市名、APIキー、言語（日本語)、単位（摂氏）を含む。
    final queryParameters = {
      'q': cityName,
      'appId': Env.apiKey, // EnvクラスからAPIキーを取得。
      'lang': 'ja', // 言語を日本語に設定。
      'units': 'metric', // 単位を摂氏に設定。
    };

    try {
      // Dioを使用してHTTP GETリクエストを送信し、レスポンスを受け取る。
      final response = await dio.get(url, queryParameters: queryParameters);
      // ステータスコードが200（成功）の場合、データを返す。
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // 200以外のステータスコードの場合、例外を投げる。
        throw Exception(
            'Failed to load weather data. Status code: ${response.statusCode}, Body: ${response.data}');
      }
    } catch (e) {
      // 通信エラーの場合、例外を投げる。
      throw Exception('Failed to load weather data: $e');
    }
  }
}
