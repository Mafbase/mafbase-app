// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_games_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClubGamesEvent {
  int get clubId => throw _privateConstructorUsedError;
  DateTimeRange get range => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int clubId, DateTimeRange range) init,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int clubId, DateTimeRange range)? init,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int clubId, DateTimeRange range)? init,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClubGamesEventInit value) init,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClubGamesEventInit value)? init,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClubGamesEventInit value)? init,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ClubGamesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubGamesEventCopyWith<ClubGamesEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubGamesEventCopyWith<$Res> {
  factory $ClubGamesEventCopyWith(
          ClubGamesEvent value, $Res Function(ClubGamesEvent) then) =
      _$ClubGamesEventCopyWithImpl<$Res, ClubGamesEvent>;
  @useResult
  $Res call({int clubId, DateTimeRange range});
}

/// @nodoc
class _$ClubGamesEventCopyWithImpl<$Res, $Val extends ClubGamesEvent>
    implements $ClubGamesEventCopyWith<$Res> {
  _$ClubGamesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubGamesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubId = null,
    Object? range = null,
  }) {
    return _then(_value.copyWith(
      clubId: null == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as int,
      range: null == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as DateTimeRange,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubGamesEventInitImplCopyWith<$Res>
    implements $ClubGamesEventCopyWith<$Res> {
  factory _$$ClubGamesEventInitImplCopyWith(_$ClubGamesEventInitImpl value,
          $Res Function(_$ClubGamesEventInitImpl) then) =
      __$$ClubGamesEventInitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int clubId, DateTimeRange range});
}

/// @nodoc
class __$$ClubGamesEventInitImplCopyWithImpl<$Res>
    extends _$ClubGamesEventCopyWithImpl<$Res, _$ClubGamesEventInitImpl>
    implements _$$ClubGamesEventInitImplCopyWith<$Res> {
  __$$ClubGamesEventInitImplCopyWithImpl(_$ClubGamesEventInitImpl _value,
      $Res Function(_$ClubGamesEventInitImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClubGamesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubId = null,
    Object? range = null,
  }) {
    return _then(_$ClubGamesEventInitImpl(
      clubId: null == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as int,
      range: null == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as DateTimeRange,
    ));
  }
}

/// @nodoc

class _$ClubGamesEventInitImpl implements ClubGamesEventInit {
  const _$ClubGamesEventInitImpl({required this.clubId, required this.range});

  @override
  final int clubId;
  @override
  final DateTimeRange range;

  @override
  String toString() {
    return 'ClubGamesEvent.init(clubId: $clubId, range: $range)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubGamesEventInitImpl &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.range, range) || other.range == range));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clubId, range);

  /// Create a copy of ClubGamesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubGamesEventInitImplCopyWith<_$ClubGamesEventInitImpl> get copyWith =>
      __$$ClubGamesEventInitImplCopyWithImpl<_$ClubGamesEventInitImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int clubId, DateTimeRange range) init,
  }) {
    return init(clubId, range);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int clubId, DateTimeRange range)? init,
  }) {
    return init?.call(clubId, range);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int clubId, DateTimeRange range)? init,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(clubId, range);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClubGamesEventInit value) init,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClubGamesEventInit value)? init,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClubGamesEventInit value)? init,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class ClubGamesEventInit implements ClubGamesEvent {
  const factory ClubGamesEventInit(
      {required final int clubId,
      required final DateTimeRange range}) = _$ClubGamesEventInitImpl;

  @override
  int get clubId;
  @override
  DateTimeRange get range;

  /// Create a copy of ClubGamesEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubGamesEventInitImplCopyWith<_$ClubGamesEventInitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
