import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/firebase/providers/firebase_functions_provider.dart';
import 'i_weather_api_client.dart';
import 'weather_api_client.dart';

/// [WeatherApiClient]のインスタンスを提供するプロバイダー。
final weatherApiClientProvider = Provider<IWeatherApiClient>((ref) {
  final functions = ref.read(firebaseFunctionsProvider);
  return WeatherApiClient(functions);
});
