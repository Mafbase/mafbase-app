// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
    TResult? Function()? backButtonTapped,
    TResult? Function(String email, String password)? signUpButtonTapped,
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
    TResult? Function(BackButtonTapped value)? backButtonTapped,
    TResult? Function(SignUpButtonTapped value)? signUpButtonTapped,
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
      _$SignUpEventsCopyWithImpl<$Res, SignUpEvents>;
}

/// @nodoc
class _$SignUpEventsCopyWithImpl<$Res, $Val extends SignUpEvents>
    implements $SignUpEventsCopyWith<$Res> {
  _$SignUpEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignUpEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BackButtonTappedImplCopyWith<$Res> {
  factory _$$BackButtonTappedImplCopyWith(_$BackButtonTappedImpl value,
          $Res Function(_$BackButtonTappedImpl) then) =
      __$$BackButtonTappedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackButtonTappedImplCopyWithImpl<$Res>
    extends _$SignUpEventsCopyWithImpl<$Res, _$BackButtonTappedImpl>
    implements _$$BackButtonTappedImplCopyWith<$Res> {
  __$$BackButtonTappedImplCopyWithImpl(_$BackButtonTappedImpl _value,
      $Res Function(_$BackButtonTappedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignUpEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BackButtonTappedImpl implements BackButtonTapped {
  const _$BackButtonTappedImpl();

  @override
  String toString() {
    return 'SignUpEvents.backButtonTapped()';
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
    required TResult Function() backButtonTapped,
    required TResult Function(String email, String password) signUpButtonTapped,
  }) {
    return backButtonTapped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? backButtonTapped,
    TResult? Function(String email, String password)? signUpButtonTapped,
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
    TResult? Function(BackButtonTapped value)? backButtonTapped,
    TResult? Function(SignUpButtonTapped value)? signUpButtonTapped,
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
  const factory BackButtonTapped() = _$BackButtonTappedImpl;
}

/// @nodoc
abstract class _$$SignUpButtonTappedImplCopyWith<$Res> {
  factory _$$SignUpButtonTappedImplCopyWith(_$SignUpButtonTappedImpl value,
          $Res Function(_$SignUpButtonTappedImpl) then) =
      __$$SignUpButtonTappedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$SignUpButtonTappedImplCopyWithImpl<$Res>
    extends _$SignUpEventsCopyWithImpl<$Res, _$SignUpButtonTappedImpl>
    implements _$$SignUpButtonTappedImplCopyWith<$Res> {
  __$$SignUpButtonTappedImplCopyWithImpl(_$SignUpButtonTappedImpl _value,
      $Res Function(_$SignUpButtonTappedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignUpEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$SignUpButtonTappedImpl(
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

class _$SignUpButtonTappedImpl implements SignUpButtonTapped {
  const _$SignUpButtonTappedImpl({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'SignUpEvents.signUpButtonTapped(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpButtonTappedImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of SignUpEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpButtonTappedImplCopyWith<_$SignUpButtonTappedImpl> get copyWith =>
      __$$SignUpButtonTappedImplCopyWithImpl<_$SignUpButtonTappedImpl>(
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
    TResult? Function()? backButtonTapped,
    TResult? Function(String email, String password)? signUpButtonTapped,
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
    TResult? Function(BackButtonTapped value)? backButtonTapped,
    TResult? Function(SignUpButtonTapped value)? signUpButtonTapped,
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
      required final String password}) = _$SignUpButtonTappedImpl;

  String get email;
  String get password;

  /// Create a copy of SignUpEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpButtonTappedImplCopyWith<_$SignUpButtonTappedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
