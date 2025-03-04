import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/view_model/city_search_state.dart';

import '../../mocks/custom_mock_city_search_view_model.dart';

/// [CustomMockCitySearchViewModel]を提供する[NotifierProvider]
final customMockCitySearchViewModelProvider =
    NotifierProvider<CustomMockCitySearchViewModel, CitySearchState>(
        CustomMockCitySearchViewModel.new);
