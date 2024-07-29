import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';

part 'weather_view_model_state.freezed.dart';

@freezed
// WeatherViewModelState クラスは、天気データの状態を管理するためのデータクラスです。
class WeatherViewModelState with _$WeatherViewModelState {
  // コンストラクタ。必要に応じて初期値を設定します。
  factory WeatherViewModelState({
    // weather は、天気データの取得結果を格納します。
    Result<List<WeatherList>>? weather,
    // isLoading は、データ取得中のローディング状態を示します。デフォルトは false です。
    @Default(false) bool isLoading,
    // errorMessage は、エラーメッセージを格納します。エラーがない場合は null です。
    String? errorMessage,
  }) = _WeatherViewModelState;
}
