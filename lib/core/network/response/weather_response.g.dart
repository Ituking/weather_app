// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherResponseImpl _$$WeatherResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherResponseImpl(
      list: (json['list'] as List<dynamic>)
          .map((e) =>
              const WeatherListConverter().fromJson(e as Map<String, dynamic>?))
          .toList(),
      city: CityName.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WeatherResponseImplToJson(
        _$WeatherResponseImpl instance) =>
    <String, dynamic>{
      'list': instance.list.map(const WeatherListConverter().toJson).toList(),
      'city': instance.city,
    };
