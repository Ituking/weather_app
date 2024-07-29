import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/core/network/response/result.dart';
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
      // リポジトリを使って天気データを取得
      final result = await _weatherRepository.getWeather(cityName);

      // 結果が成功か失敗かによって状態を更新
      result.when(
        success: (weatherList) {
          // 取得に成功した場合、天気データとローディング状態を更新
          state = state.copyWith(
            weather: Result.success(weatherList),
            isLoading: false,
            errorMessage: null,
          );
        },
        failure: (error) {
          // 取得に失敗した場合、エラーメッセージとローディング状態を更新
          state = state.copyWith(
            weather: Result.failure(error),
            isLoading: false,
            errorMessage: 'Failed to fetch weather data: ${error.message}',
          );
        },
      );
    } catch (e) {
      // 予期しないエラーが発生した場合の処理
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch weather data. Please try again later.',
      );
    }
  }
}
