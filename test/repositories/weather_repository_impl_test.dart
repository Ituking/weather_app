import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/logger/i_logger.dart';
import 'package:weather_app/core/logger/logger_provider.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/dio_error_handler.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/core/network/response/weather_response.dart';
import 'package:weather_app/models/city_name.dart';
import 'package:weather_app/models/weather_description.dart';
import 'package:weather_app/models/weather_main.dart';
import 'package:weather_app/models/weather_wind.dart';
import 'package:weather_app/repositories/weather_repository_impl.dart';
import 'package:weather_app/view_model/providers/dio_error_handler_provider.dart';

import '../core/logger/mock_i_logger.mocks.dart';
import '../mocks/mock_ref.mocks.dart';
import '../mocks/mock_weather_api_client.mocks.dart';

void main() {
  group('WeatherRepositoryImplのテスト', () {
    late MockWeatherApiClient mockApiClient; // WeatherApiClientのモック
    late MockRef mockRef; // Refのモック
    late DioErrorHandler dioErrorHandler; // DioErrorHandlerのインスタンス
    late WeatherRepositoryImpl repository; // テスト対象のリポジトリ
    late MockILogger mockLogger; // ILoggerのモック

    final weatherResponse = WeatherResponse(
      list: [
        WeatherList(
          main: WeatherMain(temp: 20.0, humidity: 70),
          weather: [
            WeatherDescription(
              description: 'Sunny',
              icon: '01d',
            ),
          ],
          wind: WeatherWind(speed: 5.0),
        ),
      ],
      city: CityName(name: 'Tokyo'),
    );

    setUp(() {
      // ILoggerのダミーを提供
      provideDummy<ILogger>(MockILogger());

      // モックおよび依存関係の初期化
      mockApiClient = MockWeatherApiClient();
      mockRef = MockRef();
      dioErrorHandler = DioErrorHandler();
      mockLogger = MockILogger();

      // ProviderRefのモックにDioErrorHandlerとILoggerを設定
      when(mockRef.read<DioErrorHandler?>(dioErrorHandlerProvider))
          .thenReturn(dioErrorHandler);
      when(mockRef.read<ILogger>(loggerProvider)).thenReturn(mockLogger);

      // WeatherRepositoryImplのインスタンスを作成
      repository =
          WeatherRepositoryImpl(apiClient: mockApiClient, ref: mockRef);
    });

    test('成功時にWeatherResponseを返す', () async {
      // fetchWeatherのモック設定
      when(mockApiClient.fetchWeather('Tokyo'))
          .thenAnswer((_) async => Result.success(weatherResponse));

      // 天気データを取得
      final result = await repository.getWeather('Tokyo');

      // 成功したかを検証
      expect(result, isA<Success<WeatherResponse>>());
      final weatherData = (result as Success<WeatherResponse>).value;

      // 取得したデータの検証
      expect(weatherData.city.name, 'Tokyo');
      expect(weatherData.list.first.main.temp, 20.0);
      expect(weatherData.list.first.weather.first.description, 'Sunny');
      expect(weatherData.list.first.weather.first.icon, '01d');
      expect(weatherData.list.first.wind.speed, 5.0);
      expect(weatherData.list.first.main.humidity, 70);
    });

    test('無効な都市名で失敗時に適切なエラーを返す', () async {
      // fetchWeatherがエラーを返すようにモック設定
      when(mockApiClient.fetchWeather('InvalidCity')).thenAnswer((_) async =>
          Result.failure(
              ApiError(type: ApiErrorType.unknown, message: '天気データの取得に失敗')));

      // 天気データ取得を試みる
      final result = await repository.getWeather('InvalidCity');

      // 失敗したかを検証
      expect(result, isA<Failure<WeatherResponse>>());
      final error = (result as Failure<WeatherResponse>).error;

      // エラーメッセージが正しいか確認
      expect(error.message, '天気データの取得に失敗');
    });
  });
}
