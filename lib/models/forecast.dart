import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast.freezed.dart';
part 'forecast.g.dart';

@freezed
class Forecast with _$Forecast {
  const factory Forecast({
    @Default('') String id,
    @Default('') String city,
    @Default('') String description,
    @Default(0.0) double humidity,
    @Default(0.0) double temperature,
    @Default(0.0) double windSpeed,
    @Default('') String icon,
  }) = _Forecast;

  const Forecast._();

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
}
