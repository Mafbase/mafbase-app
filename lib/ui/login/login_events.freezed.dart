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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
}

/// @nodoc
abstract class _$$LoginButtonTappedCopyWith<$Res> {
  factory _$$LoginButtonTappedCopyWith(
          _$LoginButtonTapped value, $Res Function(_$LoginButtonTapped) then) =
      __$$LoginButtonTappedCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginButtonTappedCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginButtonTapped>
    implements _$$LoginButtonTappedCopyWith<$Res> {
  __$$LoginButtonTappedCopyWithImpl(
      _$LoginButtonTapped _value, $Res Function(_$LoginButtonTapped) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginButtonTapped(
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

class _$LoginButtonTapped implements LoginButtonTapped {
  const _$LoginButtonTapped({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginEvent.loginButtonTapped(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginButtonTapped &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginButtonTappedCopyWith<_$LoginButtonTapped> get copyWith =>
      __$$LoginButtonTappedCopyWithImpl<_$LoginButtonTapped>(this, _$identity);

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
      required final String password}) = _$LoginButtonTapped;

  String get email;
  String get password;
  @JsonKey(ignore: true)
  _$$LoginButtonTappedCopyWith<_$LoginButtonTapped> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForgotPasswordTappedCopyWith<$Res> {
  factory _$$ForgotPasswordTappedCopyWith(_$ForgotPasswordTapped value,
          $Res Function(_$ForgotPasswordTapped) then) =
      __$$ForgotPasswordTappedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ForgotPasswordTappedCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$ForgotPasswordTapped>
    implements _$$ForgotPasswordTappedCopyWith<$Res> {
  __$$ForgotPasswordTappedCopyWithImpl(_$ForgotPasswordTapped _value,
      $Res Function(_$ForgotPasswordTapped) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ForgotPasswordTapped implements ForgotPasswordTapped {
  const _$ForgotPasswordTapped();

  @override
  String toString() {
    return 'LoginEvent.forgotPasswordTapped()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ForgotPasswordTapped);
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
  const factory ForgotPasswordTapped() = _$ForgotPasswordTapped;
}

/// @nodoc
abstract class _$$SignUpButtonTappedCopyWith<$Res> {
  factory _$$SignUpButtonTappedCopyWith(_$SignUpButtonTapped value,
          $Res Function(_$SignUpButtonTapped) then) =
      __$$SignUpButtonTappedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignUpButtonTappedCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$SignUpButtonTapped>
    implements _$$SignUpButtonTappedCopyWith<$Res> {
  __$$SignUpButtonTappedCopyWithImpl(
      _$SignUpButtonTapped _value, $Res Function(_$SignUpButtonTapped) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignUpButtonTapped implements SignUpButtonTapped {
  const _$SignUpButtonTapped();

  @override
  String toString() {
    return 'LoginEvent.signUpButtonTapped()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignUpButtonTapped);
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
  const factory SignUpButtonTapped() = _$SignUpButtonTapped;
}
