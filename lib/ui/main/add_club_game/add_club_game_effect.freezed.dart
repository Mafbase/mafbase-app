// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
            GameWin win,
            BestMove bestMove,
            String referee,
            int died,
            DateTime date,
            CiSchemeModel? ciModel)
        setValues,
    required TResult Function(int index, PlayerModel player) setPlayer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            GameWin win,
            BestMove bestMove,
            String referee,
            int died,
            DateTime date,
            CiSchemeModel? ciModel)?
        setValues,
    TResult? Function(int index, PlayerModel player)? setPlayer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            GameWin win,
            BestMove bestMove,
            String referee,
            int died,
            DateTime date,
            CiSchemeModel? ciModel)?
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
    TResult? Function(AddClubGameEffectSetValues value)? setValues,
    TResult? Function(AddClubGameEffectSetPlayer value)? setPlayer,
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
      _$AddClubGameEffectCopyWithImpl<$Res, AddClubGameEffect>;
}

/// @nodoc
class _$AddClubGameEffectCopyWithImpl<$Res, $Val extends AddClubGameEffect>
    implements $AddClubGameEffectCopyWith<$Res> {
  _$AddClubGameEffectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AddClubGameEffectSetValuesCopyWith<$Res> {
  factory _$$AddClubGameEffectSetValuesCopyWith(
          _$AddClubGameEffectSetValues value,
          $Res Function(_$AddClubGameEffectSetValues) then) =
      __$$AddClubGameEffectSetValuesCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<String> players,
      List<double> addScore,
      List<PlayerRole> roles,
      GameWin win,
      BestMove bestMove,
      String referee,
      int died,
      DateTime date,
      CiSchemeModel? ciModel});

  $CiSchemeModelCopyWith<$Res>? get ciModel;
}

/// @nodoc
class __$$AddClubGameEffectSetValuesCopyWithImpl<$Res>
    extends _$AddClubGameEffectCopyWithImpl<$Res, _$AddClubGameEffectSetValues>
    implements _$$AddClubGameEffectSetValuesCopyWith<$Res> {
  __$$AddClubGameEffectSetValuesCopyWithImpl(
      _$AddClubGameEffectSetValues _value,
      $Res Function(_$AddClubGameEffectSetValues) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? players = null,
    Object? addScore = null,
    Object? roles = null,
    Object? win = null,
    Object? bestMove = null,
    Object? referee = null,
    Object? died = null,
    Object? date = null,
    Object? ciModel = freezed,
  }) {
    return _then(_$AddClubGameEffectSetValues(
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<String>,
      addScore: null == addScore
          ? _value._addScore
          : addScore // ignore: cast_nullable_to_non_nullable
              as List<double>,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PlayerRole>,
      win: null == win
          ? _value.win
          : win // ignore: cast_nullable_to_non_nullable
              as GameWin,
      bestMove: null == bestMove
          ? _value.bestMove
          : bestMove // ignore: cast_nullable_to_non_nullable
              as BestMove,
      referee: null == referee
          ? _value.referee
          : referee // ignore: cast_nullable_to_non_nullable
              as String,
      died: null == died
          ? _value.died
          : died // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ciModel: freezed == ciModel
          ? _value.ciModel
          : ciModel // ignore: cast_nullable_to_non_nullable
              as CiSchemeModel?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $CiSchemeModelCopyWith<$Res>? get ciModel {
    if (_value.ciModel == null) {
      return null;
    }

    return $CiSchemeModelCopyWith<$Res>(_value.ciModel!, (value) {
      return _then(_value.copyWith(ciModel: value));
    });
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
      required this.date,
      this.ciModel})
      : _players = players,
        _addScore = addScore,
        _roles = roles;

  final List<String> _players;
  @override
  List<String> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<double> _addScore;
  @override
  List<double> get addScore {
    if (_addScore is EqualUnmodifiableListView) return _addScore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addScore);
  }

  final List<PlayerRole> _roles;
  @override
  List<PlayerRole> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final GameWin win;
  @override
  final BestMove bestMove;
  @override
  final String referee;
  @override
  final int died;
  @override
  final DateTime date;
  @override
  final CiSchemeModel? ciModel;

  @override
  String toString() {
    return 'AddClubGameEffect.setValues(players: $players, addScore: $addScore, roles: $roles, win: $win, bestMove: $bestMove, referee: $referee, died: $died, date: $date, ciModel: $ciModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEffectSetValues &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality().equals(other._addScore, _addScore) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.win, win) || other.win == win) &&
            (identical(other.bestMove, bestMove) ||
                other.bestMove == bestMove) &&
            (identical(other.referee, referee) || other.referee == referee) &&
            (identical(other.died, died) || other.died == died) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.ciModel, ciModel) || other.ciModel == ciModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_players),
      const DeepCollectionEquality().hash(_addScore),
      const DeepCollectionEquality().hash(_roles),
      win,
      bestMove,
      referee,
      died,
      date,
      ciModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
            GameWin win,
            BestMove bestMove,
            String referee,
            int died,
            DateTime date,
            CiSchemeModel? ciModel)
        setValues,
    required TResult Function(int index, PlayerModel player) setPlayer,
  }) {
    return setValues(
        players, addScore, roles, win, bestMove, referee, died, date, ciModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            GameWin win,
            BestMove bestMove,
            String referee,
            int died,
            DateTime date,
            CiSchemeModel? ciModel)?
        setValues,
    TResult? Function(int index, PlayerModel player)? setPlayer,
  }) {
    return setValues?.call(
        players, addScore, roles, win, bestMove, referee, died, date, ciModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            GameWin win,
            BestMove bestMove,
            String referee,
            int died,
            DateTime date,
            CiSchemeModel? ciModel)?
        setValues,
    TResult Function(int index, PlayerModel player)? setPlayer,
    required TResult orElse(),
  }) {
    if (setValues != null) {
      return setValues(players, addScore, roles, win, bestMove, referee, died,
          date, ciModel);
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
    TResult? Function(AddClubGameEffectSetValues value)? setValues,
    TResult? Function(AddClubGameEffectSetPlayer value)? setPlayer,
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
      required final GameWin win,
      required final BestMove bestMove,
      required final String referee,
      required final int died,
      required final DateTime date,
      final CiSchemeModel? ciModel}) = _$AddClubGameEffectSetValues;

  List<String> get players;
  List<double> get addScore;
  List<PlayerRole> get roles;
  GameWin get win;
  BestMove get bestMove;
  String get referee;
  int get died;
  DateTime get date;
  CiSchemeModel? get ciModel;
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
  @useResult
  $Res call({int index, PlayerModel player});

  $PlayerModelCopyWith<$Res> get player;
}

/// @nodoc
class __$$AddClubGameEffectSetPlayerCopyWithImpl<$Res>
    extends _$AddClubGameEffectCopyWithImpl<$Res, _$AddClubGameEffectSetPlayer>
    implements _$$AddClubGameEffectSetPlayerCopyWith<$Res> {
  __$$AddClubGameEffectSetPlayerCopyWithImpl(
      _$AddClubGameEffectSetPlayer _value,
      $Res Function(_$AddClubGameEffectSetPlayer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? player = null,
  }) {
    return _then(_$AddClubGameEffectSetPlayer(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PlayerModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
            (identical(other.index, index) || other.index == index) &&
            (identical(other.player, player) || other.player == player));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, player);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
            GameWin win,
            BestMove bestMove,
            String referee,
            int died,
            DateTime date,
            CiSchemeModel? ciModel)
        setValues,
    required TResult Function(int index, PlayerModel player) setPlayer,
  }) {
    return setPlayer(index, player);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> players,
            List<double> addScore,
            List<PlayerRole> roles,
            GameWin win,
            BestMove bestMove,
            String referee,
            int died,
            DateTime date,
            CiSchemeModel? ciModel)?
        setValues,
    TResult? Function(int index, PlayerModel player)? setPlayer,
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
            GameWin win,
            BestMove bestMove,
            String referee,
            int died,
            DateTime date,
            CiSchemeModel? ciModel)?
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
    TResult? Function(AddClubGameEffectSetValues value)? setValues,
    TResult? Function(AddClubGameEffectSetPlayer value)? setPlayer,
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
