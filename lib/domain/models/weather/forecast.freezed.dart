// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Forecast _$ForecastFromJson(Map<String, dynamic> json) {
  return _Forecast.fromJson(json);
}

/// @nodoc
mixin _$Forecast {
  String get id => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  Map<String, String> get cityTranslations =>
      throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, String> get descriptionTranslations =>
      throw _privateConstructorUsedError;
  double get humidity => throw _privateConstructorUsedError;
  double get temperature => throw _privateConstructorUsedError;
  double get minTemp => throw _privateConstructorUsedError;
  double get maxTemp => throw _privateConstructorUsedError;
  double get windSpeed => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;

  /// Serializes this Forecast to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForecastCopyWith<Forecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForecastCopyWith<$Res> {
  factory $ForecastCopyWith(Forecast value, $Res Function(Forecast) then) =
      _$ForecastCopyWithImpl<$Res, Forecast>;
  @useResult
  $Res call(
      {String id,
      String city,
      Map<String, String> cityTranslations,
      String description,
      Map<String, String> descriptionTranslations,
      double humidity,
      double temperature,
      double minTemp,
      double maxTemp,
      double windSpeed,
      String icon,
      int timestamp});
}

/// @nodoc
class _$ForecastCopyWithImpl<$Res, $Val extends Forecast>
    implements $ForecastCopyWith<$Res> {
  _$ForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? city = null,
    Object? cityTranslations = null,
    Object? description = null,
    Object? descriptionTranslations = null,
    Object? humidity = null,
    Object? temperature = null,
    Object? minTemp = null,
    Object? maxTemp = null,
    Object? windSpeed = null,
    Object? icon = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      cityTranslations: null == cityTranslations
          ? _value.cityTranslations
          : cityTranslations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionTranslations: null == descriptionTranslations
          ? _value.descriptionTranslations
          : descriptionTranslations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as double,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      minTemp: null == minTemp
          ? _value.minTemp
          : minTemp // ignore: cast_nullable_to_non_nullable
              as double,
      maxTemp: null == maxTemp
          ? _value.maxTemp
          : maxTemp // ignore: cast_nullable_to_non_nullable
              as double,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForecastImplCopyWith<$Res>
    implements $ForecastCopyWith<$Res> {
  factory _$$ForecastImplCopyWith(
          _$ForecastImpl value, $Res Function(_$ForecastImpl) then) =
      __$$ForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String city,
      Map<String, String> cityTranslations,
      String description,
      Map<String, String> descriptionTranslations,
      double humidity,
      double temperature,
      double minTemp,
      double maxTemp,
      double windSpeed,
      String icon,
      int timestamp});
}

/// @nodoc
class __$$ForecastImplCopyWithImpl<$Res>
    extends _$ForecastCopyWithImpl<$Res, _$ForecastImpl>
    implements _$$ForecastImplCopyWith<$Res> {
  __$$ForecastImplCopyWithImpl(
      _$ForecastImpl _value, $Res Function(_$ForecastImpl) _then)
      : super(_value, _then);

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? city = null,
    Object? cityTranslations = null,
    Object? description = null,
    Object? descriptionTranslations = null,
    Object? humidity = null,
    Object? temperature = null,
    Object? minTemp = null,
    Object? maxTemp = null,
    Object? windSpeed = null,
    Object? icon = null,
    Object? timestamp = null,
  }) {
    return _then(_$ForecastImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      cityTranslations: null == cityTranslations
          ? _value._cityTranslations
          : cityTranslations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionTranslations: null == descriptionTranslations
          ? _value._descriptionTranslations
          : descriptionTranslations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as double,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      minTemp: null == minTemp
          ? _value.minTemp
          : minTemp // ignore: cast_nullable_to_non_nullable
              as double,
      maxTemp: null == maxTemp
          ? _value.maxTemp
          : maxTemp // ignore: cast_nullable_to_non_nullable
              as double,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForecastImpl extends _Forecast {
  const _$ForecastImpl(
      {this.id = '',
      this.city = '',
      final Map<String, String> cityTranslations = const {},
      this.description = '',
      final Map<String, String> descriptionTranslations = const {},
      this.humidity = 0.0,
      this.temperature = 0.0,
      this.minTemp = 0.0,
      this.maxTemp = 0.0,
      this.windSpeed = 0.0,
      this.icon = '',
      this.timestamp = 0})
      : _cityTranslations = cityTranslations,
        _descriptionTranslations = descriptionTranslations,
        super._();

  factory _$ForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForecastImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String city;
  final Map<String, String> _cityTranslations;
  @override
  @JsonKey()
  Map<String, String> get cityTranslations {
    if (_cityTranslations is EqualUnmodifiableMapView) return _cityTranslations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cityTranslations);
  }

  @override
  @JsonKey()
  final String description;
  final Map<String, String> _descriptionTranslations;
  @override
  @JsonKey()
  Map<String, String> get descriptionTranslations {
    if (_descriptionTranslations is EqualUnmodifiableMapView)
      return _descriptionTranslations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_descriptionTranslations);
  }

  @override
  @JsonKey()
  final double humidity;
  @override
  @JsonKey()
  final double temperature;
  @override
  @JsonKey()
  final double minTemp;
  @override
  @JsonKey()
  final double maxTemp;
  @override
  @JsonKey()
  final double windSpeed;
  @override
  @JsonKey()
  final String icon;
  @override
  @JsonKey()
  final int timestamp;

  @override
  String toString() {
    return 'Forecast(id: $id, city: $city, cityTranslations: $cityTranslations, description: $description, descriptionTranslations: $descriptionTranslations, humidity: $humidity, temperature: $temperature, minTemp: $minTemp, maxTemp: $maxTemp, windSpeed: $windSpeed, icon: $icon, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForecastImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.city, city) || other.city == city) &&
            const DeepCollectionEquality()
                .equals(other._cityTranslations, _cityTranslations) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
                other._descriptionTranslations, _descriptionTranslations) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.minTemp, minTemp) || other.minTemp == minTemp) &&
            (identical(other.maxTemp, maxTemp) || other.maxTemp == maxTemp) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      city,
      const DeepCollectionEquality().hash(_cityTranslations),
      description,
      const DeepCollectionEquality().hash(_descriptionTranslations),
      humidity,
      temperature,
      minTemp,
      maxTemp,
      windSpeed,
      icon,
      timestamp);

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForecastImplCopyWith<_$ForecastImpl> get copyWith =>
      __$$ForecastImplCopyWithImpl<_$ForecastImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForecastImplToJson(
      this,
    );
  }
}

abstract class _Forecast extends Forecast {
  const factory _Forecast(
      {final String id,
      final String city,
      final Map<String, String> cityTranslations,
      final String description,
      final Map<String, String> descriptionTranslations,
      final double humidity,
      final double temperature,
      final double minTemp,
      final double maxTemp,
      final double windSpeed,
      final String icon,
      final int timestamp}) = _$ForecastImpl;
  const _Forecast._() : super._();

  factory _Forecast.fromJson(Map<String, dynamic> json) =
      _$ForecastImpl.fromJson;

  @override
  String get id;
  @override
  String get city;
  @override
  Map<String, String> get cityTranslations;
  @override
  String get description;
  @override
  Map<String, String> get descriptionTranslations;
  @override
  double get humidity;
  @override
  double get temperature;
  @override
  double get minTemp;
  @override
  double get maxTemp;
  @override
  double get windSpeed;
  @override
  String get icon;
  @override
  int get timestamp;

  /// Create a copy of Forecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForecastImplCopyWith<_$ForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
