// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ci_scheme_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CiSchemeModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Create a copy of CiSchemeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CiSchemeModelCopyWith<CiSchemeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CiSchemeModelCopyWith<$Res> {
  factory $CiSchemeModelCopyWith(
          CiSchemeModel value, $Res Function(CiSchemeModel) then) =
      _$CiSchemeModelCopyWithImpl<$Res, CiSchemeModel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$CiSchemeModelCopyWithImpl<$Res, $Val extends CiSchemeModel>
    implements $CiSchemeModelCopyWith<$Res> {
  _$CiSchemeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CiSchemeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CiSchemeModelImplCopyWith<$Res>
    implements $CiSchemeModelCopyWith<$Res> {
  factory _$$CiSchemeModelImplCopyWith(
          _$CiSchemeModelImpl value, $Res Function(_$CiSchemeModelImpl) then) =
      __$$CiSchemeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$CiSchemeModelImplCopyWithImpl<$Res>
    extends _$CiSchemeModelCopyWithImpl<$Res, _$CiSchemeModelImpl>
    implements _$$CiSchemeModelImplCopyWith<$Res> {
  __$$CiSchemeModelImplCopyWithImpl(
      _$CiSchemeModelImpl _value, $Res Function(_$CiSchemeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CiSchemeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$CiSchemeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CiSchemeModelImpl implements _CiSchemeModel {
  const _$CiSchemeModelImpl({required this.id, required this.name});

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'CiSchemeModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CiSchemeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of CiSchemeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CiSchemeModelImplCopyWith<_$CiSchemeModelImpl> get copyWith =>
      __$$CiSchemeModelImplCopyWithImpl<_$CiSchemeModelImpl>(this, _$identity);
}

abstract class _CiSchemeModel implements CiSchemeModel {
  const factory _CiSchemeModel(
      {required final int id,
      required final String name}) = _$CiSchemeModelImpl;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of CiSchemeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CiSchemeModelImplCopyWith<_$CiSchemeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
