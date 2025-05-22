import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/response/api_result.dart';
import 'package:weather_app/data/services/weather/weather_api_client.dart';

import '../../../test_helpers/mocks/mock_firebase_functions.mocks.dart';

void main() {
  group('WeatherApiClientのテスト', () {
    late MockFirebaseFunctions mockFunctions;
    late MockHttpsCallable mockCallable;
    late MockHttpsCallableResult mockCallableResult;
    late WeatherApiClient client;

    setUp(() {
      mockFunctions = MockFirebaseFunctions();
      mockCallable = MockHttpsCallable();
      mockCallableResult = MockHttpsCallableResult();

      client = WeatherApiClient(mockFunctions);
    });

    test('API呼び出しが成功した時、天気データを返す', () async {
      when(mockFunctions.httpsCallable('getWeatherForCity'))
          .thenReturn(mockCallable);

      when(mockCallableResult.data).thenReturn({
        'current': {
          'city': 'Tokyo',
          'description': 'Sunny',
          'temperature': 25.0,
          'humidity': 60.0,
          'windSpeed': 5.0,
          'icon': '01d',
          'timestamp': 1234567890,
        },
        'forecast': [
          {
            'city': 'Tokyo',
            'description': 'Sunny',
            'temperature': 24.0,
            'humidity': 55.0,
            'windSpeed': 4.5,
            'icon': '01d',
            'timestamp': 1234567891,
          }
        ],
      });

      when(mockCallable.call({'city': 'Tokyo'}))
          .thenAnswer((_) async => mockCallableResult);

      final result = await client.fetchWeather('Tokyo');

      expect(result, isA<Success<Map<String, dynamic>>>());

      result.when(
        success: (data) {
          expect(data['current']['city'], 'Tokyo');
          expect(data['current']['description'], 'Sunny');
          expect(data['current']['temperature'], 25.0);
          expect(data['current']['humidity'], 60.0);
          expect(data['current']['windSpeed'], 5.0);
        },
        failure: (_) => fail('Expected success but got failure'),
      );
    });

    test('API呼び出しに失敗した場合、エラーを返す', () async {
      when(mockFunctions.httpsCallable('getWeatherForCity'))
          .thenReturn(mockCallable);

      when(mockCallable.call({'city': 'InvalidCity'})).thenThrow(
          FirebaseFunctionsException(message: 'Not found', code: 'not-found'));

      final result = await client.fetchWeather('InvalidCity');

      expect(result, isA<Failure<Map<String, dynamic>>>());
      final error = (result as Failure<Map<String, dynamic>>).error;
      expect(error.message, 'Not found');
    });
  });
}
