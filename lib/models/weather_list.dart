import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/converters/weather_description_converter.dart';
import '../../../models/converters/weather_main_converter.dart';
import '../../../models/converters/weather_wind_converter.dart';
import '../../../models/weather_description.dart';
import '../../../models/weather_main.dart';
import '../../../models/weather_wind.dart';

part 'weather_list.freezed.dart';
part 'weather_list.g.dart';

/// [WeatherList] クラスは、天気情報のリスト項目を表します。
@freezed
class WeatherList with _$WeatherList {
  /// コンストラクタ。
  ///
  /// [main] : メインの天気情報を表します。
  /// [weather] : 天気の詳細情報のリストを表します。
  /// [wind] : 風の情報を表します。
  factory WeatherList({
    @WeatherMainConverter() required WeatherMain main,
    @WeatherDescriptionConverter() required List<WeatherDescription> weather,
    @WeatherWindConverter() required WeatherWind wind,
  }) = _WeatherList;

  /// JSON から [WeatherList] インスタンスを生成するファクトリメソッド。
  ///
  /// [json] : [WeatherList] のプロパティを含むマップ。
  /// 戻り値 : [WeatherList] の新しいインスタンス。
  factory WeatherList.fromJson(Map<String, dynamic> json) =>
      _$WeatherListFromJson(json);
}
