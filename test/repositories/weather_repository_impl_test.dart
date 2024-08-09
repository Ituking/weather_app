import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/dio_error_handler.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/core/network/response/weather_response.dart';
import 'package:weather_app/models/weather_description.dart';
import 'package:weather_app/models/weather_main.dart';
import 'package:weather_app/models/weather_wind.dart';
import 'package:weather_app/repositories/weather_repository_impl.dart';
import 'package:weather_app/view_model/providers/dio_error_handler_provider.dart';

import '../mocks/mock_provider_ref.mocks.dart';
import '../mocks/mock_weather_api_client.mocks.dart';

void main() {
  group('WeatherRepositoryImpl', () {
    late MockWeatherApiClient mockApiClient; // WeatherApiClientのモック
    late MockProviderRef mockRef; // ProviderRefのモック
    late DioErrorHandler dioErrorHandler; // DioErrorHandlerのインスタンス
    late WeatherRepositoryImpl repository; // テスト対象のリポジトリ

    setUp(() {
      // モックおよび依存関係の初期化
      mockApiClient = MockWeatherApiClient();
      mockRef = MockProviderRef();
      dioErrorHandler = DioErrorHandler();

      // ProviderRefのモックにDioErrorHandlerを設定
      when(mockRef.read<DioErrorHandler?>(dioErrorHandlerProvider))
          .thenReturn(dioErrorHandler);

      // WeatherRepositoryImplのインスタンスを作成
      repository =
          WeatherRepositoryImpl(apiClient: mockApiClient, ref: mockRef);
    });

    // 正常に天気データを取得できることをテスト
    test('成功時にWeatherListのリストを返す', () async {
      // モックのWeatherResponseを作成
      final weatherResponse = WeatherResponse(list: [
        WeatherList(
          main: WeatherMain(temp: 20.0, humidity: 70),
          weather: [WeatherDescription(description: 'Sunny')],
          wind: WeatherWind(speed: 5.0),
        )
      ]);

      // fetchWeatherのモック設定
      when(mockApiClient.fetchWeather('Tokyo', any, any, any))
          .thenAnswer((_) async => weatherResponse);

      // 天気データを取得
      final result = await repository.getWeather('Tokyo');

      // 成功したかを検証
      expect(result, isA<Success<List<WeatherList>>>());
      final weatherList = (result as Success<List<WeatherList>>).value;

      // 取得したデータの検証
      expect(weatherList.first.main.temp, 20.0);
      expect(weatherList.first.weather.first.description, 'Sunny');
      expect(weatherList.first.wind.speed, 5.0);
      expect(weatherList.first.main.humidity, 70);
    });

    // 無効な都市名の場合に例外をスローすることをテスト
    test('無効な都市名で失敗時に例外をスローする', () async {
      // fetchWeatherが例外をスローするようにモック設定
      when(mockApiClient.fetchWeather('InvalidCity', any, any, any))
          .thenThrow(Exception('天気データの取得に失敗'));

      // 天気データ取得を試みる
      final result = await repository.getWeather('InvalidCity');

      // 失敗したかを検証
      expect(result, isA<Failure<List<WeatherList>>>());
    });
  });
}
