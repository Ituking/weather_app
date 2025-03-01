// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_view_model_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WeatherViewModelState {
  Result<List<WeatherList>>? get weather =>
      throw _privateConstructorUsedError; // 天気データの取得結果
  bool get isLoading => throw _privateConstructorUsedError; // データのロード状態。
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of WeatherViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherViewModelStateCopyWith<WeatherViewModelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherViewModelStateCopyWith<$Res> {
  factory $WeatherViewModelStateCopyWith(WeatherViewModelState value,
          $Res Function(WeatherViewModelState) then) =
      _$WeatherViewModelStateCopyWithImpl<$Res, WeatherViewModelState>;
  @useResult
  $Res call(
      {Result<List<WeatherList>>? weather,
      bool isLoading,
      String? errorMessage});

  $ResultCopyWith<List<WeatherList>, $Res>? get weather;
}

/// @nodoc
class _$WeatherViewModelStateCopyWithImpl<$Res,
        $Val extends WeatherViewModelState>
    implements $WeatherViewModelStateCopyWith<$Res> {
  _$WeatherViewModelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weather = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      weather: freezed == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as Result<List<WeatherList>>?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of WeatherViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<List<WeatherList>, $Res>? get weather {
    if (_value.weather == null) {
      return null;
    }

    return $ResultCopyWith<List<WeatherList>, $Res>(_value.weather!, (value) {
      return _then(_value.copyWith(weather: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeatherViewModelStateImplCopyWith<$Res>
    implements $WeatherViewModelStateCopyWith<$Res> {
  factory _$$WeatherViewModelStateImplCopyWith(
          _$WeatherViewModelStateImpl value,
          $Res Function(_$WeatherViewModelStateImpl) then) =
      __$$WeatherViewModelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Result<List<WeatherList>>? weather,
      bool isLoading,
      String? errorMessage});

  @override
  $ResultCopyWith<List<WeatherList>, $Res>? get weather;
}

/// @nodoc
class __$$WeatherViewModelStateImplCopyWithImpl<$Res>
    extends _$WeatherViewModelStateCopyWithImpl<$Res,
        _$WeatherViewModelStateImpl>
    implements _$$WeatherViewModelStateImplCopyWith<$Res> {
  __$$WeatherViewModelStateImplCopyWithImpl(_$WeatherViewModelStateImpl _value,
      $Res Function(_$WeatherViewModelStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeatherViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weather = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$WeatherViewModelStateImpl(
      weather: freezed == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as Result<List<WeatherList>>?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WeatherViewModelStateImpl implements _WeatherViewModelState {
  _$WeatherViewModelStateImpl(
      {this.weather, this.isLoading = false, this.errorMessage});

  @override
  final Result<List<WeatherList>>? weather;
// 天気データの取得結果
  @override
  @JsonKey()
  final bool isLoading;
// データのロード状態。
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'WeatherViewModelState(weather: $weather, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherViewModelStateImpl &&
            (identical(other.weather, weather) || other.weather == weather) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, weather, isLoading, errorMessage);

  /// Create a copy of WeatherViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherViewModelStateImplCopyWith<_$WeatherViewModelStateImpl>
      get copyWith => __$$WeatherViewModelStateImplCopyWithImpl<
          _$WeatherViewModelStateImpl>(this, _$identity);
}

abstract class _WeatherViewModelState implements WeatherViewModelState {
  factory _WeatherViewModelState(
      {final Result<List<WeatherList>>? weather,
      final bool isLoading,
      final String? errorMessage}) = _$WeatherViewModelStateImpl;

  @override
  Result<List<WeatherList>>? get weather; // 天気データの取得結果
  @override
  bool get isLoading; // データのロード状態。
  @override
  String? get errorMessage;

  /// Create a copy of WeatherViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherViewModelStateImplCopyWith<_$WeatherViewModelStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
