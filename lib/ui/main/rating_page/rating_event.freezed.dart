// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
    required TResult Function(DateTimeRange range, int clubId) downloadRating,
    required TResult Function(int gameId, int? clubId, int? tournamentId)
        gameSelected,
    required TResult Function(
            DateTimeRange? range, int? clubId, int? tournamentId)
        pageOpened,
    required TResult Function(
            DateTimeRange? range,
            int? clubId,
            int? tournamentId,
            RatingTableStyle style,
            RatingSort sort,
            int gameFilter)
        rangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerId)? playerSelected,
    TResult? Function(DateTimeRange range, int clubId)? downloadRating,
    TResult? Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(DateTimeRange range, int clubId)? downloadRating,
    TResult Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RatingEventPlayerSelected value) playerSelected,
    required TResult Function(RatingEventDownload value) downloadRating,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RatingEventPlayerSelected value)? playerSelected,
    TResult? Function(RatingEventDownload value)? downloadRating,
    TResult? Function(RatingEventGameSelected value)? gameSelected,
    TResult? Function(RatingEventPageOpened value)? pageOpened,
    TResult? Function(RatingEventRangeChanged value)? rangeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventDownload value)? downloadRating,
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
      _$RatingEventCopyWithImpl<$Res, RatingEvent>;
}

/// @nodoc
class _$RatingEventCopyWithImpl<$Res, $Val extends RatingEvent>
    implements $RatingEventCopyWith<$Res> {
  _$RatingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RatingEventPlayerSelectedImplCopyWith<$Res> {
  factory _$$RatingEventPlayerSelectedImplCopyWith(
          _$RatingEventPlayerSelectedImpl value,
          $Res Function(_$RatingEventPlayerSelectedImpl) then) =
      __$$RatingEventPlayerSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int playerId});
}

/// @nodoc
class __$$RatingEventPlayerSelectedImplCopyWithImpl<$Res>
    extends _$RatingEventCopyWithImpl<$Res, _$RatingEventPlayerSelectedImpl>
    implements _$$RatingEventPlayerSelectedImplCopyWith<$Res> {
  __$$RatingEventPlayerSelectedImplCopyWithImpl(
      _$RatingEventPlayerSelectedImpl _value,
      $Res Function(_$RatingEventPlayerSelectedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
  }) {
    return _then(_$RatingEventPlayerSelectedImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RatingEventPlayerSelectedImpl implements RatingEventPlayerSelected {
  const _$RatingEventPlayerSelectedImpl({required this.playerId});

  @override
  final int playerId;

  @override
  String toString() {
    return 'RatingEvent.playerSelected(playerId: $playerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingEventPlayerSelectedImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingEventPlayerSelectedImplCopyWith<_$RatingEventPlayerSelectedImpl>
      get copyWith => __$$RatingEventPlayerSelectedImplCopyWithImpl<
          _$RatingEventPlayerSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) playerSelected,
    required TResult Function(DateTimeRange range, int clubId) downloadRating,
    required TResult Function(int gameId, int? clubId, int? tournamentId)
        gameSelected,
    required TResult Function(
            DateTimeRange? range, int? clubId, int? tournamentId)
        pageOpened,
    required TResult Function(
            DateTimeRange? range,
            int? clubId,
            int? tournamentId,
            RatingTableStyle style,
            RatingSort sort,
            int gameFilter)
        rangeChanged,
  }) {
    return playerSelected(playerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerId)? playerSelected,
    TResult? Function(DateTimeRange range, int clubId)? downloadRating,
    TResult? Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
  }) {
    return playerSelected?.call(playerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(DateTimeRange range, int clubId)? downloadRating,
    TResult Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
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
    required TResult Function(RatingEventDownload value) downloadRating,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) {
    return playerSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RatingEventPlayerSelected value)? playerSelected,
    TResult? Function(RatingEventDownload value)? downloadRating,
    TResult? Function(RatingEventGameSelected value)? gameSelected,
    TResult? Function(RatingEventPageOpened value)? pageOpened,
    TResult? Function(RatingEventRangeChanged value)? rangeChanged,
  }) {
    return playerSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventDownload value)? downloadRating,
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
      _$RatingEventPlayerSelectedImpl;

  int get playerId;
  @JsonKey(ignore: true)
  _$$RatingEventPlayerSelectedImplCopyWith<_$RatingEventPlayerSelectedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RatingEventDownloadImplCopyWith<$Res> {
  factory _$$RatingEventDownloadImplCopyWith(_$RatingEventDownloadImpl value,
          $Res Function(_$RatingEventDownloadImpl) then) =
      __$$RatingEventDownloadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTimeRange range, int clubId});
}

/// @nodoc
class __$$RatingEventDownloadImplCopyWithImpl<$Res>
    extends _$RatingEventCopyWithImpl<$Res, _$RatingEventDownloadImpl>
    implements _$$RatingEventDownloadImplCopyWith<$Res> {
  __$$RatingEventDownloadImplCopyWithImpl(_$RatingEventDownloadImpl _value,
      $Res Function(_$RatingEventDownloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? range = null,
    Object? clubId = null,
  }) {
    return _then(_$RatingEventDownloadImpl(
      range: null == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as DateTimeRange,
      clubId: null == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RatingEventDownloadImpl implements RatingEventDownload {
  const _$RatingEventDownloadImpl({required this.range, required this.clubId});

  @override
  final DateTimeRange range;
  @override
  final int clubId;

  @override
  String toString() {
    return 'RatingEvent.downloadRating(range: $range, clubId: $clubId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingEventDownloadImpl &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.clubId, clubId) || other.clubId == clubId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, range, clubId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingEventDownloadImplCopyWith<_$RatingEventDownloadImpl> get copyWith =>
      __$$RatingEventDownloadImplCopyWithImpl<_$RatingEventDownloadImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) playerSelected,
    required TResult Function(DateTimeRange range, int clubId) downloadRating,
    required TResult Function(int gameId, int? clubId, int? tournamentId)
        gameSelected,
    required TResult Function(
            DateTimeRange? range, int? clubId, int? tournamentId)
        pageOpened,
    required TResult Function(
            DateTimeRange? range,
            int? clubId,
            int? tournamentId,
            RatingTableStyle style,
            RatingSort sort,
            int gameFilter)
        rangeChanged,
  }) {
    return downloadRating(range, clubId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerId)? playerSelected,
    TResult? Function(DateTimeRange range, int clubId)? downloadRating,
    TResult? Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
  }) {
    return downloadRating?.call(range, clubId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(DateTimeRange range, int clubId)? downloadRating,
    TResult Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
    required TResult orElse(),
  }) {
    if (downloadRating != null) {
      return downloadRating(range, clubId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RatingEventPlayerSelected value) playerSelected,
    required TResult Function(RatingEventDownload value) downloadRating,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) {
    return downloadRating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RatingEventPlayerSelected value)? playerSelected,
    TResult? Function(RatingEventDownload value)? downloadRating,
    TResult? Function(RatingEventGameSelected value)? gameSelected,
    TResult? Function(RatingEventPageOpened value)? pageOpened,
    TResult? Function(RatingEventRangeChanged value)? rangeChanged,
  }) {
    return downloadRating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventDownload value)? downloadRating,
    TResult Function(RatingEventGameSelected value)? gameSelected,
    TResult Function(RatingEventPageOpened value)? pageOpened,
    TResult Function(RatingEventRangeChanged value)? rangeChanged,
    required TResult orElse(),
  }) {
    if (downloadRating != null) {
      return downloadRating(this);
    }
    return orElse();
  }
}

abstract class RatingEventDownload implements RatingEvent {
  const factory RatingEventDownload(
      {required final DateTimeRange range,
      required final int clubId}) = _$RatingEventDownloadImpl;

  DateTimeRange get range;
  int get clubId;
  @JsonKey(ignore: true)
  _$$RatingEventDownloadImplCopyWith<_$RatingEventDownloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RatingEventGameSelectedImplCopyWith<$Res> {
  factory _$$RatingEventGameSelectedImplCopyWith(
          _$RatingEventGameSelectedImpl value,
          $Res Function(_$RatingEventGameSelectedImpl) then) =
      __$$RatingEventGameSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int gameId, int? clubId, int? tournamentId});
}

/// @nodoc
class __$$RatingEventGameSelectedImplCopyWithImpl<$Res>
    extends _$RatingEventCopyWithImpl<$Res, _$RatingEventGameSelectedImpl>
    implements _$$RatingEventGameSelectedImplCopyWith<$Res> {
  __$$RatingEventGameSelectedImplCopyWithImpl(
      _$RatingEventGameSelectedImpl _value,
      $Res Function(_$RatingEventGameSelectedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? clubId = freezed,
    Object? tournamentId = freezed,
  }) {
    return _then(_$RatingEventGameSelectedImpl(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int,
      clubId: freezed == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as int?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$RatingEventGameSelectedImpl implements RatingEventGameSelected {
  const _$RatingEventGameSelectedImpl(
      {required this.gameId, this.clubId, this.tournamentId});

  @override
  final int gameId;
  @override
  final int? clubId;
  @override
  final int? tournamentId;

  @override
  String toString() {
    return 'RatingEvent.gameSelected(gameId: $gameId, clubId: $clubId, tournamentId: $tournamentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingEventGameSelectedImpl &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameId, clubId, tournamentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingEventGameSelectedImplCopyWith<_$RatingEventGameSelectedImpl>
      get copyWith => __$$RatingEventGameSelectedImplCopyWithImpl<
          _$RatingEventGameSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) playerSelected,
    required TResult Function(DateTimeRange range, int clubId) downloadRating,
    required TResult Function(int gameId, int? clubId, int? tournamentId)
        gameSelected,
    required TResult Function(
            DateTimeRange? range, int? clubId, int? tournamentId)
        pageOpened,
    required TResult Function(
            DateTimeRange? range,
            int? clubId,
            int? tournamentId,
            RatingTableStyle style,
            RatingSort sort,
            int gameFilter)
        rangeChanged,
  }) {
    return gameSelected(gameId, clubId, tournamentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerId)? playerSelected,
    TResult? Function(DateTimeRange range, int clubId)? downloadRating,
    TResult? Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
  }) {
    return gameSelected?.call(gameId, clubId, tournamentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(DateTimeRange range, int clubId)? downloadRating,
    TResult Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
    required TResult orElse(),
  }) {
    if (gameSelected != null) {
      return gameSelected(gameId, clubId, tournamentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RatingEventPlayerSelected value) playerSelected,
    required TResult Function(RatingEventDownload value) downloadRating,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) {
    return gameSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RatingEventPlayerSelected value)? playerSelected,
    TResult? Function(RatingEventDownload value)? downloadRating,
    TResult? Function(RatingEventGameSelected value)? gameSelected,
    TResult? Function(RatingEventPageOpened value)? pageOpened,
    TResult? Function(RatingEventRangeChanged value)? rangeChanged,
  }) {
    return gameSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventDownload value)? downloadRating,
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
  const factory RatingEventGameSelected(
      {required final int gameId,
      final int? clubId,
      final int? tournamentId}) = _$RatingEventGameSelectedImpl;

  int get gameId;
  int? get clubId;
  int? get tournamentId;
  @JsonKey(ignore: true)
  _$$RatingEventGameSelectedImplCopyWith<_$RatingEventGameSelectedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RatingEventPageOpenedImplCopyWith<$Res> {
  factory _$$RatingEventPageOpenedImplCopyWith(
          _$RatingEventPageOpenedImpl value,
          $Res Function(_$RatingEventPageOpenedImpl) then) =
      __$$RatingEventPageOpenedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTimeRange? range, int? clubId, int? tournamentId});
}

/// @nodoc
class __$$RatingEventPageOpenedImplCopyWithImpl<$Res>
    extends _$RatingEventCopyWithImpl<$Res, _$RatingEventPageOpenedImpl>
    implements _$$RatingEventPageOpenedImplCopyWith<$Res> {
  __$$RatingEventPageOpenedImplCopyWithImpl(_$RatingEventPageOpenedImpl _value,
      $Res Function(_$RatingEventPageOpenedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? range = freezed,
    Object? clubId = freezed,
    Object? tournamentId = freezed,
  }) {
    return _then(_$RatingEventPageOpenedImpl(
      range: freezed == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as DateTimeRange?,
      clubId: freezed == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as int?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$RatingEventPageOpenedImpl implements RatingEventPageOpened {
  const _$RatingEventPageOpenedImpl(
      {required this.range, required this.clubId, required this.tournamentId});

  @override
  final DateTimeRange? range;
  @override
  final int? clubId;
  @override
  final int? tournamentId;

  @override
  String toString() {
    return 'RatingEvent.pageOpened(range: $range, clubId: $clubId, tournamentId: $tournamentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingEventPageOpenedImpl &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, range, clubId, tournamentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingEventPageOpenedImplCopyWith<_$RatingEventPageOpenedImpl>
      get copyWith => __$$RatingEventPageOpenedImplCopyWithImpl<
          _$RatingEventPageOpenedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) playerSelected,
    required TResult Function(DateTimeRange range, int clubId) downloadRating,
    required TResult Function(int gameId, int? clubId, int? tournamentId)
        gameSelected,
    required TResult Function(
            DateTimeRange? range, int? clubId, int? tournamentId)
        pageOpened,
    required TResult Function(
            DateTimeRange? range,
            int? clubId,
            int? tournamentId,
            RatingTableStyle style,
            RatingSort sort,
            int gameFilter)
        rangeChanged,
  }) {
    return pageOpened(range, clubId, tournamentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerId)? playerSelected,
    TResult? Function(DateTimeRange range, int clubId)? downloadRating,
    TResult? Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
  }) {
    return pageOpened?.call(range, clubId, tournamentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(DateTimeRange range, int clubId)? downloadRating,
    TResult Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(range, clubId, tournamentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RatingEventPlayerSelected value) playerSelected,
    required TResult Function(RatingEventDownload value) downloadRating,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) {
    return pageOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RatingEventPlayerSelected value)? playerSelected,
    TResult? Function(RatingEventDownload value)? downloadRating,
    TResult? Function(RatingEventGameSelected value)? gameSelected,
    TResult? Function(RatingEventPageOpened value)? pageOpened,
    TResult? Function(RatingEventRangeChanged value)? rangeChanged,
  }) {
    return pageOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventDownload value)? downloadRating,
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
      {required final DateTimeRange? range,
      required final int? clubId,
      required final int? tournamentId}) = _$RatingEventPageOpenedImpl;

  DateTimeRange? get range;
  int? get clubId;
  int? get tournamentId;
  @JsonKey(ignore: true)
  _$$RatingEventPageOpenedImplCopyWith<_$RatingEventPageOpenedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RatingEventRangeChangedImplCopyWith<$Res> {
  factory _$$RatingEventRangeChangedImplCopyWith(
          _$RatingEventRangeChangedImpl value,
          $Res Function(_$RatingEventRangeChangedImpl) then) =
      __$$RatingEventRangeChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {DateTimeRange? range,
      int? clubId,
      int? tournamentId,
      RatingTableStyle style,
      RatingSort sort,
      int gameFilter});
}

/// @nodoc
class __$$RatingEventRangeChangedImplCopyWithImpl<$Res>
    extends _$RatingEventCopyWithImpl<$Res, _$RatingEventRangeChangedImpl>
    implements _$$RatingEventRangeChangedImplCopyWith<$Res> {
  __$$RatingEventRangeChangedImplCopyWithImpl(
      _$RatingEventRangeChangedImpl _value,
      $Res Function(_$RatingEventRangeChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? range = freezed,
    Object? clubId = freezed,
    Object? tournamentId = freezed,
    Object? style = null,
    Object? sort = null,
    Object? gameFilter = null,
  }) {
    return _then(_$RatingEventRangeChangedImpl(
      range: freezed == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as DateTimeRange?,
      clubId: freezed == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as int?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as int?,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as RatingTableStyle,
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as RatingSort,
      gameFilter: null == gameFilter
          ? _value.gameFilter
          : gameFilter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RatingEventRangeChangedImpl implements RatingEventRangeChanged {
  const _$RatingEventRangeChangedImpl(
      {required this.range,
      required this.clubId,
      required this.tournamentId,
      required this.style,
      required this.sort,
      required this.gameFilter});

  @override
  final DateTimeRange? range;
  @override
  final int? clubId;
  @override
  final int? tournamentId;
  @override
  final RatingTableStyle style;
  @override
  final RatingSort sort;
  @override
  final int gameFilter;

  @override
  String toString() {
    return 'RatingEvent.rangeChanged(range: $range, clubId: $clubId, tournamentId: $tournamentId, style: $style, sort: $sort, gameFilter: $gameFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingEventRangeChangedImpl &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.gameFilter, gameFilter) ||
                other.gameFilter == gameFilter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, range, clubId, tournamentId, style, sort, gameFilter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingEventRangeChangedImplCopyWith<_$RatingEventRangeChangedImpl>
      get copyWith => __$$RatingEventRangeChangedImplCopyWithImpl<
          _$RatingEventRangeChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int playerId) playerSelected,
    required TResult Function(DateTimeRange range, int clubId) downloadRating,
    required TResult Function(int gameId, int? clubId, int? tournamentId)
        gameSelected,
    required TResult Function(
            DateTimeRange? range, int? clubId, int? tournamentId)
        pageOpened,
    required TResult Function(
            DateTimeRange? range,
            int? clubId,
            int? tournamentId,
            RatingTableStyle style,
            RatingSort sort,
            int gameFilter)
        rangeChanged,
  }) {
    return rangeChanged(range, clubId, tournamentId, style, sort, gameFilter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int playerId)? playerSelected,
    TResult? Function(DateTimeRange range, int clubId)? downloadRating,
    TResult? Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult? Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
  }) {
    return rangeChanged?.call(
        range, clubId, tournamentId, style, sort, gameFilter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int playerId)? playerSelected,
    TResult Function(DateTimeRange range, int clubId)? downloadRating,
    TResult Function(int gameId, int? clubId, int? tournamentId)? gameSelected,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId)?
        pageOpened,
    TResult Function(DateTimeRange? range, int? clubId, int? tournamentId,
            RatingTableStyle style, RatingSort sort, int gameFilter)?
        rangeChanged,
    required TResult orElse(),
  }) {
    if (rangeChanged != null) {
      return rangeChanged(range, clubId, tournamentId, style, sort, gameFilter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RatingEventPlayerSelected value) playerSelected,
    required TResult Function(RatingEventDownload value) downloadRating,
    required TResult Function(RatingEventGameSelected value) gameSelected,
    required TResult Function(RatingEventPageOpened value) pageOpened,
    required TResult Function(RatingEventRangeChanged value) rangeChanged,
  }) {
    return rangeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RatingEventPlayerSelected value)? playerSelected,
    TResult? Function(RatingEventDownload value)? downloadRating,
    TResult? Function(RatingEventGameSelected value)? gameSelected,
    TResult? Function(RatingEventPageOpened value)? pageOpened,
    TResult? Function(RatingEventRangeChanged value)? rangeChanged,
  }) {
    return rangeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RatingEventPlayerSelected value)? playerSelected,
    TResult Function(RatingEventDownload value)? downloadRating,
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
      {required final DateTimeRange? range,
      required final int? clubId,
      required final int? tournamentId,
      required final RatingTableStyle style,
      required final RatingSort sort,
      required final int gameFilter}) = _$RatingEventRangeChangedImpl;

  DateTimeRange? get range;
  int? get clubId;
  int? get tournamentId;
  RatingTableStyle get style;
  RatingSort get sort;
  int get gameFilter;
  @JsonKey(ignore: true)
  _$$RatingEventRangeChangedImplCopyWith<_$RatingEventRangeChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
