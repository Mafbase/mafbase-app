// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ci_scheme_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CiSchemeModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CiSchemeModelCopyWith<CiSchemeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CiSchemeModelCopyWith<$Res> {
  factory $CiSchemeModelCopyWith(
          CiSchemeModel value, $Res Function(CiSchemeModel) then) =
      _$CiSchemeModelCopyWithImpl<$Res>;
  $Res call({int id, String name});
}

/// @nodoc
class _$CiSchemeModelCopyWithImpl<$Res>
    implements $CiSchemeModelCopyWith<$Res> {
  _$CiSchemeModelCopyWithImpl(this._value, this._then);

  final CiSchemeModel _value;
  // ignore: unused_field
  final $Res Function(CiSchemeModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_CiSchemeModelCopyWith<$Res>
    implements $CiSchemeModelCopyWith<$Res> {
  factory _$$_CiSchemeModelCopyWith(
          _$_CiSchemeModel value, $Res Function(_$_CiSchemeModel) then) =
      __$$_CiSchemeModelCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name});
}

/// @nodoc
class __$$_CiSchemeModelCopyWithImpl<$Res>
    extends _$CiSchemeModelCopyWithImpl<$Res>
    implements _$$_CiSchemeModelCopyWith<$Res> {
  __$$_CiSchemeModelCopyWithImpl(
      _$_CiSchemeModel _value, $Res Function(_$_CiSchemeModel) _then)
      : super(_value, (v) => _then(v as _$_CiSchemeModel));

  @override
  _$_CiSchemeModel get _value => super._value as _$_CiSchemeModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_CiSchemeModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CiSchemeModel implements _CiSchemeModel {
  const _$_CiSchemeModel({required this.id, required this.name});

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'CiSchemeModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CiSchemeModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_CiSchemeModelCopyWith<_$_CiSchemeModel> get copyWith =>
      __$$_CiSchemeModelCopyWithImpl<_$_CiSchemeModel>(this, _$identity);
}

abstract class _CiSchemeModel implements CiSchemeModel {
  const factory _CiSchemeModel(
      {required final int id, required final String name}) = _$_CiSchemeModel;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_CiSchemeModelCopyWith<_$_CiSchemeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
