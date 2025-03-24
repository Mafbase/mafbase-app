// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_notifier_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthNotifierModel {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() loading,
    required TResult Function(bool hideBilling) authorized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? loading,
    TResult? Function(bool hideBilling)? authorized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? loading,
    TResult Function(bool hideBilling)? authorized,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthNotifierUnauthorizedModel value) unauthorized,
    required TResult Function(AuthNotifierLoadingModel value) loading,
    required TResult Function(AuthNotifierAuthorizedModel value) authorized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthNotifierUnauthorizedModel value)? unauthorized,
    TResult? Function(AuthNotifierLoadingModel value)? loading,
    TResult? Function(AuthNotifierAuthorizedModel value)? authorized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthNotifierUnauthorizedModel value)? unauthorized,
    TResult Function(AuthNotifierLoadingModel value)? loading,
    TResult Function(AuthNotifierAuthorizedModel value)? authorized,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthNotifierModelCopyWith<$Res> {
  factory $AuthNotifierModelCopyWith(
          AuthNotifierModel value, $Res Function(AuthNotifierModel) then) =
      _$AuthNotifierModelCopyWithImpl<$Res, AuthNotifierModel>;
}

/// @nodoc
class _$AuthNotifierModelCopyWithImpl<$Res, $Val extends AuthNotifierModel>
    implements $AuthNotifierModelCopyWith<$Res> {
  _$AuthNotifierModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthNotifierModel
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthNotifierUnauthorizedModelImplCopyWith<$Res> {
  factory _$$AuthNotifierUnauthorizedModelImplCopyWith(
          _$AuthNotifierUnauthorizedModelImpl value,
          $Res Function(_$AuthNotifierUnauthorizedModelImpl) then) =
      __$$AuthNotifierUnauthorizedModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthNotifierUnauthorizedModelImplCopyWithImpl<$Res>
    extends _$AuthNotifierModelCopyWithImpl<$Res,
        _$AuthNotifierUnauthorizedModelImpl>
    implements _$$AuthNotifierUnauthorizedModelImplCopyWith<$Res> {
  __$$AuthNotifierUnauthorizedModelImplCopyWithImpl(
      _$AuthNotifierUnauthorizedModelImpl _value,
      $Res Function(_$AuthNotifierUnauthorizedModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthNotifierModel
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthNotifierUnauthorizedModelImpl
    implements AuthNotifierUnauthorizedModel {
  const _$AuthNotifierUnauthorizedModelImpl();

  @override
  String toString() {
    return 'AuthNotifierModel.unauthorized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthNotifierUnauthorizedModelImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() loading,
    required TResult Function(bool hideBilling) authorized,
  }) {
    return unauthorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? loading,
    TResult? Function(bool hideBilling)? authorized,
  }) {
    return unauthorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? loading,
    TResult Function(bool hideBilling)? authorized,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthNotifierUnauthorizedModel value) unauthorized,
    required TResult Function(AuthNotifierLoadingModel value) loading,
    required TResult Function(AuthNotifierAuthorizedModel value) authorized,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthNotifierUnauthorizedModel value)? unauthorized,
    TResult? Function(AuthNotifierLoadingModel value)? loading,
    TResult? Function(AuthNotifierAuthorizedModel value)? authorized,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthNotifierUnauthorizedModel value)? unauthorized,
    TResult Function(AuthNotifierLoadingModel value)? loading,
    TResult Function(AuthNotifierAuthorizedModel value)? authorized,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class AuthNotifierUnauthorizedModel implements AuthNotifierModel {
  const factory AuthNotifierUnauthorizedModel() =
      _$AuthNotifierUnauthorizedModelImpl;
}

/// @nodoc
abstract class _$$AuthNotifierLoadingModelImplCopyWith<$Res> {
  factory _$$AuthNotifierLoadingModelImplCopyWith(
          _$AuthNotifierLoadingModelImpl value,
          $Res Function(_$AuthNotifierLoadingModelImpl) then) =
      __$$AuthNotifierLoadingModelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthNotifierLoadingModelImplCopyWithImpl<$Res>
    extends _$AuthNotifierModelCopyWithImpl<$Res,
        _$AuthNotifierLoadingModelImpl>
    implements _$$AuthNotifierLoadingModelImplCopyWith<$Res> {
  __$$AuthNotifierLoadingModelImplCopyWithImpl(
      _$AuthNotifierLoadingModelImpl _value,
      $Res Function(_$AuthNotifierLoadingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthNotifierModel
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthNotifierLoadingModelImpl implements AuthNotifierLoadingModel {
  const _$AuthNotifierLoadingModelImpl();

  @override
  String toString() {
    return 'AuthNotifierModel.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthNotifierLoadingModelImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() loading,
    required TResult Function(bool hideBilling) authorized,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? loading,
    TResult? Function(bool hideBilling)? authorized,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? loading,
    TResult Function(bool hideBilling)? authorized,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthNotifierUnauthorizedModel value) unauthorized,
    required TResult Function(AuthNotifierLoadingModel value) loading,
    required TResult Function(AuthNotifierAuthorizedModel value) authorized,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthNotifierUnauthorizedModel value)? unauthorized,
    TResult? Function(AuthNotifierLoadingModel value)? loading,
    TResult? Function(AuthNotifierAuthorizedModel value)? authorized,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthNotifierUnauthorizedModel value)? unauthorized,
    TResult Function(AuthNotifierLoadingModel value)? loading,
    TResult Function(AuthNotifierAuthorizedModel value)? authorized,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthNotifierLoadingModel implements AuthNotifierModel {
  const factory AuthNotifierLoadingModel() = _$AuthNotifierLoadingModelImpl;
}

/// @nodoc
abstract class _$$AuthNotifierAuthorizedModelImplCopyWith<$Res> {
  factory _$$AuthNotifierAuthorizedModelImplCopyWith(
          _$AuthNotifierAuthorizedModelImpl value,
          $Res Function(_$AuthNotifierAuthorizedModelImpl) then) =
      __$$AuthNotifierAuthorizedModelImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool hideBilling});
}

/// @nodoc
class __$$AuthNotifierAuthorizedModelImplCopyWithImpl<$Res>
    extends _$AuthNotifierModelCopyWithImpl<$Res,
        _$AuthNotifierAuthorizedModelImpl>
    implements _$$AuthNotifierAuthorizedModelImplCopyWith<$Res> {
  __$$AuthNotifierAuthorizedModelImplCopyWithImpl(
      _$AuthNotifierAuthorizedModelImpl _value,
      $Res Function(_$AuthNotifierAuthorizedModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthNotifierModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hideBilling = null,
  }) {
    return _then(_$AuthNotifierAuthorizedModelImpl(
      hideBilling: null == hideBilling
          ? _value.hideBilling
          : hideBilling // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthNotifierAuthorizedModelImpl implements AuthNotifierAuthorizedModel {
  const _$AuthNotifierAuthorizedModelImpl({this.hideBilling = false});

  @override
  @JsonKey()
  final bool hideBilling;

  @override
  String toString() {
    return 'AuthNotifierModel.authorized(hideBilling: $hideBilling)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthNotifierAuthorizedModelImpl &&
            (identical(other.hideBilling, hideBilling) ||
                other.hideBilling == hideBilling));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hideBilling);

  /// Create a copy of AuthNotifierModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthNotifierAuthorizedModelImplCopyWith<_$AuthNotifierAuthorizedModelImpl>
      get copyWith => __$$AuthNotifierAuthorizedModelImplCopyWithImpl<
          _$AuthNotifierAuthorizedModelImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() loading,
    required TResult Function(bool hideBilling) authorized,
  }) {
    return authorized(hideBilling);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? loading,
    TResult? Function(bool hideBilling)? authorized,
  }) {
    return authorized?.call(hideBilling);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? loading,
    TResult Function(bool hideBilling)? authorized,
    required TResult orElse(),
  }) {
    if (authorized != null) {
      return authorized(hideBilling);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthNotifierUnauthorizedModel value) unauthorized,
    required TResult Function(AuthNotifierLoadingModel value) loading,
    required TResult Function(AuthNotifierAuthorizedModel value) authorized,
  }) {
    return authorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthNotifierUnauthorizedModel value)? unauthorized,
    TResult? Function(AuthNotifierLoadingModel value)? loading,
    TResult? Function(AuthNotifierAuthorizedModel value)? authorized,
  }) {
    return authorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthNotifierUnauthorizedModel value)? unauthorized,
    TResult Function(AuthNotifierLoadingModel value)? loading,
    TResult Function(AuthNotifierAuthorizedModel value)? authorized,
    required TResult orElse(),
  }) {
    if (authorized != null) {
      return authorized(this);
    }
    return orElse();
  }
}

abstract class AuthNotifierAuthorizedModel implements AuthNotifierModel {
  const factory AuthNotifierAuthorizedModel({final bool hideBilling}) =
      _$AuthNotifierAuthorizedModelImpl;

  bool get hideBilling;

  /// Create a copy of AuthNotifierModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthNotifierAuthorizedModelImplCopyWith<_$AuthNotifierAuthorizedModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
