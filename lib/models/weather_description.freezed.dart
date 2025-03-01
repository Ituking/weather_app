// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_description.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeatherDescription _$WeatherDescriptionFromJson(Map<String, dynamic> json) {
  return _WeatherDescription.fromJson(json);
}

/// @nodoc
mixin _$WeatherDescription {
  /// 天気の詳細な説明を表します。
  String get description => throw _privateConstructorUsedError;

  /// 天気アイコンのIDを表します。
  String get icon => throw _privateConstructorUsedError;

  /// Serializes this WeatherDescription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeatherDescription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherDescriptionCopyWith<WeatherDescription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherDescriptionCopyWith<$Res> {
  factory $WeatherDescriptionCopyWith(
          WeatherDescription value, $Res Function(WeatherDescription) then) =
      _$WeatherDescriptionCopyWithImpl<$Res, WeatherDescription>;
  @useResult
  $Res call({String description, String icon});
}

/// @nodoc
class _$WeatherDescriptionCopyWithImpl<$Res, $Val extends WeatherDescription>
    implements $WeatherDescriptionCopyWith<$Res> {
  _$WeatherDescriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherDescription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? icon = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherDescriptionImplCopyWith<$Res>
    implements $WeatherDescriptionCopyWith<$Res> {
  factory _$$WeatherDescriptionImplCopyWith(_$WeatherDescriptionImpl value,
          $Res Function(_$WeatherDescriptionImpl) then) =
      __$$WeatherDescriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String icon});
}

/// @nodoc
class __$$WeatherDescriptionImplCopyWithImpl<$Res>
    extends _$WeatherDescriptionCopyWithImpl<$Res, _$WeatherDescriptionImpl>
    implements _$$WeatherDescriptionImplCopyWith<$Res> {
  __$$WeatherDescriptionImplCopyWithImpl(_$WeatherDescriptionImpl _value,
      $Res Function(_$WeatherDescriptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeatherDescription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? icon = null,
  }) {
    return _then(_$WeatherDescriptionImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherDescriptionImpl implements _WeatherDescription {
  _$WeatherDescriptionImpl({required this.description, required this.icon});

  factory _$WeatherDescriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherDescriptionImplFromJson(json);

  /// 天気の詳細な説明を表します。
  @override
  final String description;

  /// 天気アイコンのIDを表します。
  @override
  final String icon;

  @override
  String toString() {
    return 'WeatherDescription(description: $description, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherDescriptionImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, icon);

  /// Create a copy of WeatherDescription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherDescriptionImplCopyWith<_$WeatherDescriptionImpl> get copyWith =>
      __$$WeatherDescriptionImplCopyWithImpl<_$WeatherDescriptionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherDescriptionImplToJson(
      this,
    );
  }
}

abstract class _WeatherDescription implements WeatherDescription {
  factory _WeatherDescription(
      {required final String description,
      required final String icon}) = _$WeatherDescriptionImpl;

  factory _WeatherDescription.fromJson(Map<String, dynamic> json) =
      _$WeatherDescriptionImpl.fromJson;

  /// 天気の詳細な説明を表します。
  @override
  String get description;

  /// 天気アイコンのIDを表します。
  @override
  String get icon;

  /// Create a copy of WeatherDescription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherDescriptionImplCopyWith<_$WeatherDescriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
