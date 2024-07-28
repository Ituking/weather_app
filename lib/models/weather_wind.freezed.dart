// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_wind.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeatherWind _$WeatherWindFromJson(Map<String, dynamic> json) {
  return _WeatherWind.fromJson(json);
}

/// @nodoc
mixin _$WeatherWind {
  double get speed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherWindCopyWith<WeatherWind> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherWindCopyWith<$Res> {
  factory $WeatherWindCopyWith(
          WeatherWind value, $Res Function(WeatherWind) then) =
      _$WeatherWindCopyWithImpl<$Res, WeatherWind>;
  @useResult
  $Res call({double speed});
}

/// @nodoc
class _$WeatherWindCopyWithImpl<$Res, $Val extends WeatherWind>
    implements $WeatherWindCopyWith<$Res> {
  _$WeatherWindCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
  }) {
    return _then(_value.copyWith(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherWindImplCopyWith<$Res>
    implements $WeatherWindCopyWith<$Res> {
  factory _$$WeatherWindImplCopyWith(
          _$WeatherWindImpl value, $Res Function(_$WeatherWindImpl) then) =
      __$$WeatherWindImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double speed});
}

/// @nodoc
class __$$WeatherWindImplCopyWithImpl<$Res>
    extends _$WeatherWindCopyWithImpl<$Res, _$WeatherWindImpl>
    implements _$$WeatherWindImplCopyWith<$Res> {
  __$$WeatherWindImplCopyWithImpl(
      _$WeatherWindImpl _value, $Res Function(_$WeatherWindImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
  }) {
    return _then(_$WeatherWindImpl(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherWindImpl implements _WeatherWind {
  _$WeatherWindImpl({required this.speed});

  factory _$WeatherWindImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherWindImplFromJson(json);

  @override
  final double speed;

  @override
  String toString() {
    return 'WeatherWind(speed: $speed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherWindImpl &&
            (identical(other.speed, speed) || other.speed == speed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, speed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherWindImplCopyWith<_$WeatherWindImpl> get copyWith =>
      __$$WeatherWindImplCopyWithImpl<_$WeatherWindImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherWindImplToJson(
      this,
    );
  }
}

abstract class _WeatherWind implements WeatherWind {
  factory _WeatherWind({required final double speed}) = _$WeatherWindImpl;

  factory _WeatherWind.fromJson(Map<String, dynamic> json) =
      _$WeatherWindImpl.fromJson;

  @override
  double get speed;
  @override
  @JsonKey(ignore: true)
  _$$WeatherWindImplCopyWith<_$WeatherWindImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
