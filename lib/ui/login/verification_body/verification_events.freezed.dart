// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VerificationEvents {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) submit,
    required TResult Function() signUpButtonTapped,
    required TResult Function() loginButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token)? submit,
    TResult? Function()? signUpButtonTapped,
    TResult? Function()? loginButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? submit,
    TResult Function()? signUpButtonTapped,
    TResult Function()? loginButtonTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerificationEventSubmit value) submit,
    required TResult Function(OnSignUpButtonTapped value) signUpButtonTapped,
    required TResult Function(OnLoginButtonTapped value) loginButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerificationEventSubmit value)? submit,
    TResult? Function(OnSignUpButtonTapped value)? signUpButtonTapped,
    TResult? Function(OnLoginButtonTapped value)? loginButtonTapped,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerificationEventSubmit value)? submit,
    TResult Function(OnSignUpButtonTapped value)? signUpButtonTapped,
    TResult Function(OnLoginButtonTapped value)? loginButtonTapped,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationEventsCopyWith<$Res> {
  factory $VerificationEventsCopyWith(
          VerificationEvents value, $Res Function(VerificationEvents) then) =
      _$VerificationEventsCopyWithImpl<$Res, VerificationEvents>;
}

/// @nodoc
class _$VerificationEventsCopyWithImpl<$Res, $Val extends VerificationEvents>
    implements $VerificationEventsCopyWith<$Res> {
  _$VerificationEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerificationEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$VerificationEventSubmitImplCopyWith<$Res> {
  factory _$$VerificationEventSubmitImplCopyWith(
          _$VerificationEventSubmitImpl value,
          $Res Function(_$VerificationEventSubmitImpl) then) =
      __$$VerificationEventSubmitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$VerificationEventSubmitImplCopyWithImpl<$Res>
    extends _$VerificationEventsCopyWithImpl<$Res,
        _$VerificationEventSubmitImpl>
    implements _$$VerificationEventSubmitImplCopyWith<$Res> {
  __$$VerificationEventSubmitImplCopyWithImpl(
      _$VerificationEventSubmitImpl _value,
      $Res Function(_$VerificationEventSubmitImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationEvents
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$VerificationEventSubmitImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerificationEventSubmitImpl implements VerificationEventSubmit {
  const _$VerificationEventSubmitImpl({required this.token});

  @override
  final String token;

  @override
  String toString() {
    return 'VerificationEvents.submit(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationEventSubmitImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of VerificationEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationEventSubmitImplCopyWith<_$VerificationEventSubmitImpl>
      get copyWith => __$$VerificationEventSubmitImplCopyWithImpl<
          _$VerificationEventSubmitImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) submit,
    required TResult Function() signUpButtonTapped,
    required TResult Function() loginButtonTapped,
  }) {
    return submit(token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token)? submit,
    TResult? Function()? signUpButtonTapped,
    TResult? Function()? loginButtonTapped,
  }) {
    return submit?.call(token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? submit,
    TResult Function()? signUpButtonTapped,
    TResult Function()? loginButtonTapped,
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
    required TResult Function(OnSignUpButtonTapped value) signUpButtonTapped,
    required TResult Function(OnLoginButtonTapped value) loginButtonTapped,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerificationEventSubmit value)? submit,
    TResult? Function(OnSignUpButtonTapped value)? signUpButtonTapped,
    TResult? Function(OnLoginButtonTapped value)? loginButtonTapped,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerificationEventSubmit value)? submit,
    TResult Function(OnSignUpButtonTapped value)? signUpButtonTapped,
    TResult Function(OnLoginButtonTapped value)? loginButtonTapped,
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
      _$VerificationEventSubmitImpl;

  String get token;

  /// Create a copy of VerificationEvents
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationEventSubmitImplCopyWith<_$VerificationEventSubmitImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnSignUpButtonTappedImplCopyWith<$Res> {
  factory _$$OnSignUpButtonTappedImplCopyWith(_$OnSignUpButtonTappedImpl value,
          $Res Function(_$OnSignUpButtonTappedImpl) then) =
      __$$OnSignUpButtonTappedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnSignUpButtonTappedImplCopyWithImpl<$Res>
    extends _$VerificationEventsCopyWithImpl<$Res, _$OnSignUpButtonTappedImpl>
    implements _$$OnSignUpButtonTappedImplCopyWith<$Res> {
  __$$OnSignUpButtonTappedImplCopyWithImpl(_$OnSignUpButtonTappedImpl _value,
      $Res Function(_$OnSignUpButtonTappedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OnSignUpButtonTappedImpl implements OnSignUpButtonTapped {
  const _$OnSignUpButtonTappedImpl();

  @override
  String toString() {
    return 'VerificationEvents.signUpButtonTapped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnSignUpButtonTappedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) submit,
    required TResult Function() signUpButtonTapped,
    required TResult Function() loginButtonTapped,
  }) {
    return signUpButtonTapped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token)? submit,
    TResult? Function()? signUpButtonTapped,
    TResult? Function()? loginButtonTapped,
  }) {
    return signUpButtonTapped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? submit,
    TResult Function()? signUpButtonTapped,
    TResult Function()? loginButtonTapped,
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
    required TResult Function(VerificationEventSubmit value) submit,
    required TResult Function(OnSignUpButtonTapped value) signUpButtonTapped,
    required TResult Function(OnLoginButtonTapped value) loginButtonTapped,
  }) {
    return signUpButtonTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerificationEventSubmit value)? submit,
    TResult? Function(OnSignUpButtonTapped value)? signUpButtonTapped,
    TResult? Function(OnLoginButtonTapped value)? loginButtonTapped,
  }) {
    return signUpButtonTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerificationEventSubmit value)? submit,
    TResult Function(OnSignUpButtonTapped value)? signUpButtonTapped,
    TResult Function(OnLoginButtonTapped value)? loginButtonTapped,
    required TResult orElse(),
  }) {
    if (signUpButtonTapped != null) {
      return signUpButtonTapped(this);
    }
    return orElse();
  }
}

abstract class OnSignUpButtonTapped implements VerificationEvents {
  const factory OnSignUpButtonTapped() = _$OnSignUpButtonTappedImpl;
}

/// @nodoc
abstract class _$$OnLoginButtonTappedImplCopyWith<$Res> {
  factory _$$OnLoginButtonTappedImplCopyWith(_$OnLoginButtonTappedImpl value,
          $Res Function(_$OnLoginButtonTappedImpl) then) =
      __$$OnLoginButtonTappedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnLoginButtonTappedImplCopyWithImpl<$Res>
    extends _$VerificationEventsCopyWithImpl<$Res, _$OnLoginButtonTappedImpl>
    implements _$$OnLoginButtonTappedImplCopyWith<$Res> {
  __$$OnLoginButtonTappedImplCopyWithImpl(_$OnLoginButtonTappedImpl _value,
      $Res Function(_$OnLoginButtonTappedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OnLoginButtonTappedImpl implements OnLoginButtonTapped {
  const _$OnLoginButtonTappedImpl();

  @override
  String toString() {
    return 'VerificationEvents.loginButtonTapped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnLoginButtonTappedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String token) submit,
    required TResult Function() signUpButtonTapped,
    required TResult Function() loginButtonTapped,
  }) {
    return loginButtonTapped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String token)? submit,
    TResult? Function()? signUpButtonTapped,
    TResult? Function()? loginButtonTapped,
  }) {
    return loginButtonTapped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String token)? submit,
    TResult Function()? signUpButtonTapped,
    TResult Function()? loginButtonTapped,
    required TResult orElse(),
  }) {
    if (loginButtonTapped != null) {
      return loginButtonTapped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerificationEventSubmit value) submit,
    required TResult Function(OnSignUpButtonTapped value) signUpButtonTapped,
    required TResult Function(OnLoginButtonTapped value) loginButtonTapped,
  }) {
    return loginButtonTapped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerificationEventSubmit value)? submit,
    TResult? Function(OnSignUpButtonTapped value)? signUpButtonTapped,
    TResult? Function(OnLoginButtonTapped value)? loginButtonTapped,
  }) {
    return loginButtonTapped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerificationEventSubmit value)? submit,
    TResult Function(OnSignUpButtonTapped value)? signUpButtonTapped,
    TResult Function(OnLoginButtonTapped value)? loginButtonTapped,
    required TResult orElse(),
  }) {
    if (loginButtonTapped != null) {
      return loginButtonTapped(this);
    }
    return orElse();
  }
}

abstract class OnLoginButtonTapped implements VerificationEvents {
  const factory OnLoginButtonTapped() = _$OnLoginButtonTappedImpl;
}
