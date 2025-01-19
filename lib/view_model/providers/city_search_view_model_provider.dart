import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../city_search_state.dart';
import '../city_search_view_model.dart';

/// [CitySearchViewModel]を提供する[NotifierProvider]。
final citySearchViewModelProvider =
    NotifierProvider<CitySearchViewModel, CitySearchState>(
  CitySearchViewModel.new,
);
