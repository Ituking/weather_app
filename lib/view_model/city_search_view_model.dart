import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/weather_repository.dart';
import '../repositories/weather_repository_provider.dart';
import 'city_search_state.dart';
import 'providers/app_router_provider.dart';

/// 都市検索に関連するビジネスロジックを処理するViewModelクラス。
/// このクラスは、都市名の更新、天気情報の取得、画面遷移などの機能を提供します。
class CitySearchViewModel extends Notifier<CitySearchState> {
  /// 天気情報を取得するためのリポジトリ。
  late final WeatherRepository _weatherRepository;

  CitySearchViewModel();

  @override
  CitySearchState build() {
    _weatherRepository = ref.read(weatherRepositoryProvider);
    return CitySearchState();
  }

  /// ユーザーから入力された都市名を状態に更新します。
  /// [cityName] : 更新する都市名。
  void updateCityName(String cityName) {
    state = state.copyWith(cityName: cityName);
  }

  /// 天気情報を非同期で取得します。
  /// 都市名が空の場合はエラーメッセージを設定し、処理を終了します。
  /// 天気情報の取得に成功した場合は状態を更新し、失敗した場合はエラーメッセージを設定します。
  Future<void> fetchWeather() async {
    if (state.cityName.isEmpty) {
      state = state.copyWith(errorMessage: '検索する都市名を入力してください。');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final weatherResult = await _weatherRepository.getWeather(state.cityName);
      weatherResult.when(success: (weather) {
        state = state.copyWith(isLoading: false, weather: weather);
      }, failure: (error) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '天気情報の取得に失敗しました。後ほど再試行してください。',
        );
      });
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '天気情報の取得に失敗しました。後ほど再試行してください。',
      );
    }
  }

  /// 結果画面への画面遷移を管理します。
  /// [cityName] - 遷移先で表示する都市名。
  void navigateToResultScreen(String cityName) {
    final router = ref.read(appRouterProvider);
    router.go('/result?city=$cityName');
  }

  /// 任意の状態を設定します。
  /// [newState] - 設定する新しい状態。
  void setState(CitySearchState newState) {
    state = newState;
  }
}
