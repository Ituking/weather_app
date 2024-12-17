import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/network/response/weather_response.dart';

part 'city_search_state.freezed.dart';

// CitySearchStateは、都市検索に関連する状態を保持するデータモデルです。
@freezed
class CitySearchState with _$CitySearchState {
  // ファクトリコンストラクタ。デフォルト値や省略可能なプロパティを定義します。
  factory CitySearchState({
    @Default('') String cityName, // 検索される都市の名前。
    @Default(false) bool isLoading, // データのロード状態。
    String? errorMessage, // エラーメッセージ、存在する場合は非null。
    WeatherResponse? weather, // WeatherResponseオブジェクトのリスト、天気データを保持します。
  }) = _CitySearchState;
}
