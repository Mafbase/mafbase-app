// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasError, bool isLoading) login,
    required TResult Function(bool loginExistError, bool emailExistError)
        signUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hasError, bool isLoading)? login,
    TResult Function(bool loginExistError, bool emailExistError)? signUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasError, bool isLoading)? login,
    TResult Function(bool loginExistError, bool emailExistError)? signUp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Login value) login,
    required TResult Function(SignUp value) signUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Login value)? login,
    TResult Function(SignUp value)? signUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Login value)? login,
    TResult Function(SignUp value)? signUp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res> implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  final LoginState _value;
  // ignore: unused_field
  final $Res Function(LoginState) _then;
}

/// @nodoc
abstract class _$$LoginCopyWith<$Res> {
  factory _$$LoginCopyWith(_$Login value, $Res Function(_$Login) then) =
      __$$LoginCopyWithImpl<$Res>;
  $Res call({bool hasError, bool isLoading});
}

/// @nodoc
class __$$LoginCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res>
    implements _$$LoginCopyWith<$Res> {
  __$$LoginCopyWithImpl(_$Login _value, $Res Function(_$Login) _then)
      : super(_value, (v) => _then(v as _$Login));

  @override
  _$Login get _value => super._value as _$Login;

  @override
  $Res call({
    Object? hasError = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_$Login(
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$Login implements Login {
  _$Login({required this.hasError, this.isLoading = false});

  @override
  final bool hasError;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'LoginState.login(hasError: $hasError, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Login &&
            const DeepCollectionEquality().equals(other.hasError, hasError) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(hasError),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$$LoginCopyWith<_$Login> get copyWith =>
      __$$LoginCopyWithImpl<_$Login>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasError, bool isLoading) login,
    required TResult Function(bool loginExistError, bool emailExistError)
        signUp,
  }) {
    return login(hasError, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hasError, bool isLoading)? login,
    TResult Function(bool loginExistError, bool emailExistError)? signUp,
  }) {
    return login?.call(hasError, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasError, bool isLoading)? login,
    TResult Function(bool loginExistError, bool emailExistError)? signUp,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(hasError, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Login value) login,
    required TResult Function(SignUp value) signUp,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Login value)? login,
    TResult Function(SignUp value)? signUp,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Login value)? login,
    TResult Function(SignUp value)? signUp,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class Login implements LoginState {
  factory Login({required final bool hasError, final bool isLoading}) = _$Login;

  bool get hasError;
  bool get isLoading;
  @JsonKey(ignore: true)
  _$$LoginCopyWith<_$Login> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignUpCopyWith<$Res> {
  factory _$$SignUpCopyWith(_$SignUp value, $Res Function(_$SignUp) then) =
      __$$SignUpCopyWithImpl<$Res>;
  $Res call({bool loginExistError, bool emailExistError});
}

/// @nodoc
class __$$SignUpCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res>
    implements _$$SignUpCopyWith<$Res> {
  __$$SignUpCopyWithImpl(_$SignUp _value, $Res Function(_$SignUp) _then)
      : super(_value, (v) => _then(v as _$SignUp));

  @override
  _$SignUp get _value => super._value as _$SignUp;

  @override
  $Res call({
    Object? loginExistError = freezed,
    Object? emailExistError = freezed,
  }) {
    return _then(_$SignUp(
      loginExistError: loginExistError == freezed
          ? _value.loginExistError
          : loginExistError // ignore: cast_nullable_to_non_nullable
              as bool,
      emailExistError: emailExistError == freezed
          ? _value.emailExistError
          : emailExistError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SignUp implements SignUp {
  _$SignUp({required this.loginExistError, required this.emailExistError});

  @override
  final bool loginExistError;
  @override
  final bool emailExistError;

  @override
  String toString() {
    return 'LoginState.signUp(loginExistError: $loginExistError, emailExistError: $emailExistError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUp &&
            const DeepCollectionEquality()
                .equals(other.loginExistError, loginExistError) &&
            const DeepCollectionEquality()
                .equals(other.emailExistError, emailExistError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(loginExistError),
      const DeepCollectionEquality().hash(emailExistError));

  @JsonKey(ignore: true)
  @override
  _$$SignUpCopyWith<_$SignUp> get copyWith =>
      __$$SignUpCopyWithImpl<_$SignUp>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasError, bool isLoading) login,
    required TResult Function(bool loginExistError, bool emailExistError)
        signUp,
  }) {
    return signUp(loginExistError, emailExistError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hasError, bool isLoading)? login,
    TResult Function(bool loginExistError, bool emailExistError)? signUp,
  }) {
    return signUp?.call(loginExistError, emailExistError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasError, bool isLoading)? login,
    TResult Function(bool loginExistError, bool emailExistError)? signUp,
    required TResult orElse(),
  }) {
    if (signUp != null) {
      return signUp(loginExistError, emailExistError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Login value) login,
    required TResult Function(SignUp value) signUp,
  }) {
    return signUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Login value)? login,
    TResult Function(SignUp value)? signUp,
  }) {
    return signUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Login value)? login,
    TResult Function(SignUp value)? signUp,
    required TResult orElse(),
  }) {
    if (signUp != null) {
      return signUp(this);
    }
    return orElse();
  }
}

abstract class SignUp implements LoginState {
  factory SignUp(
      {required final bool loginExistError,
      required final bool emailExistError}) = _$SignUp;

  bool get loginExistError;
  bool get emailExistError;
  @JsonKey(ignore: true)
  _$$SignUpCopyWith<_$SignUp> get copyWith =>
      throw _privateConstructorUsedError;
}
