import 'package:freezed_annotation/freezed_annotation.dart';

import '../city_name.dart';

class CityNameConverter implements JsonConverter<CityName, dynamic> {
  const CityNameConverter();

  @override
  CityName fromJson(dynamic json) {
    if (json is String) {
      return CityName(name: json);
    } else if (json is Map<String, dynamic> && json['name'] is String) {
      return CityName(name: json['name']);
    } else {
      throw FormatException('Invalid CityName format: $json');
    }
  }

  @override
  dynamic toJson(CityName cityName) => cityName.name;
}
