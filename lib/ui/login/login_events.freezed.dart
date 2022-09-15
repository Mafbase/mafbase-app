// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String email, String password)? loginButtonTapped,
    TResult Function()? forgotPasswordTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginButtonTapped,
    TResult Function()? forgotPasswordTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginButtonTapped value) loginButtonTapped,
    required TResult Function(ForgotPasswordTapped value) forgotPasswordTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoginButtonTapped value)? loginButtonTapped,
    TResult Function(ForgotPasswordTapped value)? forgotPasswordTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginButtonTapped value)? loginButtonTapped,
    TResult Function(ForgotPasswordTapped value)? forgotPasswordTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
          LoginEvent value, $Res Function(LoginEvent) then) =
      _$LoginEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res> implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  final LoginEvent _value;
  // ignore: unused_field
  final $Res Function(LoginEvent) _then;
}

/// @nodoc
abstract class _$$LoginButtonTappedCopyWith<$Res> {
  factory _$$LoginButtonTappedCopyWith(
          _$LoginButtonTapped value, $Res Function(_$LoginButtonTapped) then) =
      __$$LoginButtonTappedCopyWithImpl<$Res>;
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginButtonTappedCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res>
    implements _$$LoginButtonTappedCopyWith<$Res> {
  __$$LoginButtonTappedCopyWithImpl(
      _$LoginButtonTapped _value, $Res Function(_$LoginButtonTapped) _then)
      : super(_value, (v) => _then(v as _$LoginButtonTapped));

  @override
  _$LoginButtonTapped get _value => super._value as _$LoginButtonTapped;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_$LoginButtonTapped(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
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
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  _$$LoginButtonTappedCopyWith<_$LoginButtonTapped> get copyWith =>
      __$$LoginButtonTappedCopyWithImpl<_$LoginButtonTapped>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginButtonTapped,
    required TResult Function() forgotPasswordTapped,
  }) {
    return loginButtonTapped(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String email, String password)? loginButtonTapped,
    TResult Function()? forgotPasswordTapped,
  }) {
    return loginButtonTapped?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginButtonTapped,
    TResult Function()? forgotPasswordTapped,
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
  }) {
    return loginButtonTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoginButtonTapped value)? loginButtonTapped,
    TResult Function(ForgotPasswordTapped value)? forgotPasswordTapped,
  }) {
    return loginButtonTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginButtonTapped value)? loginButtonTapped,
    TResult Function(ForgotPasswordTapped value)? forgotPasswordTapped,
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
    extends _$LoginEventCopyWithImpl<$Res>
    implements _$$ForgotPasswordTappedCopyWith<$Res> {
  __$$ForgotPasswordTappedCopyWithImpl(_$ForgotPasswordTapped _value,
      $Res Function(_$ForgotPasswordTapped) _then)
      : super(_value, (v) => _then(v as _$ForgotPasswordTapped));

  @override
  _$ForgotPasswordTapped get _value => super._value as _$ForgotPasswordTapped;
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
  }) {
    return forgotPasswordTapped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String email, String password)? loginButtonTapped,
    TResult Function()? forgotPasswordTapped,
  }) {
    return forgotPasswordTapped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginButtonTapped,
    TResult Function()? forgotPasswordTapped,
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
  }) {
    return forgotPasswordTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoginButtonTapped value)? loginButtonTapped,
    TResult Function(ForgotPasswordTapped value)? forgotPasswordTapped,
  }) {
    return forgotPasswordTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginButtonTapped value)? loginButtonTapped,
    TResult Function(ForgotPasswordTapped value)? forgotPasswordTapped,
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
