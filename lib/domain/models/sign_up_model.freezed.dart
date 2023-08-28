// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignUpModel {
  ErrorEnum? get error => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignUpModelCopyWith<SignUpModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpModelCopyWith<$Res> {
  factory $SignUpModelCopyWith(
          SignUpModel value, $Res Function(SignUpModel) then) =
      _$SignUpModelCopyWithImpl<$Res, SignUpModel>;
  @useResult
  $Res call({ErrorEnum? error, int? id});
}

/// @nodoc
class _$SignUpModelCopyWithImpl<$Res, $Val extends SignUpModel>
    implements $SignUpModelCopyWith<$Res> {
  _$SignUpModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorEnum?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignUpModelCopyWith<$Res>
    implements $SignUpModelCopyWith<$Res> {
  factory _$$_SignUpModelCopyWith(
          _$_SignUpModel value, $Res Function(_$_SignUpModel) then) =
      __$$_SignUpModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ErrorEnum? error, int? id});
}

/// @nodoc
class __$$_SignUpModelCopyWithImpl<$Res>
    extends _$SignUpModelCopyWithImpl<$Res, _$_SignUpModel>
    implements _$$_SignUpModelCopyWith<$Res> {
  __$$_SignUpModelCopyWithImpl(
      _$_SignUpModel _value, $Res Function(_$_SignUpModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_SignUpModel(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorEnum?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_SignUpModel implements _SignUpModel {
  const _$_SignUpModel({this.error, this.id});

  @override
  final ErrorEnum? error;
  @override
  final int? id;

  @override
  String toString() {
    return 'SignUpModel(error: $error, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignUpModel &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignUpModelCopyWith<_$_SignUpModel> get copyWith =>
      __$$_SignUpModelCopyWithImpl<_$_SignUpModel>(this, _$identity);
}

abstract class _SignUpModel implements SignUpModel {
  const factory _SignUpModel({final ErrorEnum? error, final int? id}) =
      _$_SignUpModel;

  @override
  ErrorEnum? get error;
  @override
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$_SignUpModelCopyWith<_$_SignUpModel> get copyWith =>
      throw _privateConstructorUsedError;
}
