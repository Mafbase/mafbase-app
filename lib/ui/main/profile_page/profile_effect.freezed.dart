// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_effect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileEffect {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() navigateBack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? navigateBack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? navigateBack,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileEffectNavigateBack value) navigateBack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileEffectNavigateBack value)? navigateBack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileEffectNavigateBack value)? navigateBack,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEffectCopyWith<$Res> {
  factory $ProfileEffectCopyWith(
          ProfileEffect value, $Res Function(ProfileEffect) then) =
      _$ProfileEffectCopyWithImpl<$Res, ProfileEffect>;
}

/// @nodoc
class _$ProfileEffectCopyWithImpl<$Res, $Val extends ProfileEffect>
    implements $ProfileEffectCopyWith<$Res> {
  _$ProfileEffectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileEffect
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProfileEffectNavigateBackImplCopyWith<$Res> {
  factory _$$ProfileEffectNavigateBackImplCopyWith(
          _$ProfileEffectNavigateBackImpl value,
          $Res Function(_$ProfileEffectNavigateBackImpl) then) =
      __$$ProfileEffectNavigateBackImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProfileEffectNavigateBackImplCopyWithImpl<$Res>
    extends _$ProfileEffectCopyWithImpl<$Res, _$ProfileEffectNavigateBackImpl>
    implements _$$ProfileEffectNavigateBackImplCopyWith<$Res> {
  __$$ProfileEffectNavigateBackImplCopyWithImpl(
      _$ProfileEffectNavigateBackImpl _value,
      $Res Function(_$ProfileEffectNavigateBackImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEffect
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProfileEffectNavigateBackImpl implements ProfileEffectNavigateBack {
  const _$ProfileEffectNavigateBackImpl();

  @override
  String toString() {
    return 'ProfileEffect.navigateBack()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileEffectNavigateBackImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() navigateBack,
  }) {
    return navigateBack();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? navigateBack,
  }) {
    return navigateBack?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? navigateBack,
    required TResult orElse(),
  }) {
    if (navigateBack != null) {
      return navigateBack();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileEffectNavigateBack value) navigateBack,
  }) {
    return navigateBack(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileEffectNavigateBack value)? navigateBack,
  }) {
    return navigateBack?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileEffectNavigateBack value)? navigateBack,
    required TResult orElse(),
  }) {
    if (navigateBack != null) {
      return navigateBack(this);
    }
    return orElse();
  }
}

abstract class ProfileEffectNavigateBack implements ProfileEffect {
  const factory ProfileEffectNavigateBack() = _$ProfileEffectNavigateBackImpl;
}
