import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/view_model/city_search_state.dart';
import 'package:weather_app/view_model/city_search_view_model.dart';

/// [Notifier]を使ったテスト用の[CitySearchViewModel]モック実装
class CustomMockCitySearchViewModel extends Notifier<CitySearchState> {
  @override
  CitySearchState build() => CitySearchState();

  /// stateを変更し、リスナーに通知
  void setState(CitySearchState newState) {
    state = newState;
  }
}
