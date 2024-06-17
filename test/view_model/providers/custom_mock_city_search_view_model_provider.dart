import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/view_model/city_search_view_model.dart';
import '../../mocks/custom_mock_city_search_view_model.dart';

// customMockCitySearchViewModelProviderプロバイダーを定義します。
// このプロバイダーは、CitySearchViewModelのモックバージョンであるCustomMockCitySearchViewModelを提供します。
final customMockCitySearchViewModelProvider =
    Provider<CitySearchViewModel>((ref) {
  // CustomMockCitySearchViewModelインスタンスを返します。
  return CustomMockCitySearchViewModel();
});
