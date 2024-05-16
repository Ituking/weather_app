import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/view_model/city_search_state.dart';

void main() {
  // CitySearchStateのユニットテスト
  group('CitySearchState Tests', () {
    // 初期状態のプロパティが正しく設定されているかテスト
    test('Initial values are set correctly', () {
      // CitySearchStateのインスタンスを生成
      final state = CitySearchState();

      // isLoadingが初期値としてfalseに設定されているか
      expect(state.isLoading, false);
      // errorMessageが初期値としてnullに設定されているか
      expect(state.errorMessage, isNull);
      // cityNameが初期値として空文字列に設定されているか
      expect(state.cityName, '');
    });

    // copyWithメソッドを使用したプロパティの更新が正しく行われるかテスト
    test('copyWith correctly updates properties', () {
      // 初期状態のCitySearchStateを生成
      var state = CitySearchState();
      // copyWithで特定のプロパティを更新
      state = state.copyWith(
          isLoading: true, cityName: 'Tokyo', errorMessage: 'Error');

      // isLoadingがtrueに更新されているか
      expect(state.isLoading, isTrue);
      // cityNameが'Tokyo'に更新されているか
      expect(state.cityName, 'Tokyo');
      // errorMessageが'Error'に更新されているか
      expect(state.errorMessage, 'Error');
    });
  });
}
