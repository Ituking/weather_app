// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherListImpl _$$WeatherListImplFromJson(Map<String, dynamic> json) =>
    _$WeatherListImpl(
      main: const WeatherMainConverter()
          .fromJson(json['main'] as Map<String, dynamic>?),
      weather: const WeatherDescriptionConverter()
          .fromJson(json['weather'] as Map<String, dynamic>?),
      wind: const WeatherWindConverter()
          .fromJson(json['wind'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WeatherListImplToJson(_$WeatherListImpl instance) =>
    <String, dynamic>{
      'main': const WeatherMainConverter().toJson(instance.main),
      'weather': const WeatherDescriptionConverter().toJson(instance.weather),
      'wind': const WeatherWindConverter().toJson(instance.wind),
    };
