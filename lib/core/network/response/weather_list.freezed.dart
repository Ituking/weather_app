// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeatherList _$WeatherListFromJson(Map<String, dynamic> json) {
  return _WeatherList.fromJson(json);
}

/// @nodoc
mixin _$WeatherList {
  WeatherMain get main => throw _privateConstructorUsedError; // メインの天気情報を表します。
  List<WeatherDescription> get weather =>
      throw _privateConstructorUsedError; // 天気の詳細情報を表します。
  WeatherWind get wind => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherListCopyWith<WeatherList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherListCopyWith<$Res> {
  factory $WeatherListCopyWith(
          WeatherList value, $Res Function(WeatherList) then) =
      _$WeatherListCopyWithImpl<$Res, WeatherList>;
  @useResult
  $Res call(
      {WeatherMain main, List<WeatherDescription> weather, WeatherWind wind});

  $WeatherMainCopyWith<$Res> get main;
  $WeatherWindCopyWith<$Res> get wind;
}

/// @nodoc
class _$WeatherListCopyWithImpl<$Res, $Val extends WeatherList>
    implements $WeatherListCopyWith<$Res> {
  _$WeatherListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? main = null,
    Object? weather = null,
    Object? wind = null,
  }) {
    return _then(_value.copyWith(
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as WeatherMain,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as List<WeatherDescription>,
      wind: null == wind
          ? _value.wind
          : wind // ignore: cast_nullable_to_non_nullable
              as WeatherWind,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WeatherMainCopyWith<$Res> get main {
    return $WeatherMainCopyWith<$Res>(_value.main, (value) {
      return _then(_value.copyWith(main: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WeatherWindCopyWith<$Res> get wind {
    return $WeatherWindCopyWith<$Res>(_value.wind, (value) {
      return _then(_value.copyWith(wind: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeatherListImplCopyWith<$Res>
    implements $WeatherListCopyWith<$Res> {
  factory _$$WeatherListImplCopyWith(
          _$WeatherListImpl value, $Res Function(_$WeatherListImpl) then) =
      __$$WeatherListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WeatherMain main, List<WeatherDescription> weather, WeatherWind wind});

  @override
  $WeatherMainCopyWith<$Res> get main;
  @override
  $WeatherWindCopyWith<$Res> get wind;
}

/// @nodoc
class __$$WeatherListImplCopyWithImpl<$Res>
    extends _$WeatherListCopyWithImpl<$Res, _$WeatherListImpl>
    implements _$$WeatherListImplCopyWith<$Res> {
  __$$WeatherListImplCopyWithImpl(
      _$WeatherListImpl _value, $Res Function(_$WeatherListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? main = null,
    Object? weather = null,
    Object? wind = null,
  }) {
    return _then(_$WeatherListImpl(
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as WeatherMain,
      weather: null == weather
          ? _value._weather
          : weather // ignore: cast_nullable_to_non_nullable
              as List<WeatherDescription>,
      wind: null == wind
          ? _value.wind
          : wind // ignore: cast_nullable_to_non_nullable
              as WeatherWind,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherListImpl with DiagnosticableTreeMixin implements _WeatherList {
  _$WeatherListImpl(
      {required this.main,
      required final List<WeatherDescription> weather,
      required this.wind})
      : _weather = weather;

  factory _$WeatherListImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherListImplFromJson(json);

  @override
  final WeatherMain main;
// メインの天気情報を表します。
  final List<WeatherDescription> _weather;
// メインの天気情報を表します。
  @override
  List<WeatherDescription> get weather {
    if (_weather is EqualUnmodifiableListView) return _weather;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weather);
  }

// 天気の詳細情報を表します。
  @override
  final WeatherWind wind;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WeatherList(main: $main, weather: $weather, wind: $wind)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WeatherList'))
      ..add(DiagnosticsProperty('main', main))
      ..add(DiagnosticsProperty('weather', weather))
      ..add(DiagnosticsProperty('wind', wind));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherListImpl &&
            (identical(other.main, main) || other.main == main) &&
            const DeepCollectionEquality().equals(other._weather, _weather) &&
            (identical(other.wind, wind) || other.wind == wind));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, main, const DeepCollectionEquality().hash(_weather), wind);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherListImplCopyWith<_$WeatherListImpl> get copyWith =>
      __$$WeatherListImplCopyWithImpl<_$WeatherListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherListImplToJson(
      this,
    );
  }
}

abstract class _WeatherList implements WeatherList {
  factory _WeatherList(
      {required final WeatherMain main,
      required final List<WeatherDescription> weather,
      required final WeatherWind wind}) = _$WeatherListImpl;

  factory _WeatherList.fromJson(Map<String, dynamic> json) =
      _$WeatherListImpl.fromJson;

  @override
  WeatherMain get main;
  @override // メインの天気情報を表します。
  List<WeatherDescription> get weather;
  @override // 天気の詳細情報を表します。
  WeatherWind get wind;
  @override
  @JsonKey(ignore: true)
  _$$WeatherListImplCopyWith<_$WeatherListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
