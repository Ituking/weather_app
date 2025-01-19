import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/network/response/result.dart';
import '../core/network/response/weather_list.dart';

part 'weather_view_model_state.freezed.dart';

/// [WeatherViewModelState]クラスは、天気データの状態を管理するためのデータクラスです。
@freezed
class WeatherViewModelState with _$WeatherViewModelState {
  factory WeatherViewModelState({
    Result<List<WeatherList>>? weather, // 天気データの取得結果
    @Default(false) bool isLoading, // データのロード状態。
    String? errorMessage, // エラーメッセージ、存在する場合は非null。
  }) = _WeatherViewModelState;
}
