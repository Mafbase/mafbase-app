// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginButtonTapped,
    required TResult Function() forgotPasswordTapped,
    required TResult Function() signUpButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginButtonTapped,
    TResult? Function()? forgotPasswordTapped,
    TResult? Function()? signUpButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginButtonTapped,
    TResult Function()? forgotPasswordTapped,
    TResult Function()? signUpButtonTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginButtonTapped value) loginButtonTapped,
    required TResult Function(ForgotPasswordTapped value) forgotPasswordTapped,
    required TResult Function(SignUpButtonTapped value) signUpButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginButtonTapped value)? loginButtonTapped,
    TResult? Function(ForgotPasswordTapped value)? forgotPasswordTapped,
    TResult? Function(SignUpButtonTapped value)? signUpButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginButtonTapped value)? loginButtonTapped,
    TResult Function(ForgotPasswordTapped value)? forgotPasswordTapped,
    TResult Function(SignUpButtonTapped value)? signUpButtonTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
          LoginEvent value, $Res Function(LoginEvent) then) =
      _$LoginEventCopyWithImpl<$Res, LoginEvent>;
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res, $Val extends LoginEvent>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoginButtonTappedImplCopyWith<$Res> {
  factory _$$LoginButtonTappedImplCopyWith(_$LoginButtonTappedImpl value,
          $Res Function(_$LoginButtonTappedImpl) then) =
      __$$LoginButtonTappedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginButtonTappedImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginButtonTappedImpl>
    implements _$$LoginButtonTappedImplCopyWith<$Res> {
  __$$LoginButtonTappedImplCopyWithImpl(_$LoginButtonTappedImpl _value,
      $Res Function(_$LoginButtonTappedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginButtonTappedImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginButtonTappedImpl implements LoginButtonTapped {
  const _$LoginButtonTappedImpl({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginEvent.loginButtonTapped(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginButtonTappedImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginButtonTappedImplCopyWith<_$LoginButtonTappedImpl> get copyWith =>
      __$$LoginButtonTappedImplCopyWithImpl<_$LoginButtonTappedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginButtonTapped,
    required TResult Function() forgotPasswordTapped,
    required TResult Function() signUpButtonTapped,
  }) {
    return loginButtonTapped(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginButtonTapped,
    TResult? Function()? forgotPasswordTapped,
    TResult? Function()? signUpButtonTapped,
  }) {
    return loginButtonTapped?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginButtonTapped,
    TResult Function()? forgotPasswordTapped,
    TResult Function()? signUpButtonTapped,
    required TResult orElse(),
  }) {
    if (loginButtonTapped != null) {
      return loginButtonTapped(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginButtonTapped value) loginButtonTapped,
    required TResult Function(ForgotPasswordTapped value) forgotPasswordTapped,
    required TResult Function(SignUpButtonTapped value) signUpButtonTapped,
  }) {
    return loginButtonTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginButtonTapped value)? loginButtonTapped,
    TResult? Function(ForgotPasswordTapped value)? forgotPasswordTapped,
    TResult? Function(SignUpButtonTapped value)? signUpButtonTapped,
  }) {
    return loginButtonTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginButtonTapped value)? loginButtonTapped,
    TResult Function(ForgotPasswordTapped value)? forgotPasswordTapped,
    TResult Function(SignUpButtonTapped value)? signUpButtonTapped,
    required TResult orElse(),
  }) {
    if (loginButtonTapped != null) {
      return loginButtonTapped(this);
    }
    return orElse();
  }
}

abstract class LoginButtonTapped implements LoginEvent {
  const factory LoginButtonTapped(
      {required final String email,
      required final String password}) = _$LoginButtonTappedImpl;

  String get email;
  String get password;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginButtonTappedImplCopyWith<_$LoginButtonTappedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForgotPasswordTappedImplCopyWith<$Res> {
  factory _$$ForgotPasswordTappedImplCopyWith(_$ForgotPasswordTappedImpl value,
          $Res Function(_$ForgotPasswordTappedImpl) then) =
      __$$ForgotPasswordTappedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ForgotPasswordTappedImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$ForgotPasswordTappedImpl>
    implements _$$ForgotPasswordTappedImplCopyWith<$Res> {
  __$$ForgotPasswordTappedImplCopyWithImpl(_$ForgotPasswordTappedImpl _value,
      $Res Function(_$ForgotPasswordTappedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ForgotPasswordTappedImpl implements ForgotPasswordTapped {
  const _$ForgotPasswordTappedImpl();

  @override
  String toString() {
    return 'LoginEvent.forgotPasswordTapped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordTappedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginButtonTapped,
    required TResult Function() forgotPasswordTapped,
    required TResult Function() signUpButtonTapped,
  }) {
    return forgotPasswordTapped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginButtonTapped,
    TResult? Function()? forgotPasswordTapped,
    TResult? Function()? signUpButtonTapped,
  }) {
    return forgotPasswordTapped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginButtonTapped,
    TResult Function()? forgotPasswordTapped,
    TResult Function()? signUpButtonTapped,
    required TResult orElse(),
  }) {
    if (forgotPasswordTapped != null) {
      return forgotPasswordTapped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginButtonTapped value) loginButtonTapped,
    required TResult Function(ForgotPasswordTapped value) forgotPasswordTapped,
    required TResult Function(SignUpButtonTapped value) signUpButtonTapped,
  }) {
    return forgotPasswordTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginButtonTapped value)? loginButtonTapped,
    TResult? Function(ForgotPasswordTapped value)? forgotPasswordTapped,
    TResult? Function(SignUpButtonTapped value)? signUpButtonTapped,
  }) {
    return forgotPasswordTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginButtonTapped value)? loginButtonTapped,
    TResult Function(ForgotPasswordTapped value)? forgotPasswordTapped,
    TResult Function(SignUpButtonTapped value)? signUpButtonTapped,
    required TResult orElse(),
  }) {
    if (forgotPasswordTapped != null) {
      return forgotPasswordTapped(this);
    }
    return orElse();
  }
}

abstract class ForgotPasswordTapped implements LoginEvent {
  const factory ForgotPasswordTapped() = _$ForgotPasswordTappedImpl;
}

/// @nodoc
abstract class _$$SignUpButtonTappedImplCopyWith<$Res> {
  factory _$$SignUpButtonTappedImplCopyWith(_$SignUpButtonTappedImpl value,
          $Res Function(_$SignUpButtonTappedImpl) then) =
      __$$SignUpButtonTappedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignUpButtonTappedImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$SignUpButtonTappedImpl>
    implements _$$SignUpButtonTappedImplCopyWith<$Res> {
  __$$SignUpButtonTappedImplCopyWithImpl(_$SignUpButtonTappedImpl _value,
      $Res Function(_$SignUpButtonTappedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignUpButtonTappedImpl implements SignUpButtonTapped {
  const _$SignUpButtonTappedImpl();

  @override
  String toString() {
    return 'LoginEvent.signUpButtonTapped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignUpButtonTappedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginButtonTapped,
    required TResult Function() forgotPasswordTapped,
    required TResult Function() signUpButtonTapped,
  }) {
    return signUpButtonTapped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginButtonTapped,
    TResult? Function()? forgotPasswordTapped,
    TResult? Function()? signUpButtonTapped,
  }) {
    return signUpButtonTapped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginButtonTapped,
    TResult Function()? forgotPasswordTapped,
    TResult Function()? signUpButtonTapped,
    required TResult orElse(),
  }) {
    if (signUpButtonTapped != null) {
      return signUpButtonTapped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginButtonTapped value) loginButtonTapped,
    required TResult Function(ForgotPasswordTapped value) forgotPasswordTapped,
    required TResult Function(SignUpButtonTapped value) signUpButtonTapped,
  }) {
    return signUpButtonTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginButtonTapped value)? loginButtonTapped,
    TResult? Function(ForgotPasswordTapped value)? forgotPasswordTapped,
    TResult? Function(SignUpButtonTapped value)? signUpButtonTapped,
  }) {
    return signUpButtonTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginButtonTapped value)? loginButtonTapped,
    TResult Function(ForgotPasswordTapped value)? forgotPasswordTapped,
    TResult Function(SignUpButtonTapped value)? signUpButtonTapped,
    required TResult orElse(),
  }) {
    if (signUpButtonTapped != null) {
      return signUpButtonTapped(this);
    }
    return orElse();
  }
}

abstract class SignUpButtonTapped implements LoginEvent {
  const factory SignUpButtonTapped() = _$SignUpButtonTappedImpl;
}
