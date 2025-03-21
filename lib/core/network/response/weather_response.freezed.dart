// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) {
  return _WeatherResponse.fromJson(json);
}

/// @nodoc
mixin _$WeatherResponse {
  @WeatherMainConverter()
  WeatherMain get main => throw _privateConstructorUsedError;
  @WeatherDescriptionConverter()
  WeatherDescription get weather => throw _privateConstructorUsedError;
  @WeatherWindConverter()
  WeatherWind get wind => throw _privateConstructorUsedError;
  @CityNameConverter()
  CityName get city => throw _privateConstructorUsedError;

  /// Serializes this WeatherResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherResponseCopyWith<WeatherResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherResponseCopyWith<$Res> {
  factory $WeatherResponseCopyWith(
          WeatherResponse value, $Res Function(WeatherResponse) then) =
      _$WeatherResponseCopyWithImpl<$Res, WeatherResponse>;
  @useResult
  $Res call(
      {@WeatherMainConverter() WeatherMain main,
      @WeatherDescriptionConverter() WeatherDescription weather,
      @WeatherWindConverter() WeatherWind wind,
      @CityNameConverter() CityName city});

  $WeatherMainCopyWith<$Res> get main;
  $WeatherDescriptionCopyWith<$Res> get weather;
  $WeatherWindCopyWith<$Res> get wind;
  $CityNameCopyWith<$Res> get city;
}

/// @nodoc
class _$WeatherResponseCopyWithImpl<$Res, $Val extends WeatherResponse>
    implements $WeatherResponseCopyWith<$Res> {
  _$WeatherResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? main = null,
    Object? weather = null,
    Object? wind = null,
    Object? city = null,
  }) {
    return _then(_value.copyWith(
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as WeatherMain,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as WeatherDescription,
      wind: null == wind
          ? _value.wind
          : wind // ignore: cast_nullable_to_non_nullable
              as WeatherWind,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as CityName,
    ) as $Val);
  }

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeatherMainCopyWith<$Res> get main {
    return $WeatherMainCopyWith<$Res>(_value.main, (value) {
      return _then(_value.copyWith(main: value) as $Val);
    });
  }

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeatherDescriptionCopyWith<$Res> get weather {
    return $WeatherDescriptionCopyWith<$Res>(_value.weather, (value) {
      return _then(_value.copyWith(weather: value) as $Val);
    });
  }

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeatherWindCopyWith<$Res> get wind {
    return $WeatherWindCopyWith<$Res>(_value.wind, (value) {
      return _then(_value.copyWith(wind: value) as $Val);
    });
  }

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CityNameCopyWith<$Res> get city {
    return $CityNameCopyWith<$Res>(_value.city, (value) {
      return _then(_value.copyWith(city: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeatherResponseImplCopyWith<$Res>
    implements $WeatherResponseCopyWith<$Res> {
  factory _$$WeatherResponseImplCopyWith(_$WeatherResponseImpl value,
          $Res Function(_$WeatherResponseImpl) then) =
      __$$WeatherResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@WeatherMainConverter() WeatherMain main,
      @WeatherDescriptionConverter() WeatherDescription weather,
      @WeatherWindConverter() WeatherWind wind,
      @CityNameConverter() CityName city});

  @override
  $WeatherMainCopyWith<$Res> get main;
  @override
  $WeatherDescriptionCopyWith<$Res> get weather;
  @override
  $WeatherWindCopyWith<$Res> get wind;
  @override
  $CityNameCopyWith<$Res> get city;
}

/// @nodoc
class __$$WeatherResponseImplCopyWithImpl<$Res>
    extends _$WeatherResponseCopyWithImpl<$Res, _$WeatherResponseImpl>
    implements _$$WeatherResponseImplCopyWith<$Res> {
  __$$WeatherResponseImplCopyWithImpl(
      _$WeatherResponseImpl _value, $Res Function(_$WeatherResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? main = null,
    Object? weather = null,
    Object? wind = null,
    Object? city = null,
  }) {
    return _then(_$WeatherResponseImpl(
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as WeatherMain,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as WeatherDescription,
      wind: null == wind
          ? _value.wind
          : wind // ignore: cast_nullable_to_non_nullable
              as WeatherWind,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as CityName,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@WeatherResponseConverter()
class _$WeatherResponseImpl
    with DiagnosticableTreeMixin
    implements _WeatherResponse {
  _$WeatherResponseImpl(
      {@WeatherMainConverter() required this.main,
      @WeatherDescriptionConverter() required this.weather,
      @WeatherWindConverter() required this.wind,
      @CityNameConverter() required this.city});

  factory _$WeatherResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherResponseImplFromJson(json);

  @override
  @WeatherMainConverter()
  final WeatherMain main;
  @override
  @WeatherDescriptionConverter()
  final WeatherDescription weather;
  @override
  @WeatherWindConverter()
  final WeatherWind wind;
  @override
  @CityNameConverter()
  final CityName city;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WeatherResponse(main: $main, weather: $weather, wind: $wind, city: $city)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WeatherResponse'))
      ..add(DiagnosticsProperty('main', main))
      ..add(DiagnosticsProperty('weather', weather))
      ..add(DiagnosticsProperty('wind', wind))
      ..add(DiagnosticsProperty('city', city));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherResponseImpl &&
            (identical(other.main, main) || other.main == main) &&
            (identical(other.weather, weather) || other.weather == weather) &&
            (identical(other.wind, wind) || other.wind == wind) &&
            (identical(other.city, city) || other.city == city));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, main, weather, wind, city);

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherResponseImplCopyWith<_$WeatherResponseImpl> get copyWith =>
      __$$WeatherResponseImplCopyWithImpl<_$WeatherResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherResponseImplToJson(
      this,
    );
  }
}

abstract class _WeatherResponse implements WeatherResponse {
  factory _WeatherResponse(
      {@WeatherMainConverter() required final WeatherMain main,
      @WeatherDescriptionConverter() required final WeatherDescription weather,
      @WeatherWindConverter() required final WeatherWind wind,
      @CityNameConverter()
      required final CityName city}) = _$WeatherResponseImpl;

  factory _WeatherResponse.fromJson(Map<String, dynamic> json) =
      _$WeatherResponseImpl.fromJson;

  @override
  @WeatherMainConverter()
  WeatherMain get main;
  @override
  @WeatherDescriptionConverter()
  WeatherDescription get weather;
  @override
  @WeatherWindConverter()
  WeatherWind get wind;
  @override
  @CityNameConverter()
  CityName get city;

  /// Create a copy of WeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherResponseImplCopyWith<_$WeatherResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
