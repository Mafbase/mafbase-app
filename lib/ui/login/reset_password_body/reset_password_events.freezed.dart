// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResetPasswordEvents {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token, String email, String newPassword)
        submit,
    required TResult Function() backButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token, String email, String newPassword)? submit,
    TResult? Function()? backButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token, String email, String newPassword)? submit,
    TResult Function()? backButtonTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Submit value) submit,
    required TResult Function(BackButtonTapped value) backButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Submit value)? submit,
    TResult? Function(BackButtonTapped value)? backButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Submit value)? submit,
    TResult Function(BackButtonTapped value)? backButtonTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordEventsCopyWith<$Res> {
  factory $ResetPasswordEventsCopyWith(
          ResetPasswordEvents value, $Res Function(ResetPasswordEvents) then) =
      _$ResetPasswordEventsCopyWithImpl<$Res, ResetPasswordEvents>;
}

/// @nodoc
class _$ResetPasswordEventsCopyWithImpl<$Res, $Val extends ResetPasswordEvents>
    implements $ResetPasswordEventsCopyWith<$Res> {
  _$ResetPasswordEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPasswordEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SubmitImplCopyWith<$Res> {
  factory _$$SubmitImplCopyWith(
          _$SubmitImpl value, $Res Function(_$SubmitImpl) then) =
      __$$SubmitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String token, String email, String newPassword});
}

/// @nodoc
class __$$SubmitImplCopyWithImpl<$Res>
    extends _$ResetPasswordEventsCopyWithImpl<$Res, _$SubmitImpl>
    implements _$$SubmitImplCopyWith<$Res> {
  __$$SubmitImplCopyWithImpl(
      _$SubmitImpl _value, $Res Function(_$SubmitImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResetPasswordEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? email = null,
    Object? newPassword = null,
  }) {
    return _then(_$SubmitImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SubmitImpl implements Submit {
  const _$SubmitImpl(
      {required this.token, required this.email, required this.newPassword});

  @override
  final String token;
  @override
  final String email;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ResetPasswordEvents.submit(token: $token, email: $email, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token, email, newPassword);

  /// Create a copy of ResetPasswordEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitImplCopyWith<_$SubmitImpl> get copyWith =>
      __$$SubmitImplCopyWithImpl<_$SubmitImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token, String email, String newPassword)
        submit,
    required TResult Function() backButtonTapped,
  }) {
    return submit(token, email, newPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token, String email, String newPassword)? submit,
    TResult? Function()? backButtonTapped,
  }) {
    return submit?.call(token, email, newPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token, String email, String newPassword)? submit,
    TResult Function()? backButtonTapped,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(token, email, newPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Submit value) submit,
    required TResult Function(BackButtonTapped value) backButtonTapped,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Submit value)? submit,
    TResult? Function(BackButtonTapped value)? backButtonTapped,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Submit value)? submit,
    TResult Function(BackButtonTapped value)? backButtonTapped,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(this);
    }
    return orElse();
  }
}

abstract class Submit implements ResetPasswordEvents {
  const factory Submit(
      {required final String token,
      required final String email,
      required final String newPassword}) = _$SubmitImpl;

  String get token;
  String get email;
  String get newPassword;

  /// Create a copy of ResetPasswordEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitImplCopyWith<_$SubmitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BackButtonTappedImplCopyWith<$Res> {
  factory _$$BackButtonTappedImplCopyWith(_$BackButtonTappedImpl value,
          $Res Function(_$BackButtonTappedImpl) then) =
      __$$BackButtonTappedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackButtonTappedImplCopyWithImpl<$Res>
    extends _$ResetPasswordEventsCopyWithImpl<$Res, _$BackButtonTappedImpl>
    implements _$$BackButtonTappedImplCopyWith<$Res> {
  __$$BackButtonTappedImplCopyWithImpl(_$BackButtonTappedImpl _value,
      $Res Function(_$BackButtonTappedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResetPasswordEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BackButtonTappedImpl implements BackButtonTapped {
  const _$BackButtonTappedImpl();

  @override
  String toString() {
    return 'ResetPasswordEvents.backButtonTapped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BackButtonTappedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token, String email, String newPassword)
        submit,
    required TResult Function() backButtonTapped,
  }) {
    return backButtonTapped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token, String email, String newPassword)? submit,
    TResult? Function()? backButtonTapped,
  }) {
    return backButtonTapped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token, String email, String newPassword)? submit,
    TResult Function()? backButtonTapped,
    required TResult orElse(),
  }) {
    if (backButtonTapped != null) {
      return backButtonTapped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Submit value) submit,
    required TResult Function(BackButtonTapped value) backButtonTapped,
  }) {
    return backButtonTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Submit value)? submit,
    TResult? Function(BackButtonTapped value)? backButtonTapped,
  }) {
    return backButtonTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Submit value)? submit,
    TResult Function(BackButtonTapped value)? backButtonTapped,
    required TResult orElse(),
  }) {
    if (backButtonTapped != null) {
      return backButtonTapped(this);
    }
    return orElse();
  }
}

abstract class BackButtonTapped implements ResetPasswordEvents {
  const factory BackButtonTapped() = _$BackButtonTappedImpl;
}
