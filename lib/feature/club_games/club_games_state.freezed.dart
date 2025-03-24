// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_games_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClubGamesState {
  List<GameResultModel> get games => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  /// Create a copy of ClubGamesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubGamesStateCopyWith<ClubGamesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubGamesStateCopyWith<$Res> {
  factory $ClubGamesStateCopyWith(
          ClubGamesState value, $Res Function(ClubGamesState) then) =
      _$ClubGamesStateCopyWithImpl<$Res, ClubGamesState>;
  @useResult
  $Res call({List<GameResultModel> games, bool loading});
}

/// @nodoc
class _$ClubGamesStateCopyWithImpl<$Res, $Val extends ClubGamesState>
    implements $ClubGamesStateCopyWith<$Res> {
  _$ClubGamesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubGamesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? games = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as List<GameResultModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubGamesStateImplCopyWith<$Res>
    implements $ClubGamesStateCopyWith<$Res> {
  factory _$$ClubGamesStateImplCopyWith(_$ClubGamesStateImpl value,
          $Res Function(_$ClubGamesStateImpl) then) =
      __$$ClubGamesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GameResultModel> games, bool loading});
}

/// @nodoc
class __$$ClubGamesStateImplCopyWithImpl<$Res>
    extends _$ClubGamesStateCopyWithImpl<$Res, _$ClubGamesStateImpl>
    implements _$$ClubGamesStateImplCopyWith<$Res> {
  __$$ClubGamesStateImplCopyWithImpl(
      _$ClubGamesStateImpl _value, $Res Function(_$ClubGamesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClubGamesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? games = null,
    Object? loading = null,
  }) {
    return _then(_$ClubGamesStateImpl(
      games: null == games
          ? _value._games
          : games // ignore: cast_nullable_to_non_nullable
              as List<GameResultModel>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ClubGamesStateImpl implements _ClubGamesState {
  const _$ClubGamesStateImpl(
      {final List<GameResultModel> games = const [], this.loading = true})
      : _games = games;

  final List<GameResultModel> _games;
  @override
  @JsonKey()
  List<GameResultModel> get games {
    if (_games is EqualUnmodifiableListView) return _games;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_games);
  }

  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'ClubGamesState(games: $games, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubGamesStateImpl &&
            const DeepCollectionEquality().equals(other._games, _games) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_games), loading);

  /// Create a copy of ClubGamesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubGamesStateImplCopyWith<_$ClubGamesStateImpl> get copyWith =>
      __$$ClubGamesStateImplCopyWithImpl<_$ClubGamesStateImpl>(
          this, _$identity);
}

abstract class _ClubGamesState implements ClubGamesState {
  const factory _ClubGamesState(
      {final List<GameResultModel> games,
      final bool loading}) = _$ClubGamesStateImpl;

  @override
  List<GameResultModel> get games;
  @override
  bool get loading;

  /// Create a copy of ClubGamesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubGamesStateImplCopyWith<_$ClubGamesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
