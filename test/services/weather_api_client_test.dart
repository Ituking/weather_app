import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_response.dart';
import 'package:weather_app/models/city_name.dart';
import 'package:weather_app/services/weather_api_client.dart';

import '../mocks/mock_firebase_functions.mocks.dart';

void main() {
  group('WeatherApiClientのテスト', () {
    late MockFirebaseFunctions mockFunctions;
    late MockHttpsCallable mockCallable;
    late MockHttpsCallableResult mockCallableResult;
    late WeatherApiClient client;

    final weatherResponse = WeatherResponse(
      list: [],
      city: CityName(name: 'Tokyo'),
    );

    setUp(() {
      mockFunctions = MockFirebaseFunctions();
      mockCallable = MockHttpsCallable();
      mockCallableResult = MockHttpsCallableResult();

      client = WeatherApiClient(mockFunctions);
    });

    test('API呼び出しが成功した時、天気データを返す', () async {
      when(mockFunctions.httpsCallable('getWeatherForCity'))
          .thenReturn(mockCallable);

      when(mockCallableResult.data).thenReturn(weatherResponse.toJson());

      when(mockCallable.call({'city': 'Tokyo'}))
          .thenAnswer((_) async => mockCallableResult);

      final result = await client.fetchWeather('Tokyo');

      expect(result, isA<Success<WeatherResponse>>());
    });

    test('API呼び出しに失敗した場合、エラーを返す', () async {
      when(mockFunctions.httpsCallable('getWeatherForCity'))
          .thenReturn(mockCallable);

      when(mockCallable.call({'city': 'InvalidCity'})).thenThrow(
          FirebaseFunctionsException(message: 'Not found', code: 'not-found'));

      final result = await client.fetchWeather('InvalidCity');

      expect(result, isA<Failure<WeatherResponse>>());
      final error = (result as Failure<WeatherResponse>).error;
      expect(error.message, 'Not found');
    });
  });
}
