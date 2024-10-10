// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherDescriptionImpl _$$WeatherDescriptionImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherDescriptionImpl(
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$$WeatherDescriptionImplToJson(
        _$WeatherDescriptionImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'icon': instance.icon,
    };
