// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_stats_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayerStatsEvent {
  int get playerId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerId)? pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? pageOpened,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlayerStatsEventPageOpened value) pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlayerStatsEventPageOpened value)? pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlayerStatsEventPageOpened value)? pageOpened,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PlayerStatsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerStatsEventCopyWith<PlayerStatsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStatsEventCopyWith<$Res> {
  factory $PlayerStatsEventCopyWith(
          PlayerStatsEvent value, $Res Function(PlayerStatsEvent) then) =
      _$PlayerStatsEventCopyWithImpl<$Res, PlayerStatsEvent>;
  @useResult
  $Res call({int playerId});
}

/// @nodoc
class _$PlayerStatsEventCopyWithImpl<$Res, $Val extends PlayerStatsEvent>
    implements $PlayerStatsEventCopyWith<$Res> {
  _$PlayerStatsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerStatsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
  }) {
    return _then(_value.copyWith(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerStatsEventPageOpenedImplCopyWith<$Res>
    implements $PlayerStatsEventCopyWith<$Res> {
  factory _$$PlayerStatsEventPageOpenedImplCopyWith(
          _$PlayerStatsEventPageOpenedImpl value,
          $Res Function(_$PlayerStatsEventPageOpenedImpl) then) =
      __$$PlayerStatsEventPageOpenedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int playerId});
}

/// @nodoc
class __$$PlayerStatsEventPageOpenedImplCopyWithImpl<$Res>
    extends _$PlayerStatsEventCopyWithImpl<$Res,
        _$PlayerStatsEventPageOpenedImpl>
    implements _$$PlayerStatsEventPageOpenedImplCopyWith<$Res> {
  __$$PlayerStatsEventPageOpenedImplCopyWithImpl(
      _$PlayerStatsEventPageOpenedImpl _value,
      $Res Function(_$PlayerStatsEventPageOpenedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerStatsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
  }) {
    return _then(_$PlayerStatsEventPageOpenedImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PlayerStatsEventPageOpenedImpl implements PlayerStatsEventPageOpened {
  const _$PlayerStatsEventPageOpenedImpl({required this.playerId});

  @override
  final int playerId;

  @override
  String toString() {
    return 'PlayerStatsEvent.pageOpened(playerId: $playerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatsEventPageOpenedImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playerId);

  /// Create a copy of PlayerStatsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatsEventPageOpenedImplCopyWith<_$PlayerStatsEventPageOpenedImpl>
      get copyWith => __$$PlayerStatsEventPageOpenedImplCopyWithImpl<
          _$PlayerStatsEventPageOpenedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) pageOpened,
  }) {
    return pageOpened(playerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerId)? pageOpened,
  }) {
    return pageOpened?.call(playerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? pageOpened,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(playerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlayerStatsEventPageOpened value) pageOpened,
  }) {
    return pageOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlayerStatsEventPageOpened value)? pageOpened,
  }) {
    return pageOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlayerStatsEventPageOpened value)? pageOpened,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(this);
    }
    return orElse();
  }
}

abstract class PlayerStatsEventPageOpened implements PlayerStatsEvent {
  const factory PlayerStatsEventPageOpened({required final int playerId}) =
      _$PlayerStatsEventPageOpenedImpl;

  @override
  int get playerId;

  /// Create a copy of PlayerStatsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerStatsEventPageOpenedImplCopyWith<_$PlayerStatsEventPageOpenedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
