// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CitySearchState {
  String get cityName => throw _privateConstructorUsedError; // 検索される都市の名前。
  bool get isLoading => throw _privateConstructorUsedError; // データのロード状態。
  String? get errorMessage =>
      throw _privateConstructorUsedError; // エラーメッセージ、存在する場合は非null。
  List<WeatherList>? get weather => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CitySearchStateCopyWith<CitySearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CitySearchStateCopyWith<$Res> {
  factory $CitySearchStateCopyWith(
          CitySearchState value, $Res Function(CitySearchState) then) =
      _$CitySearchStateCopyWithImpl<$Res, CitySearchState>;
  @useResult
  $Res call(
      {String cityName,
      bool isLoading,
      String? errorMessage,
      List<WeatherList>? weather});
}

/// @nodoc
class _$CitySearchStateCopyWithImpl<$Res, $Val extends CitySearchState>
    implements $CitySearchStateCopyWith<$Res> {
  _$CitySearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityName = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? weather = freezed,
  }) {
    return _then(_value.copyWith(
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      weather: freezed == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as List<WeatherList>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CitySearchStateImplCopyWith<$Res>
    implements $CitySearchStateCopyWith<$Res> {
  factory _$$CitySearchStateImplCopyWith(_$CitySearchStateImpl value,
          $Res Function(_$CitySearchStateImpl) then) =
      __$$CitySearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String cityName,
      bool isLoading,
      String? errorMessage,
      List<WeatherList>? weather});
}

/// @nodoc
class __$$CitySearchStateImplCopyWithImpl<$Res>
    extends _$CitySearchStateCopyWithImpl<$Res, _$CitySearchStateImpl>
    implements _$$CitySearchStateImplCopyWith<$Res> {
  __$$CitySearchStateImplCopyWithImpl(
      _$CitySearchStateImpl _value, $Res Function(_$CitySearchStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityName = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? weather = freezed,
  }) {
    return _then(_$CitySearchStateImpl(
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      weather: freezed == weather
          ? _value._weather
          : weather // ignore: cast_nullable_to_non_nullable
              as List<WeatherList>?,
    ));
  }
}

/// @nodoc

class _$CitySearchStateImpl implements _CitySearchState {
  _$CitySearchStateImpl(
      {this.cityName = '',
      this.isLoading = false,
      this.errorMessage,
      final List<WeatherList>? weather})
      : _weather = weather;

  @override
  @JsonKey()
  final String cityName;
// 検索される都市の名前。
  @override
  @JsonKey()
  final bool isLoading;
// データのロード状態。
  @override
  final String? errorMessage;
// エラーメッセージ、存在する場合は非null。
  final List<WeatherList>? _weather;
// エラーメッセージ、存在する場合は非null。
  @override
  List<WeatherList>? get weather {
    final value = _weather;
    if (value == null) return null;
    if (_weather is EqualUnmodifiableListView) return _weather;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CitySearchState(cityName: $cityName, isLoading: $isLoading, errorMessage: $errorMessage, weather: $weather)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CitySearchStateImpl &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._weather, _weather));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityName, isLoading,
      errorMessage, const DeepCollectionEquality().hash(_weather));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CitySearchStateImplCopyWith<_$CitySearchStateImpl> get copyWith =>
      __$$CitySearchStateImplCopyWithImpl<_$CitySearchStateImpl>(
          this, _$identity);
}

abstract class _CitySearchState implements CitySearchState {
  factory _CitySearchState(
      {final String cityName,
      final bool isLoading,
      final String? errorMessage,
      final List<WeatherList>? weather}) = _$CitySearchStateImpl;

  @override
  String get cityName;
  @override // 検索される都市の名前。
  bool get isLoading;
  @override // データのロード状態。
  String? get errorMessage;
  @override // エラーメッセージ、存在する場合は非null。
  List<WeatherList>? get weather;
  @override
  @JsonKey(ignore: true)
  _$$CitySearchStateImplCopyWith<_$CitySearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
