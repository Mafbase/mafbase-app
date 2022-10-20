// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sign_up_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignUpEvents {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() backButtonTapped,
    required TResult Function(String email, String password) signUpButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? backButtonTapped,
    TResult Function(String email, String password)? signUpButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? backButtonTapped,
    TResult Function(String email, String password)? signUpButtonTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BackButtonTapped value) backButtonTapped,
    required TResult Function(SignUpButtonTapped value) signUpButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BackButtonTapped value)? backButtonTapped,
    TResult Function(SignUpButtonTapped value)? signUpButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BackButtonTapped value)? backButtonTapped,
    TResult Function(SignUpButtonTapped value)? signUpButtonTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpEventsCopyWith<$Res> {
  factory $SignUpEventsCopyWith(
          SignUpEvents value, $Res Function(SignUpEvents) then) =
      _$SignUpEventsCopyWithImpl<$Res>;
}

/// @nodoc
class _$SignUpEventsCopyWithImpl<$Res> implements $SignUpEventsCopyWith<$Res> {
  _$SignUpEventsCopyWithImpl(this._value, this._then);

  final SignUpEvents _value;
  // ignore: unused_field
  final $Res Function(SignUpEvents) _then;
}

/// @nodoc
abstract class _$$BackButtonTappedCopyWith<$Res> {
  factory _$$BackButtonTappedCopyWith(
          _$BackButtonTapped value, $Res Function(_$BackButtonTapped) then) =
      __$$BackButtonTappedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackButtonTappedCopyWithImpl<$Res>
    extends _$SignUpEventsCopyWithImpl<$Res>
    implements _$$BackButtonTappedCopyWith<$Res> {
  __$$BackButtonTappedCopyWithImpl(
      _$BackButtonTapped _value, $Res Function(_$BackButtonTapped) _then)
      : super(_value, (v) => _then(v as _$BackButtonTapped));

  @override
  _$BackButtonTapped get _value => super._value as _$BackButtonTapped;
}

/// @nodoc

class _$BackButtonTapped implements BackButtonTapped {
  const _$BackButtonTapped();

  @override
  String toString() {
    return 'SignUpEvents.backButtonTapped()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BackButtonTapped);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() backButtonTapped,
    required TResult Function(String email, String password) signUpButtonTapped,
  }) {
    return backButtonTapped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? backButtonTapped,
    TResult Function(String email, String password)? signUpButtonTapped,
  }) {
    return backButtonTapped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? backButtonTapped,
    TResult Function(String email, String password)? signUpButtonTapped,
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
    required TResult Function(BackButtonTapped value) backButtonTapped,
    required TResult Function(SignUpButtonTapped value) signUpButtonTapped,
  }) {
    return backButtonTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BackButtonTapped value)? backButtonTapped,
    TResult Function(SignUpButtonTapped value)? signUpButtonTapped,
  }) {
    return backButtonTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BackButtonTapped value)? backButtonTapped,
    TResult Function(SignUpButtonTapped value)? signUpButtonTapped,
    required TResult orElse(),
  }) {
    if (backButtonTapped != null) {
      return backButtonTapped(this);
    }
    return orElse();
  }
}

abstract class BackButtonTapped implements SignUpEvents {
  const factory BackButtonTapped() = _$BackButtonTapped;
}

/// @nodoc
abstract class _$$SignUpButtonTappedCopyWith<$Res> {
  factory _$$SignUpButtonTappedCopyWith(_$SignUpButtonTapped value,
          $Res Function(_$SignUpButtonTapped) then) =
      __$$SignUpButtonTappedCopyWithImpl<$Res>;
  $Res call({String email, String password});
}

/// @nodoc
class __$$SignUpButtonTappedCopyWithImpl<$Res>
    extends _$SignUpEventsCopyWithImpl<$Res>
    implements _$$SignUpButtonTappedCopyWith<$Res> {
  __$$SignUpButtonTappedCopyWithImpl(
      _$SignUpButtonTapped _value, $Res Function(_$SignUpButtonTapped) _then)
      : super(_value, (v) => _then(v as _$SignUpButtonTapped));

  @override
  _$SignUpButtonTapped get _value => super._value as _$SignUpButtonTapped;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_$SignUpButtonTapped(
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

class _$SignUpButtonTapped implements SignUpButtonTapped {
  const _$SignUpButtonTapped({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'SignUpEvents.signUpButtonTapped(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpButtonTapped &&
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
  _$$SignUpButtonTappedCopyWith<_$SignUpButtonTapped> get copyWith =>
      __$$SignUpButtonTappedCopyWithImpl<_$SignUpButtonTapped>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() backButtonTapped,
    required TResult Function(String email, String password) signUpButtonTapped,
  }) {
    return signUpButtonTapped(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? backButtonTapped,
    TResult Function(String email, String password)? signUpButtonTapped,
  }) {
    return signUpButtonTapped?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? backButtonTapped,
    TResult Function(String email, String password)? signUpButtonTapped,
    required TResult orElse(),
  }) {
    if (signUpButtonTapped != null) {
      return signUpButtonTapped(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BackButtonTapped value) backButtonTapped,
    required TResult Function(SignUpButtonTapped value) signUpButtonTapped,
  }) {
    return signUpButtonTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BackButtonTapped value)? backButtonTapped,
    TResult Function(SignUpButtonTapped value)? signUpButtonTapped,
  }) {
    return signUpButtonTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BackButtonTapped value)? backButtonTapped,
    TResult Function(SignUpButtonTapped value)? signUpButtonTapped,
    required TResult orElse(),
  }) {
    if (signUpButtonTapped != null) {
      return signUpButtonTapped(this);
    }
    return orElse();
  }
}

abstract class SignUpButtonTapped implements SignUpEvents {
  const factory SignUpButtonTapped(
      {required final String email,
      required final String password}) = _$SignUpButtonTapped;

  String get email;
  String get password;
  @JsonKey(ignore: true)
  _$$SignUpButtonTappedCopyWith<_$SignUpButtonTapped> get copyWith =>
      throw _privateConstructorUsedError;
}
