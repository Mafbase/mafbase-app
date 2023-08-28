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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthNotifierModel {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() loading,
    required TResult Function() authorized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? loading,
    TResult? Function()? authorized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? loading,
    TResult Function()? authorized,
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
}

/// @nodoc
abstract class _$$AuthNotifierUnauthorizedModelCopyWith<$Res> {
  factory _$$AuthNotifierUnauthorizedModelCopyWith(
          _$AuthNotifierUnauthorizedModel value,
          $Res Function(_$AuthNotifierUnauthorizedModel) then) =
      __$$AuthNotifierUnauthorizedModelCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthNotifierUnauthorizedModelCopyWithImpl<$Res>
    extends _$AuthNotifierModelCopyWithImpl<$Res,
        _$AuthNotifierUnauthorizedModel>
    implements _$$AuthNotifierUnauthorizedModelCopyWith<$Res> {
  __$$AuthNotifierUnauthorizedModelCopyWithImpl(
      _$AuthNotifierUnauthorizedModel _value,
      $Res Function(_$AuthNotifierUnauthorizedModel) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthNotifierUnauthorizedModel implements AuthNotifierUnauthorizedModel {
  const _$AuthNotifierUnauthorizedModel();

  @override
  String toString() {
    return 'AuthNotifierModel.unauthorized()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthNotifierUnauthorizedModel);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() loading,
    required TResult Function() authorized,
  }) {
    return unauthorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? loading,
    TResult? Function()? authorized,
  }) {
    return unauthorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? loading,
    TResult Function()? authorized,
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
      _$AuthNotifierUnauthorizedModel;
}

/// @nodoc
abstract class _$$AuthNotifierLoadingModelCopyWith<$Res> {
  factory _$$AuthNotifierLoadingModelCopyWith(_$AuthNotifierLoadingModel value,
          $Res Function(_$AuthNotifierLoadingModel) then) =
      __$$AuthNotifierLoadingModelCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthNotifierLoadingModelCopyWithImpl<$Res>
    extends _$AuthNotifierModelCopyWithImpl<$Res, _$AuthNotifierLoadingModel>
    implements _$$AuthNotifierLoadingModelCopyWith<$Res> {
  __$$AuthNotifierLoadingModelCopyWithImpl(_$AuthNotifierLoadingModel _value,
      $Res Function(_$AuthNotifierLoadingModel) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthNotifierLoadingModel implements AuthNotifierLoadingModel {
  const _$AuthNotifierLoadingModel();

  @override
  String toString() {
    return 'AuthNotifierModel.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthNotifierLoadingModel);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() loading,
    required TResult Function() authorized,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? loading,
    TResult? Function()? authorized,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? loading,
    TResult Function()? authorized,
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
  const factory AuthNotifierLoadingModel() = _$AuthNotifierLoadingModel;
}

/// @nodoc
abstract class _$$AuthNotifierAuthorizedModelCopyWith<$Res> {
  factory _$$AuthNotifierAuthorizedModelCopyWith(
          _$AuthNotifierAuthorizedModel value,
          $Res Function(_$AuthNotifierAuthorizedModel) then) =
      __$$AuthNotifierAuthorizedModelCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthNotifierAuthorizedModelCopyWithImpl<$Res>
    extends _$AuthNotifierModelCopyWithImpl<$Res, _$AuthNotifierAuthorizedModel>
    implements _$$AuthNotifierAuthorizedModelCopyWith<$Res> {
  __$$AuthNotifierAuthorizedModelCopyWithImpl(
      _$AuthNotifierAuthorizedModel _value,
      $Res Function(_$AuthNotifierAuthorizedModel) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthNotifierAuthorizedModel implements AuthNotifierAuthorizedModel {
  const _$AuthNotifierAuthorizedModel();

  @override
  String toString() {
    return 'AuthNotifierModel.authorized()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthNotifierAuthorizedModel);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() loading,
    required TResult Function() authorized,
  }) {
    return authorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? loading,
    TResult? Function()? authorized,
  }) {
    return authorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? loading,
    TResult Function()? authorized,
    required TResult orElse(),
  }) {
    if (authorized != null) {
      return authorized();
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
  const factory AuthNotifierAuthorizedModel() = _$AuthNotifierAuthorizedModel;
}
