// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherModelImpl _$$WeatherModelImplFromJson(Map<String, dynamic> json) =>
    _$WeatherModelImpl(
      temperature: (json['temperature'] as num).toDouble(),
      description: json['description'] as String,
      windSpeed: (json['windSpeed'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      cityName: json['cityName'] as String,
    );

Map<String, dynamic> _$$WeatherModelImplToJson(_$WeatherModelImpl instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'description': instance.description,
      'windSpeed': instance.windSpeed,
      'humidity': instance.humidity,
      'cityName': instance.cityName,
    };
