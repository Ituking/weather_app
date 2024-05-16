import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';
import 'package:weather_app/view_model/city_search_state.dart';
import 'package:weather_app/view_model/city_search_view_model.dart';

// CitySearchViewModelのProvider定義
final citySearchViewModelProvider =
    StateNotifierProvider<CitySearchViewModel, CitySearchState>((ref) {
  // ref.watchを使ってWeatherRepositoryのインスタンスを取得
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  // CitySearchViewModelにWeatherRepositoryを注入
  return CitySearchViewModel(weatherRepository);
});
