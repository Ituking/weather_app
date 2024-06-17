import 'package:mockito/mockito.dart';
import 'package:weather_app/view_model/city_search_state.dart';
import 'package:weather_app/view_model/city_search_view_model.dart';

// CustomMockCitySearchViewModelクラスは、CitySearchViewModelのモック実装を提供するクラスです。
// このクラスはmockitoを使用して、テスト用に特定のメソッドをオーバーライドしています。
class CustomMockCitySearchViewModel extends Mock
    implements CitySearchViewModel {
  // コンストラクタで初期状態を設定
  CustomMockCitySearchViewModel() {
    // stateゲッターがデフォルトのCitySearchStateを返すように設定
    when(state).thenReturn(CitySearchState());
  }

  // stateゲッターをオーバーライドし、デフォルトのCitySearchStateを返すように設定
  @override
  CitySearchState get state => super.noSuchMethod(Invocation.getter(#state),
      returnValue: CitySearchState()) as CitySearchState;

  // updateCityNameメソッドをオーバーライドし、モック実装を提供
  // 引数cityNameをnullableに変更
  @override
  void updateCityName(String? cityName) {
    super.noSuchMethod(Invocation.method(#updateCityName, [cityName]));
  }

  // fetchWeatherメソッドをオーバーライドし、モック実装を提供
  @override
  Future<void> fetchWeather() async {
    return super.noSuchMethod(Invocation.method(#fetchWeather, []),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future.value()) as Future<void>;
  }

// setStateメソッドをオーバーライドし、モックのstateを設定
  @override
  void setState(CitySearchState state) {
    when(this.state).thenReturn(state);
  }
}
