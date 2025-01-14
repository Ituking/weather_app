import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/api_config_provider.dart';
import '../services/weather_api_client_provider.dart';
import 'weather_repository.dart';
import 'weather_repository_impl.dart';

// weatherRepositoryProviderは、WeatherApiClientとApiConfigに基づいてWeatherRepositoryのインスタンスを作成します。
// このProviderは、WeatherApiClientとApiConfigのインスタンスを取得し、それらを使用してWeatherRepositoryを初期化します。
// WeatherRepositoryはAPIから天気データを取得するためのメソッドを提供し、ViewModel層で使用されます。
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final weatherApiClient = ref.watch(weatherApiClientProvider);
  final apiConfig = ref.watch(apiConfigProvider);

  return WeatherRepositoryImpl(
      apiClient: weatherApiClient, apiConfig: apiConfig, ref: ref);
});
