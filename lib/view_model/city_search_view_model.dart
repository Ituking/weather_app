import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/view_model/city_search_state.dart';

// CitySearchViewModelは、都市検索に関連するビジネスロジックを処理するクラスです。
class CitySearchViewModel extends StateNotifier<CitySearchState> {
  // 天気情報を取得するためのリポジトリ
  final WeatherRepository _weatherRepository;

  // コンストラクタ。初期状態をCitySearchState()で設定します。
  CitySearchViewModel(this._weatherRepository) : super(CitySearchState());

  // ユーザーから入力された都市名を状態に更新するメソッド。
  void updateCityName(String cityName) {
    state = state.copyWith(cityName: cityName);
  }

  // 天気情報を取得する非同期メソッド。
  Future<void> fetchWeather() async {
    // 都市名が空の場合はエラーメッセージを設定し、処理を終了します。
    if (state.cityName.isEmpty) {
      state = state.copyWith(errorMessage: '検索する都市名を入力してください。');
      return;
    }

    // 天気情報の取得を開始する前にローディング状態をtrueに設定。
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // リポジトリを使用して天気情報を取得。
      final weather = await _weatherRepository.getWeather(state.cityName);
      // 天気情報の取得に成功したら、取得したデータで状態を更新。
      state = state.copyWith(isLoading: false, weather: weather);
    } catch (e) {
      // 天気情報の取得に失敗した場合は、エラーメッセージを設定。
      state = state.copyWith(
        isLoading: false,
        errorMessage: '天気情報の取得に失敗しました。後ほど再試行してください。',
      );
    }
  }
}