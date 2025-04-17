import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/ui/weather/view_model/city_search_state.dart';

/// [Notifier]を使ったテスト用の[CitySearchViewModel]モック実装
class CustomMockCitySearchViewModel extends Notifier<CitySearchState> {
  @override
  CitySearchState build() => CitySearchState();

  /// stateを変更し、リスナーに通知
  void setState(CitySearchState newState) {
    state = newState;
  }
}
