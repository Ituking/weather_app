// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherResponseImpl _$$WeatherResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherResponseImpl(
      main: const WeatherMainConverter()
          .fromJson(json['main'] as Map<String, dynamic>?),
      weather: const WeatherDescriptionConverter()
          .fromJson(json['weather'] as Map<String, dynamic>?),
      wind: const WeatherWindConverter()
          .fromJson(json['wind'] as Map<String, dynamic>),
      city: const CityNameConverter().fromJson(json['city']),
    );

Map<String, dynamic> _$$WeatherResponseImplToJson(
        _$WeatherResponseImpl instance) =>
    <String, dynamic>{
      'main': const WeatherMainConverter().toJson(instance.main),
      'weather': const WeatherDescriptionConverter().toJson(instance.weather),
      'wind': const WeatherWindConverter().toJson(instance.wind),
      'city': const CityNameConverter().toJson(instance.city),
    };
