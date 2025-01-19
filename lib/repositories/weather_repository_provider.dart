import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/api_config_provider.dart';
import '../services/weather_api_client_provider.dart';
import 'weather_repository.dart';
import 'weather_repository_impl.dart';

/// [weatherRepositoryProvider]は、[WeatherRepository]のインスタンスを提供するプロバイダーです。
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final weatherApiClient = ref.watch(weatherApiClientProvider);
  final apiConfig = ref.watch(apiConfigProvider);

  return WeatherRepositoryImpl(
    apiClient: weatherApiClient,
    apiConfig: apiConfig,
    ref: ref,
  );
});
