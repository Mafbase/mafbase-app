// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'rating_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RatingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) playerSelected,
    required TResult Function(int gameId) gameSelected,
    required TResult Function(DateTimeRange range, int clubId) pageOpened,
    required TResult Function(DateTimeRange range, int clubId) rangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(int gameId)? gameSelected,
    TResult Function(DateTimeRange range, int clubId)? pageOpened,
    TResult Function(DateTimeRange range, int clubId)? rangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(int gameId)? gameSelected,
    TResult Function(DateTimeRange range, int clubId)? pageOpened,
    TResult Function(DateTimeRange range, int clubId)? rangeChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RatingEventPlayerSelected value) playerSelected,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingEventCopyWith<$Res> {
  factory $RatingEventCopyWith(
          RatingEvent value, $Res Function(RatingEvent) then) =
      _$RatingEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$RatingEventCopyWithImpl<$Res> implements $RatingEventCopyWith<$Res> {
  _$RatingEventCopyWithImpl(this._value, this._then);

  final RatingEvent _value;
  // ignore: unused_field
  final $Res Function(RatingEvent) _then;
}

/// @nodoc
abstract class _$$RatingEventPlayerSelectedCopyWith<$Res> {
  factory _$$RatingEventPlayerSelectedCopyWith(
          _$RatingEventPlayerSelected value,
          $Res Function(_$RatingEventPlayerSelected) then) =
      __$$RatingEventPlayerSelectedCopyWithImpl<$Res>;
  $Res call({int playerId});
}

/// @nodoc
class __$$RatingEventPlayerSelectedCopyWithImpl<$Res>
    extends _$RatingEventCopyWithImpl<$Res>
    implements _$$RatingEventPlayerSelectedCopyWith<$Res> {
  __$$RatingEventPlayerSelectedCopyWithImpl(_$RatingEventPlayerSelected _value,
      $Res Function(_$RatingEventPlayerSelected) _then)
      : super(_value, (v) => _then(v as _$RatingEventPlayerSelected));

  @override
  _$RatingEventPlayerSelected get _value =>
      super._value as _$RatingEventPlayerSelected;

  @override
  $Res call({
    Object? playerId = freezed,
  }) {
    return _then(_$RatingEventPlayerSelected(
      playerId: playerId == freezed
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RatingEventPlayerSelected implements RatingEventPlayerSelected {
  const _$RatingEventPlayerSelected({required this.playerId});

  @override
  final int playerId;

  @override
  String toString() {
    return 'RatingEvent.playerSelected(playerId: $playerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingEventPlayerSelected &&
            const DeepCollectionEquality().equals(other.playerId, playerId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(playerId));

  @JsonKey(ignore: true)
  @override
  _$$RatingEventPlayerSelectedCopyWith<_$RatingEventPlayerSelected>
      get copyWith => __$$RatingEventPlayerSelectedCopyWithImpl<
          _$RatingEventPlayerSelected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) playerSelected,
    required TResult Function(int gameId) gameSelected,
    required TResult Function(DateTimeRange range, int clubId) pageOpened,
    required TResult Function(DateTimeRange range, int clubId) rangeChanged,
  }) {
    return playerSelected(playerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(int gameId)? gameSelected,
    TResult Function(DateTimeRange range, int clubId)? pageOpened,
    TResult Function(DateTimeRange range, int clubId)? rangeChanged,
  }) {
    return playerSelected?.call(playerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(int gameId)? gameSelected,
    TResult Function(DateTimeRange range, int clubId)? pageOpened,
    TResult Function(DateTimeRange range, int clubId)? rangeChanged,
    required TResult orElse(),
  }) {
    if (playerSelected != null) {
      return playerSelected(playerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RatingEventPlayerSelected value) playerSelected,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) {
    return playerSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
  }) {
    return playerSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
    required TResult orElse(),
  }) {
    if (playerSelected != null) {
      return playerSelected(this);
    }
    return orElse();
  }
}

abstract class RatingEventPlayerSelected implements RatingEvent {
  const factory RatingEventPlayerSelected({required final int playerId}) =
      _$RatingEventPlayerSelected;

  int get playerId;
  @JsonKey(ignore: true)
  _$$RatingEventPlayerSelectedCopyWith<_$RatingEventPlayerSelected>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RatingEventGameSelectedCopyWith<$Res> {
  factory _$$RatingEventGameSelectedCopyWith(_$RatingEventGameSelected value,
          $Res Function(_$RatingEventGameSelected) then) =
      __$$RatingEventGameSelectedCopyWithImpl<$Res>;
  $Res call({int gameId});
}

/// @nodoc
class __$$RatingEventGameSelectedCopyWithImpl<$Res>
    extends _$RatingEventCopyWithImpl<$Res>
    implements _$$RatingEventGameSelectedCopyWith<$Res> {
  __$$RatingEventGameSelectedCopyWithImpl(_$RatingEventGameSelected _value,
      $Res Function(_$RatingEventGameSelected) _then)
      : super(_value, (v) => _then(v as _$RatingEventGameSelected));

  @override
  _$RatingEventGameSelected get _value =>
      super._value as _$RatingEventGameSelected;

  @override
  $Res call({
    Object? gameId = freezed,
  }) {
    return _then(_$RatingEventGameSelected(
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RatingEventGameSelected implements RatingEventGameSelected {
  const _$RatingEventGameSelected({required this.gameId});

  @override
  final int gameId;

  @override
  String toString() {
    return 'RatingEvent.gameSelected(gameId: $gameId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingEventGameSelected &&
            const DeepCollectionEquality().equals(other.gameId, gameId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(gameId));

  @JsonKey(ignore: true)
  @override
  _$$RatingEventGameSelectedCopyWith<_$RatingEventGameSelected> get copyWith =>
      __$$RatingEventGameSelectedCopyWithImpl<_$RatingEventGameSelected>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) playerSelected,
    required TResult Function(int gameId) gameSelected,
    required TResult Function(DateTimeRange range, int clubId) pageOpened,
    required TResult Function(DateTimeRange range, int clubId) rangeChanged,
  }) {
    return gameSelected(gameId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(int gameId)? gameSelected,
    TResult Function(DateTimeRange range, int clubId)? pageOpened,
    TResult Function(DateTimeRange range, int clubId)? rangeChanged,
  }) {
    return gameSelected?.call(gameId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(int gameId)? gameSelected,
    TResult Function(DateTimeRange range, int clubId)? pageOpened,
    TResult Function(DateTimeRange range, int clubId)? rangeChanged,
    required TResult orElse(),
  }) {
    if (gameSelected != null) {
      return gameSelected(gameId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RatingEventPlayerSelected value) playerSelected,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) {
    return gameSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
  }) {
    return gameSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
    required TResult orElse(),
  }) {
    if (gameSelected != null) {
      return gameSelected(this);
    }
    return orElse();
  }
}

abstract class RatingEventGameSelected implements RatingEvent {
  const factory RatingEventGameSelected({required final int gameId}) =
      _$RatingEventGameSelected;

  int get gameId;
  @JsonKey(ignore: true)
  _$$RatingEventGameSelectedCopyWith<_$RatingEventGameSelected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RatingEventPageOpenedCopyWith<$Res> {
  factory _$$RatingEventPageOpenedCopyWith(_$RatingEventPageOpened value,
          $Res Function(_$RatingEventPageOpened) then) =
      __$$RatingEventPageOpenedCopyWithImpl<$Res>;
  $Res call({DateTimeRange range, int clubId});
}

/// @nodoc
class __$$RatingEventPageOpenedCopyWithImpl<$Res>
    extends _$RatingEventCopyWithImpl<$Res>
    implements _$$RatingEventPageOpenedCopyWith<$Res> {
  __$$RatingEventPageOpenedCopyWithImpl(_$RatingEventPageOpened _value,
      $Res Function(_$RatingEventPageOpened) _then)
      : super(_value, (v) => _then(v as _$RatingEventPageOpened));

  @override
  _$RatingEventPageOpened get _value => super._value as _$RatingEventPageOpened;

  @override
  $Res call({
    Object? range = freezed,
    Object? clubId = freezed,
  }) {
    return _then(_$RatingEventPageOpened(
      range: range == freezed
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as DateTimeRange,
      clubId: clubId == freezed
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RatingEventPageOpened implements RatingEventPageOpened {
  const _$RatingEventPageOpened({required this.range, required this.clubId});

  @override
  final DateTimeRange range;
  @override
  final int clubId;

  @override
  String toString() {
    return 'RatingEvent.pageOpened(range: $range, clubId: $clubId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingEventPageOpened &&
            const DeepCollectionEquality().equals(other.range, range) &&
            const DeepCollectionEquality().equals(other.clubId, clubId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(range),
      const DeepCollectionEquality().hash(clubId));

  @JsonKey(ignore: true)
  @override
  _$$RatingEventPageOpenedCopyWith<_$RatingEventPageOpened> get copyWith =>
      __$$RatingEventPageOpenedCopyWithImpl<_$RatingEventPageOpened>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) playerSelected,
    required TResult Function(int gameId) gameSelected,
    required TResult Function(DateTimeRange range, int clubId) pageOpened,
    required TResult Function(DateTimeRange range, int clubId) rangeChanged,
  }) {
    return pageOpened(range, clubId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(int gameId)? gameSelected,
    TResult Function(DateTimeRange range, int clubId)? pageOpened,
    TResult Function(DateTimeRange range, int clubId)? rangeChanged,
  }) {
    return pageOpened?.call(range, clubId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(int gameId)? gameSelected,
    TResult Function(DateTimeRange range, int clubId)? pageOpened,
    TResult Function(DateTimeRange range, int clubId)? rangeChanged,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(range, clubId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RatingEventPlayerSelected value) playerSelected,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) {
    return pageOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
  }) {
    return pageOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(this);
    }
    return orElse();
  }
}

abstract class RatingEventPageOpened implements RatingEvent {
  const factory RatingEventPageOpened(
      {required final DateTimeRange range,
      required final int clubId}) = _$RatingEventPageOpened;

  DateTimeRange get range;
  int get clubId;
  @JsonKey(ignore: true)
  _$$RatingEventPageOpenedCopyWith<_$RatingEventPageOpened> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RatingEventRangeChangedCopyWith<$Res> {
  factory _$$RatingEventRangeChangedCopyWith(_$RatingEventRangeChanged value,
          $Res Function(_$RatingEventRangeChanged) then) =
      __$$RatingEventRangeChangedCopyWithImpl<$Res>;
  $Res call({DateTimeRange range, int clubId});
}

/// @nodoc
class __$$RatingEventRangeChangedCopyWithImpl<$Res>
    extends _$RatingEventCopyWithImpl<$Res>
    implements _$$RatingEventRangeChangedCopyWith<$Res> {
  __$$RatingEventRangeChangedCopyWithImpl(_$RatingEventRangeChanged _value,
      $Res Function(_$RatingEventRangeChanged) _then)
      : super(_value, (v) => _then(v as _$RatingEventRangeChanged));

  @override
  _$RatingEventRangeChanged get _value =>
      super._value as _$RatingEventRangeChanged;

  @override
  $Res call({
    Object? range = freezed,
    Object? clubId = freezed,
  }) {
    return _then(_$RatingEventRangeChanged(
      range: range == freezed
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as DateTimeRange,
      clubId: clubId == freezed
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RatingEventRangeChanged implements RatingEventRangeChanged {
  const _$RatingEventRangeChanged({required this.range, required this.clubId});

  @override
  final DateTimeRange range;
  @override
  final int clubId;

  @override
  String toString() {
    return 'RatingEvent.rangeChanged(range: $range, clubId: $clubId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingEventRangeChanged &&
            const DeepCollectionEquality().equals(other.range, range) &&
            const DeepCollectionEquality().equals(other.clubId, clubId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(range),
      const DeepCollectionEquality().hash(clubId));

  @JsonKey(ignore: true)
  @override
  _$$RatingEventRangeChangedCopyWith<_$RatingEventRangeChanged> get copyWith =>
      __$$RatingEventRangeChangedCopyWithImpl<_$RatingEventRangeChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) playerSelected,
    required TResult Function(int gameId) gameSelected,
    required TResult Function(DateTimeRange range, int clubId) pageOpened,
    required TResult Function(DateTimeRange range, int clubId) rangeChanged,
  }) {
    return rangeChanged(range, clubId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(int gameId)? gameSelected,
    TResult Function(DateTimeRange range, int clubId)? pageOpened,
    TResult Function(DateTimeRange range, int clubId)? rangeChanged,
  }) {
    return rangeChanged?.call(range, clubId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(int gameId)? gameSelected,
    TResult Function(DateTimeRange range, int clubId)? pageOpened,
    TResult Function(DateTimeRange range, int clubId)? rangeChanged,
    required TResult orElse(),
  }) {
    if (rangeChanged != null) {
      return rangeChanged(range, clubId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RatingEventPlayerSelected value) playerSelected,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) {
    return rangeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
  }) {
    return rangeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
    required TResult orElse(),
  }) {
    if (rangeChanged != null) {
      return rangeChanged(this);
    }
    return orElse();
  }
}

abstract class RatingEventRangeChanged implements RatingEvent {
  const factory RatingEventRangeChanged(
      {required final DateTimeRange range,
      required final int clubId}) = _$RatingEventRangeChanged;

  DateTimeRange get range;
  int get clubId;
  @JsonKey(ignore: true)
  _$$RatingEventRangeChangedCopyWith<_$RatingEventRangeChanged> get copyWith =>
      throw _privateConstructorUsedError;
}
