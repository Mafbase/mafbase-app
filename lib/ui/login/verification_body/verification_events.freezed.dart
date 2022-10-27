// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'verification_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VerificationEvents {
  String get token => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String token)? submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? submit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerificationEventSubmit value) submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(VerificationEventSubmit value)? submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerificationEventSubmit value)? submit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VerificationEventsCopyWith<VerificationEvents> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationEventsCopyWith<$Res> {
  factory $VerificationEventsCopyWith(
          VerificationEvents value, $Res Function(VerificationEvents) then) =
      _$VerificationEventsCopyWithImpl<$Res>;
  $Res call({String token});
}

/// @nodoc
class _$VerificationEventsCopyWithImpl<$Res>
    implements $VerificationEventsCopyWith<$Res> {
  _$VerificationEventsCopyWithImpl(this._value, this._then);

  final VerificationEvents _value;
  // ignore: unused_field
  final $Res Function(VerificationEvents) _then;

  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$VerificationEventSubmitCopyWith<$Res>
    implements $VerificationEventsCopyWith<$Res> {
  factory _$$VerificationEventSubmitCopyWith(_$VerificationEventSubmit value,
          $Res Function(_$VerificationEventSubmit) then) =
      __$$VerificationEventSubmitCopyWithImpl<$Res>;
  @override
  $Res call({String token});
}

/// @nodoc
class __$$VerificationEventSubmitCopyWithImpl<$Res>
    extends _$VerificationEventsCopyWithImpl<$Res>
    implements _$$VerificationEventSubmitCopyWith<$Res> {
  __$$VerificationEventSubmitCopyWithImpl(_$VerificationEventSubmit _value,
      $Res Function(_$VerificationEventSubmit) _then)
      : super(_value, (v) => _then(v as _$VerificationEventSubmit));

  @override
  _$VerificationEventSubmit get _value =>
      super._value as _$VerificationEventSubmit;

  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_$VerificationEventSubmit(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerificationEventSubmit implements VerificationEventSubmit {
  const _$VerificationEventSubmit({required this.token});

  @override
  final String token;

  @override
  String toString() {
    return 'VerificationEvents.submit(token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationEventSubmit &&
            const DeepCollectionEquality().equals(other.token, token));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(token));

  @JsonKey(ignore: true)
  @override
  _$$VerificationEventSubmitCopyWith<_$VerificationEventSubmit> get copyWith =>
      __$$VerificationEventSubmitCopyWithImpl<_$VerificationEventSubmit>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) submit,
  }) {
    return submit(token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String token)? submit,
  }) {
    return submit?.call(token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? submit,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerificationEventSubmit value) submit,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(VerificationEventSubmit value)? submit,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerificationEventSubmit value)? submit,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(this);
    }
    return orElse();
  }
}

abstract class VerificationEventSubmit implements VerificationEvents {
  const factory VerificationEventSubmit({required final String token}) =
      _$VerificationEventSubmit;

  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$VerificationEventSubmitCopyWith<_$VerificationEventSubmit> get copyWith =>
      throw _privateConstructorUsedError;
}
