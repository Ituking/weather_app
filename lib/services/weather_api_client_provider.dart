import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/network/dio_provider.dart';
import 'package:weather_app/services/weather_api_client.dart';

// WeatherApiClientのProvider
// このProviderは、Dioクライアントを使用してWeatherApiClientのインスタンスを作成します。
// WeatherApiClientはAPIから天気情報を取得するためのメソッドを提供します。
final weatherApiClientProvider = Provider<WeatherApiClient>((ref) {
  // DioプロバイダーからDioインスタンスを取得。
  // DioはHTTPリクエストを実行するために使用され、設定されたAPIエンドポイントに接続します。
  final dio = ref.watch(dioProvider);
  // Dioインスタンスを引数にWeatherApiClientを生成。
  // WeatherApiClientは、天気データを取得するためのAPI呼び出しを管理します。
  return WeatherApiClient(dio: dio);
});
