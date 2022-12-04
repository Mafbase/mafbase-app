// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'add_club_game_effect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddClubGameEffect {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            ClubGameResult_GameWin win,
            ClubGameResult_BestMove bestMove,
            String referee,
            int died,
            DateTime date)
        setValues,
    required TResult Function(int index, PlayerModel player) setPlayer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            ClubGameResult_GameWin win,
            ClubGameResult_BestMove bestMove,
            String referee,
            int died,
            DateTime date)?
        setValues,
    TResult Function(int index, PlayerModel player)? setPlayer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            ClubGameResult_GameWin win,
            ClubGameResult_BestMove bestMove,
            String referee,
            int died,
            DateTime date)?
        setValues,
    TResult Function(int index, PlayerModel player)? setPlayer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddClubGameEffectSetValues value) setValues,
    required TResult Function(AddClubGameEffectSetPlayer value) setPlayer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AddClubGameEffectSetValues value)? setValues,
    TResult Function(AddClubGameEffectSetPlayer value)? setPlayer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddClubGameEffectSetValues value)? setValues,
    TResult Function(AddClubGameEffectSetPlayer value)? setPlayer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddClubGameEffectCopyWith<$Res> {
  factory $AddClubGameEffectCopyWith(
          AddClubGameEffect value, $Res Function(AddClubGameEffect) then) =
      _$AddClubGameEffectCopyWithImpl<$Res>;
}

/// @nodoc
class _$AddClubGameEffectCopyWithImpl<$Res>
    implements $AddClubGameEffectCopyWith<$Res> {
  _$AddClubGameEffectCopyWithImpl(this._value, this._then);

  final AddClubGameEffect _value;
  // ignore: unused_field
  final $Res Function(AddClubGameEffect) _then;
}

/// @nodoc
abstract class _$$AddClubGameEffectSetValuesCopyWith<$Res> {
  factory _$$AddClubGameEffectSetValuesCopyWith(
          _$AddClubGameEffectSetValues value,
          $Res Function(_$AddClubGameEffectSetValues) then) =
      __$$AddClubGameEffectSetValuesCopyWithImpl<$Res>;
  $Res call(
      {List<String> players,
      List<double> addScore,
      List<PlayerRole> roles,
      ClubGameResult_GameWin win,
      ClubGameResult_BestMove bestMove,
      String referee,
      int died,
      DateTime date});
}

/// @nodoc
class __$$AddClubGameEffectSetValuesCopyWithImpl<$Res>
    extends _$AddClubGameEffectCopyWithImpl<$Res>
    implements _$$AddClubGameEffectSetValuesCopyWith<$Res> {
  __$$AddClubGameEffectSetValuesCopyWithImpl(
      _$AddClubGameEffectSetValues _value,
      $Res Function(_$AddClubGameEffectSetValues) _then)
      : super(_value, (v) => _then(v as _$AddClubGameEffectSetValues));

  @override
  _$AddClubGameEffectSetValues get _value =>
      super._value as _$AddClubGameEffectSetValues;

  @override
  $Res call({
    Object? players = freezed,
    Object? addScore = freezed,
    Object? roles = freezed,
    Object? win = freezed,
    Object? bestMove = freezed,
    Object? referee = freezed,
    Object? died = freezed,
    Object? date = freezed,
  }) {
    return _then(_$AddClubGameEffectSetValues(
      players: players == freezed
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<String>,
      addScore: addScore == freezed
          ? _value._addScore
          : addScore // ignore: cast_nullable_to_non_nullable
              as List<double>,
      roles: roles == freezed
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PlayerRole>,
      win: win == freezed
          ? _value.win
          : win // ignore: cast_nullable_to_non_nullable
              as ClubGameResult_GameWin,
      bestMove: bestMove == freezed
          ? _value.bestMove
          : bestMove // ignore: cast_nullable_to_non_nullable
              as ClubGameResult_BestMove,
      referee: referee == freezed
          ? _value.referee
          : referee // ignore: cast_nullable_to_non_nullable
              as String,
      died: died == freezed
          ? _value.died
          : died // ignore: cast_nullable_to_non_nullable
              as int,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$AddClubGameEffectSetValues implements AddClubGameEffectSetValues {
  const _$AddClubGameEffectSetValues(
      {required final List<String> players,
      required final List<double> addScore,
      required final List<PlayerRole> roles,
      required this.win,
      required this.bestMove,
      required this.referee,
      required this.died,
      required this.date})
      : _players = players,
        _addScore = addScore,
        _roles = roles;

  final List<String> _players;
  @override
  List<String> get players {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<double> _addScore;
  @override
  List<double> get addScore {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addScore);
  }

  final List<PlayerRole> _roles;
  @override
  List<PlayerRole> get roles {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final ClubGameResult_GameWin win;
  @override
  final ClubGameResult_BestMove bestMove;
  @override
  final String referee;
  @override
  final int died;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'AddClubGameEffect.setValues(players: $players, addScore: $addScore, roles: $roles, win: $win, bestMove: $bestMove, referee: $referee, died: $died, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEffectSetValues &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality().equals(other._addScore, _addScore) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            const DeepCollectionEquality().equals(other.win, win) &&
            const DeepCollectionEquality().equals(other.bestMove, bestMove) &&
            const DeepCollectionEquality().equals(other.referee, referee) &&
            const DeepCollectionEquality().equals(other.died, died) &&
            const DeepCollectionEquality().equals(other.date, date));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_players),
      const DeepCollectionEquality().hash(_addScore),
      const DeepCollectionEquality().hash(_roles),
      const DeepCollectionEquality().hash(win),
      const DeepCollectionEquality().hash(bestMove),
      const DeepCollectionEquality().hash(referee),
      const DeepCollectionEquality().hash(died),
      const DeepCollectionEquality().hash(date));

  @JsonKey(ignore: true)
  @override
  _$$AddClubGameEffectSetValuesCopyWith<_$AddClubGameEffectSetValues>
      get copyWith => __$$AddClubGameEffectSetValuesCopyWithImpl<
          _$AddClubGameEffectSetValues>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            ClubGameResult_GameWin win,
            ClubGameResult_BestMove bestMove,
            String referee,
            int died,
            DateTime date)
        setValues,
    required TResult Function(int index, PlayerModel player) setPlayer,
  }) {
    return setValues(
        players, addScore, roles, win, bestMove, referee, died, date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            ClubGameResult_GameWin win,
            ClubGameResult_BestMove bestMove,
            String referee,
            int died,
            DateTime date)?
        setValues,
    TResult Function(int index, PlayerModel player)? setPlayer,
  }) {
    return setValues?.call(
        players, addScore, roles, win, bestMove, referee, died, date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            ClubGameResult_GameWin win,
            ClubGameResult_BestMove bestMove,
            String referee,
            int died,
            DateTime date)?
        setValues,
    TResult Function(int index, PlayerModel player)? setPlayer,
    required TResult orElse(),
  }) {
    if (setValues != null) {
      return setValues(
          players, addScore, roles, win, bestMove, referee, died, date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddClubGameEffectSetValues value) setValues,
    required TResult Function(AddClubGameEffectSetPlayer value) setPlayer,
  }) {
    return setValues(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AddClubGameEffectSetValues value)? setValues,
    TResult Function(AddClubGameEffectSetPlayer value)? setPlayer,
  }) {
    return setValues?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddClubGameEffectSetValues value)? setValues,
    TResult Function(AddClubGameEffectSetPlayer value)? setPlayer,
    required TResult orElse(),
  }) {
    if (setValues != null) {
      return setValues(this);
    }
    return orElse();
  }
}

abstract class AddClubGameEffectSetValues implements AddClubGameEffect {
  const factory AddClubGameEffectSetValues(
      {required final List<String> players,
      required final List<double> addScore,
      required final List<PlayerRole> roles,
      required final ClubGameResult_GameWin win,
      required final ClubGameResult_BestMove bestMove,
      required final String referee,
      required final int died,
      required final DateTime date}) = _$AddClubGameEffectSetValues;

  List<String> get players;
  List<double> get addScore;
  List<PlayerRole> get roles;
  ClubGameResult_GameWin get win;
  ClubGameResult_BestMove get bestMove;
  String get referee;
  int get died;
  DateTime get date;
  @JsonKey(ignore: true)
  _$$AddClubGameEffectSetValuesCopyWith<_$AddClubGameEffectSetValues>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddClubGameEffectSetPlayerCopyWith<$Res> {
  factory _$$AddClubGameEffectSetPlayerCopyWith(
          _$AddClubGameEffectSetPlayer value,
          $Res Function(_$AddClubGameEffectSetPlayer) then) =
      __$$AddClubGameEffectSetPlayerCopyWithImpl<$Res>;
  $Res call({int index, PlayerModel player});

  $PlayerModelCopyWith<$Res> get player;
}

/// @nodoc
class __$$AddClubGameEffectSetPlayerCopyWithImpl<$Res>
    extends _$AddClubGameEffectCopyWithImpl<$Res>
    implements _$$AddClubGameEffectSetPlayerCopyWith<$Res> {
  __$$AddClubGameEffectSetPlayerCopyWithImpl(
      _$AddClubGameEffectSetPlayer _value,
      $Res Function(_$AddClubGameEffectSetPlayer) _then)
      : super(_value, (v) => _then(v as _$AddClubGameEffectSetPlayer));

  @override
  _$AddClubGameEffectSetPlayer get _value =>
      super._value as _$AddClubGameEffectSetPlayer;

  @override
  $Res call({
    Object? index = freezed,
    Object? player = freezed,
  }) {
    return _then(_$AddClubGameEffectSetPlayer(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      player: player == freezed
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PlayerModel,
    ));
  }

  @override
  $PlayerModelCopyWith<$Res> get player {
    return $PlayerModelCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value));
    });
  }
}

/// @nodoc

class _$AddClubGameEffectSetPlayer implements AddClubGameEffectSetPlayer {
  const _$AddClubGameEffectSetPlayer(
      {required this.index, required this.player});

  @override
  final int index;
  @override
  final PlayerModel player;

  @override
  String toString() {
    return 'AddClubGameEffect.setPlayer(index: $index, player: $player)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEffectSetPlayer &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.player, player));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(player));

  @JsonKey(ignore: true)
  @override
  _$$AddClubGameEffectSetPlayerCopyWith<_$AddClubGameEffectSetPlayer>
      get copyWith => __$$AddClubGameEffectSetPlayerCopyWithImpl<
          _$AddClubGameEffectSetPlayer>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            ClubGameResult_GameWin win,
            ClubGameResult_BestMove bestMove,
            String referee,
            int died,
            DateTime date)
        setValues,
    required TResult Function(int index, PlayerModel player) setPlayer,
  }) {
    return setPlayer(index, player);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            ClubGameResult_GameWin win,
            ClubGameResult_BestMove bestMove,
            String referee,
            int died,
            DateTime date)?
        setValues,
    TResult Function(int index, PlayerModel player)? setPlayer,
  }) {
    return setPlayer?.call(index, player);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            ClubGameResult_GameWin win,
            ClubGameResult_BestMove bestMove,
            String referee,
            int died,
            DateTime date)?
        setValues,
    TResult Function(int index, PlayerModel player)? setPlayer,
    required TResult orElse(),
  }) {
    if (setPlayer != null) {
      return setPlayer(index, player);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddClubGameEffectSetValues value) setValues,
    required TResult Function(AddClubGameEffectSetPlayer value) setPlayer,
  }) {
    return setPlayer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AddClubGameEffectSetValues value)? setValues,
    TResult Function(AddClubGameEffectSetPlayer value)? setPlayer,
  }) {
    return setPlayer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddClubGameEffectSetValues value)? setValues,
    TResult Function(AddClubGameEffectSetPlayer value)? setPlayer,
    required TResult orElse(),
  }) {
    if (setPlayer != null) {
      return setPlayer(this);
    }
    return orElse();
  }
}

abstract class AddClubGameEffectSetPlayer implements AddClubGameEffect {
  const factory AddClubGameEffectSetPlayer(
      {required final int index,
      required final PlayerModel player}) = _$AddClubGameEffectSetPlayer;

  int get index;
  PlayerModel get player;
  @JsonKey(ignore: true)
  _$$AddClubGameEffectSetPlayerCopyWith<_$AddClubGameEffectSetPlayer>
      get copyWith => throw _privateConstructorUsedError;
}
