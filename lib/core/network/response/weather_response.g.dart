// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherResponseImpl _$$WeatherResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherResponseImpl(
      list: const WeatherListConverter().fromJson(json['list'] as List?),
      city: const CityNameConverter().fromJson(json['city']),
    );

Map<String, dynamic> _$$WeatherResponseImplToJson(
        _$WeatherResponseImpl instance) =>
    <String, dynamic>{
      'list': const WeatherListConverter().toJson(instance.list),
      'city': const CityNameConverter().toJson(instance.city),
    };
