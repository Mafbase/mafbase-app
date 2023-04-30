// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProfileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onPageOpened,
    required TResult Function() onLogoutPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? onPageOpened,
    TResult? Function()? onLogoutPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onPageOpened,
    TResult Function()? onLogoutPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileEventPageOpened value) onPageOpened,
    required TResult Function(ProfileEventLogoutPressed value) onLogoutPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileEventPageOpened value)? onPageOpened,
    TResult? Function(ProfileEventLogoutPressed value)? onLogoutPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileEventPageOpened value)? onPageOpened,
    TResult Function(ProfileEventLogoutPressed value)? onLogoutPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEventCopyWith<$Res> {
  factory $ProfileEventCopyWith(
          ProfileEvent value, $Res Function(ProfileEvent) then) =
      _$ProfileEventCopyWithImpl<$Res, ProfileEvent>;
}

/// @nodoc
class _$ProfileEventCopyWithImpl<$Res, $Val extends ProfileEvent>
    implements $ProfileEventCopyWith<$Res> {
  _$ProfileEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ProfileEventPageOpenedCopyWith<$Res> {
  factory _$$ProfileEventPageOpenedCopyWith(_$ProfileEventPageOpened value,
          $Res Function(_$ProfileEventPageOpened) then) =
      __$$ProfileEventPageOpenedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProfileEventPageOpenedCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$ProfileEventPageOpened>
    implements _$$ProfileEventPageOpenedCopyWith<$Res> {
  __$$ProfileEventPageOpenedCopyWithImpl(_$ProfileEventPageOpened _value,
      $Res Function(_$ProfileEventPageOpened) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ProfileEventPageOpened implements ProfileEventPageOpened {
  const _$ProfileEventPageOpened();

  @override
  String toString() {
    return 'ProfileEvent.onPageOpened()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProfileEventPageOpened);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onPageOpened,
    required TResult Function() onLogoutPressed,
  }) {
    return onPageOpened();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? onPageOpened,
    TResult? Function()? onLogoutPressed,
  }) {
    return onPageOpened?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onPageOpened,
    TResult Function()? onLogoutPressed,
    required TResult orElse(),
  }) {
    if (onPageOpened != null) {
      return onPageOpened();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileEventPageOpened value) onPageOpened,
    required TResult Function(ProfileEventLogoutPressed value) onLogoutPressed,
  }) {
    return onPageOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileEventPageOpened value)? onPageOpened,
    TResult? Function(ProfileEventLogoutPressed value)? onLogoutPressed,
  }) {
    return onPageOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileEventPageOpened value)? onPageOpened,
    TResult Function(ProfileEventLogoutPressed value)? onLogoutPressed,
    required TResult orElse(),
  }) {
    if (onPageOpened != null) {
      return onPageOpened(this);
    }
    return orElse();
  }
}

abstract class ProfileEventPageOpened implements ProfileEvent {
  const factory ProfileEventPageOpened() = _$ProfileEventPageOpened;
}

/// @nodoc
abstract class _$$ProfileEventLogoutPressedCopyWith<$Res> {
  factory _$$ProfileEventLogoutPressedCopyWith(
          _$ProfileEventLogoutPressed value,
          $Res Function(_$ProfileEventLogoutPressed) then) =
      __$$ProfileEventLogoutPressedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProfileEventLogoutPressedCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$ProfileEventLogoutPressed>
    implements _$$ProfileEventLogoutPressedCopyWith<$Res> {
  __$$ProfileEventLogoutPressedCopyWithImpl(_$ProfileEventLogoutPressed _value,
      $Res Function(_$ProfileEventLogoutPressed) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ProfileEventLogoutPressed implements ProfileEventLogoutPressed {
  const _$ProfileEventLogoutPressed();

  @override
  String toString() {
    return 'ProfileEvent.onLogoutPressed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileEventLogoutPressed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onPageOpened,
    required TResult Function() onLogoutPressed,
  }) {
    return onLogoutPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? onPageOpened,
    TResult? Function()? onLogoutPressed,
  }) {
    return onLogoutPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onPageOpened,
    TResult Function()? onLogoutPressed,
    required TResult orElse(),
  }) {
    if (onLogoutPressed != null) {
      return onLogoutPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileEventPageOpened value) onPageOpened,
    required TResult Function(ProfileEventLogoutPressed value) onLogoutPressed,
  }) {
    return onLogoutPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileEventPageOpened value)? onPageOpened,
    TResult? Function(ProfileEventLogoutPressed value)? onLogoutPressed,
  }) {
    return onLogoutPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileEventPageOpened value)? onPageOpened,
    TResult Function(ProfileEventLogoutPressed value)? onLogoutPressed,
    required TResult orElse(),
  }) {
    if (onLogoutPressed != null) {
      return onLogoutPressed(this);
    }
    return orElse();
  }
}

abstract class ProfileEventLogoutPressed implements ProfileEvent {
  const factory ProfileEventLogoutPressed() = _$ProfileEventLogoutPressed;
}
