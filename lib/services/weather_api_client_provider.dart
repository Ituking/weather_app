import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/network/dio_provider.dart';
import 'weather_api_client.dart';

/// [WeatherApiClient]のインスタンスを提供するプロバイダー。
final weatherApiClientProvider = Provider<WeatherApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return WeatherApiClient(dio);
});
