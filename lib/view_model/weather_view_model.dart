import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';
import 'package:weather_app/view_model/weather_view_model_state.dart';

part 'weather_view_model.g.dart';

@riverpod
// WeatherViewModelは、天気データの状態を管理するためのクラスです。
class WeatherViewModel extends _$WeatherViewModel {
  // 天気データを取得するためのリポジトリ
  late final WeatherRepository _weatherRepository;

  // 初期状態の設定
  @override
  WeatherViewModelState build() {
    _weatherRepository = ref.read(weatherRepositoryProvider);
    return WeatherViewModelState();
  }

  // 指定された都市名で天気情報を非同期に取得し、状態を更新します。
  Future<void> fetchWeather(String cityName) async {
    // ローディング状態をtrueに設定
    state = state.copyWith(isLoading: true);

    try {
      final weather = await _weatherRepository.getWeather(cityName);
      // 成功時の天気データで状態を更新
      state = state.copyWith(
        weather: weather,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      // エラー時に状態を更新
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch weather data',
      );
    }
  }
}
