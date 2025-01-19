import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../core/logger/logger_provider.dart';
import '../core/network/response/result.dart';
import '../repositories/weather_repository.dart';
import '../repositories/weather_repository_provider.dart';
import 'weather_view_model_state.dart';

part 'weather_view_model.g.dart';

/// 天気データの状態を管理するViewModelクラス。
@riverpod
class WeatherViewModel extends _$WeatherViewModel {
  late final WeatherRepository _weatherRepository;

  /// 初期状態を設定します。
  @override
  WeatherViewModelState build() {
    _weatherRepository = ref.read(weatherRepositoryProvider);
    return WeatherViewModelState();
  }

  /// 指定された都市名の天気情報を非同期に取得し、状態を更新します。
  /// [cityName] : 天気情報を取得する都市の名前。
  Future<void> fetchWeather(String cityName) async {
    final logger = ref.read(loggerProvider);

    // ローディング状態を true に設定
    state = state.copyWith(isLoading: true);

    try {
      // リポジトリを使って天気データを取得
      final result = await _weatherRepository.getWeather(cityName);

      // 結果に応じて状態を更新
      result.when(
        success: (weatherResponse) {
          state = state.copyWith(
            weather: Result.success(weatherResponse.list),
            isLoading: false,
            errorMessage: null,
          );
        },
        failure: (error) {
          // 取得に失敗した場合、エラーメッセージとローディング状態を更新
          logger.logError(
            'Failed to fetch weather data for city: $cityName. Error: ${error.message}',
            StackTrace.current,
          );

          state = state.copyWith(
            weather: Result.failure(error),
            isLoading: false,
            errorMessage: 'Failed to fetch weather data: ${error.message}',
          );
        },
      );
    } catch (e, stackTrace) {
      // 予期しないエラーが発生した場合の処理
      logger.logError(
        'Unexpected error while fetching weather data for city: $cityName. Error: $e',
        stackTrace,
      );

      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch weather data. Please try again later.',
      );
    }
  }
}
