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
    required TResult Function(String url) openBillingUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? navigateBack,
    TResult? Function(String url)? openBillingUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? navigateBack,
    TResult Function(String url)? openBillingUrl,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileEffectNavigateBack value) navigateBack,
    required TResult Function(ProfileEffectOpenBillingUrl value) openBillingUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileEffectNavigateBack value)? navigateBack,
    TResult? Function(ProfileEffectOpenBillingUrl value)? openBillingUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileEffectNavigateBack value)? navigateBack,
    TResult Function(ProfileEffectOpenBillingUrl value)? openBillingUrl,
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
    required TResult Function(String url) openBillingUrl,
  }) {
    return navigateBack();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? navigateBack,
    TResult? Function(String url)? openBillingUrl,
  }) {
    return navigateBack?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? navigateBack,
    TResult Function(String url)? openBillingUrl,
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
    required TResult Function(ProfileEffectOpenBillingUrl value) openBillingUrl,
  }) {
    return navigateBack(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileEffectNavigateBack value)? navigateBack,
    TResult? Function(ProfileEffectOpenBillingUrl value)? openBillingUrl,
  }) {
    return navigateBack?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileEffectNavigateBack value)? navigateBack,
    TResult Function(ProfileEffectOpenBillingUrl value)? openBillingUrl,
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

/// @nodoc
abstract class _$$ProfileEffectOpenBillingUrlImplCopyWith<$Res> {
  factory _$$ProfileEffectOpenBillingUrlImplCopyWith(
          _$ProfileEffectOpenBillingUrlImpl value,
          $Res Function(_$ProfileEffectOpenBillingUrlImpl) then) =
      __$$ProfileEffectOpenBillingUrlImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$ProfileEffectOpenBillingUrlImplCopyWithImpl<$Res>
    extends _$ProfileEffectCopyWithImpl<$Res, _$ProfileEffectOpenBillingUrlImpl>
    implements _$$ProfileEffectOpenBillingUrlImplCopyWith<$Res> {
  __$$ProfileEffectOpenBillingUrlImplCopyWithImpl(
      _$ProfileEffectOpenBillingUrlImpl _value,
      $Res Function(_$ProfileEffectOpenBillingUrlImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$ProfileEffectOpenBillingUrlImpl(
      null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProfileEffectOpenBillingUrlImpl implements ProfileEffectOpenBillingUrl {
  const _$ProfileEffectOpenBillingUrlImpl(this.url);

  @override
  final String url;

  @override
  String toString() {
    return 'ProfileEffect.openBillingUrl(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileEffectOpenBillingUrlImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);

  /// Create a copy of ProfileEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileEffectOpenBillingUrlImplCopyWith<_$ProfileEffectOpenBillingUrlImpl>
      get copyWith => __$$ProfileEffectOpenBillingUrlImplCopyWithImpl<
          _$ProfileEffectOpenBillingUrlImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() navigateBack,
    required TResult Function(String url) openBillingUrl,
  }) {
    return openBillingUrl(url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? navigateBack,
    TResult? Function(String url)? openBillingUrl,
  }) {
    return openBillingUrl?.call(url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? navigateBack,
    TResult Function(String url)? openBillingUrl,
    required TResult orElse(),
  }) {
    if (openBillingUrl != null) {
      return openBillingUrl(url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileEffectNavigateBack value) navigateBack,
    required TResult Function(ProfileEffectOpenBillingUrl value) openBillingUrl,
  }) {
    return openBillingUrl(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileEffectNavigateBack value)? navigateBack,
    TResult? Function(ProfileEffectOpenBillingUrl value)? openBillingUrl,
  }) {
    return openBillingUrl?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileEffectNavigateBack value)? navigateBack,
    TResult Function(ProfileEffectOpenBillingUrl value)? openBillingUrl,
    required TResult orElse(),
  }) {
    if (openBillingUrl != null) {
      return openBillingUrl(this);
    }
    return orElse();
  }
}

abstract class ProfileEffectOpenBillingUrl implements ProfileEffect {
  const factory ProfileEffectOpenBillingUrl(final String url) =
      _$ProfileEffectOpenBillingUrlImpl;

  String get url;

  /// Create a copy of ProfileEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileEffectOpenBillingUrlImplCopyWith<_$ProfileEffectOpenBillingUrlImpl>
      get copyWith => throw _privateConstructorUsedError;
}
