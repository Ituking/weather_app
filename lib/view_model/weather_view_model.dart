import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/view_model/weather_view_model_state.dart';

// WeatherViewModelは、天気データの状態を管理するためのクラスです。
// StateNotifierを継承しており、WeatherModelの状態を更新します。
class WeatherViewModel extends StateNotifier<WeatherViewModelState> {
  // 天気データを取得するためのリポジトリ
  final WeatherRepository _weatherRepository;

  // コンストラクタで初期状態を設定します。
  WeatherViewModel(this._weatherRepository) : super(WeatherViewModelState());

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
      // エラー時に状態をnullに設定
      state = state.copyWith(
        isLoading: true,
        errorMessage: 'Failed to fetch weather data',
      );
    }
  }
}
