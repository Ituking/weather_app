import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/city_name.dart';
import 'weather_list.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

/// [WeatherResponse] クラスは、天気情報のレスポンス全体を表します。
@freezed
class WeatherResponse with _$WeatherResponse {
  /// コンストラクタ。
  ///
  /// [list] : 天気情報のリストを表します。
  /// [city] : 都市の情報を表します。
  factory WeatherResponse({
    required List<WeatherList> list,
    required CityName city,
  }) = _WeatherResponse;

  /// JSON から [WeatherResponse] インスタンスを生成するファクトリメソッド。
  ///
  /// [json] : [WeatherResponse] のプロパティを含むマップ。
  /// 戻り値: 新しい [WeatherResponse] インスタンス。
  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
