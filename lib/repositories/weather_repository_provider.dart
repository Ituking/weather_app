import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/weather_api_client_provider.dart';
import 'weather_repository.dart';
import 'weather_repository_impl.dart';

/// [weatherRepositoryProvider]は、[WeatherRepository]のインスタンスを提供するプロバイダーです。
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final weatherApiClient = ref.watch(weatherApiClientProvider);

  return WeatherRepositoryImpl(
    apiClient: weatherApiClient,
    ref: ref,
  );
});
