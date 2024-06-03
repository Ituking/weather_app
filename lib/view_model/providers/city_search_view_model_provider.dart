import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/view_model/city_search_state.dart';
import 'package:weather_app/view_model/city_search_view_model.dart';

// プロバイダー定義
final citySearchViewModelProvider =
    NotifierProvider<CitySearchViewModel, CitySearchState>(
  CitySearchViewModel.new,
);
