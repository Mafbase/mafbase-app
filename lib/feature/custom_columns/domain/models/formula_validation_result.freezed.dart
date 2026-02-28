// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'formula_validation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FormulaValidationResult {
  bool get valid => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of FormulaValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormulaValidationResultCopyWith<FormulaValidationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormulaValidationResultCopyWith<$Res> {
  factory $FormulaValidationResultCopyWith(FormulaValidationResult value,
          $Res Function(FormulaValidationResult) then) =
      _$FormulaValidationResultCopyWithImpl<$Res, FormulaValidationResult>;
  @useResult
  $Res call({bool valid, String? error});
}

/// @nodoc
class _$FormulaValidationResultCopyWithImpl<$Res,
        $Val extends FormulaValidationResult>
    implements $FormulaValidationResultCopyWith<$Res> {
  _$FormulaValidationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormulaValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? valid = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormulaValidationResultImplCopyWith<$Res>
    implements $FormulaValidationResultCopyWith<$Res> {
  factory _$$FormulaValidationResultImplCopyWith(
          _$FormulaValidationResultImpl value,
          $Res Function(_$FormulaValidationResultImpl) then) =
      __$$FormulaValidationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool valid, String? error});
}

/// @nodoc
class __$$FormulaValidationResultImplCopyWithImpl<$Res>
    extends _$FormulaValidationResultCopyWithImpl<$Res,
        _$FormulaValidationResultImpl>
    implements _$$FormulaValidationResultImplCopyWith<$Res> {
  __$$FormulaValidationResultImplCopyWithImpl(
      _$FormulaValidationResultImpl _value,
      $Res Function(_$FormulaValidationResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormulaValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? valid = null,
    Object? error = freezed,
  }) {
    return _then(_$FormulaValidationResultImpl(
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FormulaValidationResultImpl implements _FormulaValidationResult {
  const _$FormulaValidationResultImpl({required this.valid, this.error});

  @override
  final bool valid;
  @override
  final String? error;

  @override
  String toString() {
    return 'FormulaValidationResult(valid: $valid, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormulaValidationResultImpl &&
            (identical(other.valid, valid) || other.valid == valid) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, valid, error);

  /// Create a copy of FormulaValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormulaValidationResultImplCopyWith<_$FormulaValidationResultImpl>
      get copyWith => __$$FormulaValidationResultImplCopyWithImpl<
          _$FormulaValidationResultImpl>(this, _$identity);
}

abstract class _FormulaValidationResult implements FormulaValidationResult {
  const factory _FormulaValidationResult(
      {required final bool valid,
      final String? error}) = _$FormulaValidationResultImpl;

  @override
  bool get valid;
  @override
  String? get error;

  /// Create a copy of FormulaValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormulaValidationResultImplCopyWith<_$FormulaValidationResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}
