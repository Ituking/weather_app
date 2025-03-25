// import 'package:flutter/foundation.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../weather_response.dart';

// class WeatherResponseConverter
//     implements JsonConverter<WeatherResponse, Map<String, dynamic>?> {
//   const WeatherResponseConverter();

//   @override
//   WeatherResponse fromJson(Map<String, dynamic>? json) {
//     if (json == null) {
//       debugPrint('WeatherResponseConverter: Received null data.');
//       throw Exception('WeatherResponse data is null');
//     }

//     // 必須フィールドの存在確認
//     if (json['main'] == null ||
//         json['weather'] == null ||
//         json['wind'] == null ||
//         json['city'] == null) {
//       debugPrint('WeatherResponseConverter: 必須フィールドが欠落しています。');
//       throw Exception('Invalid WeatherResponse format');
//     }

//     return WeatherResponse.fromJson(json);
//   }

//   @override
//   Map<String, dynamic>? toJson(WeatherResponse data) => data.toJson();
// }
