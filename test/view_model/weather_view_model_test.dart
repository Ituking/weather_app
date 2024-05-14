import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/view_model/weather_view_model.dart';

import '../mocks/mock_weather_repository.mocks.dart';

void main() {
  group('WeatherViewModel Test', () {
    late MockWeatherRepository mockWeatherRepository;
    late WeatherViewModel viewModel;

    setUp(() {
      // モックリポジトリのセットアップとViewModelの初期化
      mockWeatherRepository = MockWeatherRepository();
      viewModel = WeatherViewModel(mockWeatherRepository);
    });

    test('成功時にWeatherModelを返す', () async {
      const testWeather = WeatherModel(
        temperature: 20.0,
        description: 'Sunny',
        windSpeed: 5.0,
        humidity: 70,
        cityName: 'Tokyo',
      );

      // モックから期待される天気データが返されるように設定
      when(mockWeatherRepository.getWeather(any))
          .thenAnswer((_) async => testWeather);

      // メソッドを実行し、期待される結果を検証
      await viewModel.fetchWeather('Tokyo');

      // stateがnullでないことを確認
      expect(viewModel.state, isNotNull);
      // WeatherModelの各属性を正しくチェック
      expect(viewModel.state.weather!.temperature, equals(20.0));
      expect(viewModel.state.weather!.description, equals('Sunny'));
      expect(viewModel.state.weather!.windSpeed, equals(5.0));
      expect(viewModel.state.weather!.humidity, equals(70));
      expect(viewModel.state.weather!.cityName, equals('Tokyo'));
    });

    test('ローディング状態が正しく処理される', () async {
      // レスポンスの遅延と天気データを模倣
      when(mockWeatherRepository.getWeather(any))
          .thenAnswer((_) async => Future.delayed(
              const Duration(seconds: 1),
              () => const WeatherModel(
                    temperature: 20.0,
                    description: 'Sunny',
                    windSpeed: 5.0,
                    humidity: 70,
                    cityName: 'Tokyo',
                  )));

      // 非同期処理の実行中にローディング状態がtrueになることを確認
      final future = viewModel.fetchWeather('Tokyo');
      expect(viewModel.state.isLoading, isTrue);

      // 非同期処理の完了後、ローディング状態がfalseになることを確認
      await future;
      expect(viewModel.state.isLoading, isFalse);
    });

    test('API呼び出し失敗時に例外をスローする', () async {
      // 天気データの取得に失敗した場合に例外を投げるようモックを設定
      when(mockWeatherRepository.getWeather(any))
          .thenThrow(Exception('Failed to fetch weather data'));

      // エラー発生時の処理をテスト
      // メソッド実行前には例外を投げると設定しているため、エラーハンドリングが正しく機能するか確認します
      await viewModel.fetchWeather('Tokyo');
      // エラーが発生した際に、weatherプロパティがnullであることを確認
      expect(viewModel.state.weather, isNull);
      // エラーメッセージが非nullで適切な内容を含んでいることを確認
      expect(viewModel.state.errorMessage, isNotNull);
      expect(viewModel.state.errorMessage,
          contains('Failed to fetch weather data'));
    });
  });
}
