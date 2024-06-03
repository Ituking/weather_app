import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/view_model/weather_view_model.dart';

part 'weather_view_model_provider.g.dart';

// Riverpodのプロバイダーを定義
@riverpod
// WeatherViewModelプロバイダーを作成する関数
WeatherViewModel weatherViewModelProvider(WeatherViewModelProviderRef ref) {
  // WeatherViewModelのインスタンスを返す
  return WeatherViewModel();
}
