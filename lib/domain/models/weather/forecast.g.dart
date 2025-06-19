// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForecastImpl _$$ForecastImplFromJson(Map<String, dynamic> json) =>
    _$ForecastImpl(
      id: json['id'] as String? ?? '',
      city: json['city'] as String? ?? '',
      cityTranslations:
          (json['cityTranslations'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              const {},
      description: json['description'] as String? ?? '',
      descriptionTranslations:
          (json['descriptionTranslations'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              const {},
      humidity: (json['humidity'] as num?)?.toDouble() ?? 0.0,
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      minTemp: (json['minTemp'] as num?)?.toDouble() ?? 0.0,
      maxTemp: (json['maxTemp'] as num?)?.toDouble() ?? 0.0,
      windSpeed: (json['windSpeed'] as num?)?.toDouble() ?? 0.0,
      icon: json['icon'] as String? ?? '',
      timestamp: (json['timestamp'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ForecastImplToJson(_$ForecastImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'cityTranslations': instance.cityTranslations,
      'description': instance.description,
      'descriptionTranslations': instance.descriptionTranslations,
      'humidity': instance.humidity,
      'temperature': instance.temperature,
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'windSpeed': instance.windSpeed,
      'icon': instance.icon,
      'timestamp': instance.timestamp,
    };
