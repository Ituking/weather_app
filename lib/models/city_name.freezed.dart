// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_name.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CityName _$CityNameFromJson(Map<String, dynamic> json) {
  return _CityName.fromJson(json);
}

/// @nodoc
mixin _$CityName {
  String get name => throw _privateConstructorUsedError;

  /// Serializes this CityName to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CityName
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CityNameCopyWith<CityName> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityNameCopyWith<$Res> {
  factory $CityNameCopyWith(CityName value, $Res Function(CityName) then) =
      _$CityNameCopyWithImpl<$Res, CityName>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$CityNameCopyWithImpl<$Res, $Val extends CityName>
    implements $CityNameCopyWith<$Res> {
  _$CityNameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CityName
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CityNameImplCopyWith<$Res>
    implements $CityNameCopyWith<$Res> {
  factory _$$CityNameImplCopyWith(
          _$CityNameImpl value, $Res Function(_$CityNameImpl) then) =
      __$$CityNameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$CityNameImplCopyWithImpl<$Res>
    extends _$CityNameCopyWithImpl<$Res, _$CityNameImpl>
    implements _$$CityNameImplCopyWith<$Res> {
  __$$CityNameImplCopyWithImpl(
      _$CityNameImpl _value, $Res Function(_$CityNameImpl) _then)
      : super(_value, _then);

  /// Create a copy of CityName
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$CityNameImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CityNameImpl with DiagnosticableTreeMixin implements _CityName {
  _$CityNameImpl({required this.name});

  factory _$CityNameImpl.fromJson(Map<String, dynamic> json) =>
      _$$CityNameImplFromJson(json);

  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CityName(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CityName'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityNameImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of CityName
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityNameImplCopyWith<_$CityNameImpl> get copyWith =>
      __$$CityNameImplCopyWithImpl<_$CityNameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CityNameImplToJson(
      this,
    );
  }
}

abstract class _CityName implements CityName {
  factory _CityName({required final String name}) = _$CityNameImpl;

  factory _CityName.fromJson(Map<String, dynamic> json) =
      _$CityNameImpl.fromJson;

  @override
  String get name;

  /// Create a copy of CityName
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityNameImplCopyWith<_$CityNameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
