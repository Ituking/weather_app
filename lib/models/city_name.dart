import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_name.freezed.dart';
part 'city_name.g.dart';

/// [CityName]クラスは、都市の名前を表します。
@freezed
class CityName with _$CityName {
  /// コンストラクタ。都市名[name]を受け取ります。
  factory CityName({
    /// 都市の名前を表します。
    required String name,
  }) = _CityName;

  /// JSONから[CityName]インスタンスを生成するファクトリメソッド。
  factory CityName.fromJson(Map<String, dynamic> json) =>
      _$CityNameFromJson(json);
}
