import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/repositories/weather_repository_impl.dart';
import 'package:weather_app/services/weather_api_client_provider.dart';

// WeatherRepositoryProviderは、WeatherApiClientに基づいてWeatherRepositoryのインスタンスを作成します。
// このProviderは、WeatherApiClientのインスタンスを取得し、それを使ってWeatherRepositoryを初期化します。
// WeatherRepositoryはAPIから天気データを取得するためのメソッドを提供し、これをViewModel層で使用します。
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  // WeatherApiClientProviderからWeatherApiClientのインスタンスを取得。
  // このインスタンスはAPI呼び出しを担当し、その結果をRepository層で利用可能にします。
  final weatherApiClient = ref.watch(weatherApiClientProvider);

  // WeatherApiClientを使用して、天気データの取得と操作を行うWeatherRepositoryを生成。
  return WeatherRepositoryImpl(apiClient: weatherApiClient, ref: ref);
});
