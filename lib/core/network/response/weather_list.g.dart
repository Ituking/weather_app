// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherListImpl _$$WeatherListImplFromJson(Map<String, dynamic> json) =>
    _$WeatherListImpl(
      main: WeatherMain.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherDescription.fromJson(e as Map<String, dynamic>))
          .toList(),
      wind: WeatherWind.fromJson(json['wind'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WeatherListImplToJson(_$WeatherListImpl instance) =>
    <String, dynamic>{
      'main': instance.main,
      'weather': instance.weather,
      'wind': instance.wind,
    };
