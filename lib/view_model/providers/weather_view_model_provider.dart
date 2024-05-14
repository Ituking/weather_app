import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';
import 'package:weather_app/view_model/weather_view_model.dart';
import 'package:weather_app/view_model/weather_view_model_state.dart';

// WeatherViewModelのStateNotifierProvider
// このプロバイダーは、アプリの他の部分でWeatherViewModelを利用するためのアクセスポイントです。
final weatherViewModelProvider =
    StateNotifierProvider<WeatherViewModel, WeatherViewModelState>((ref) {
  // WeatherRepositoryのインスタンスを取得します。
  // WeatherRepositoryは、外部の天気情報サービスからデータを取得する責任を持ちます。
  // このインスタンスは、WeatherViewModel内で天気データの取得と更新のために使用されます。
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  // WeatherViewModelの新しいインスタンスを作成し、依存するWeatherRepositoryを注入
  return WeatherViewModel(weatherRepository);
});
