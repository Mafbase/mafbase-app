// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameResultModel {
  int get gameId => throw _privateConstructorUsedError;
  List<PlayerRole>? get roles => throw _privateConstructorUsedError;
  List<String> get nicknames => throw _privateConstructorUsedError;
  String get referee => throw _privateConstructorUsedError;
  GameWin? get gameWin => throw _privateConstructorUsedError;
  List<double>? get scores => throw _privateConstructorUsedError;
  List<PlayerResultStatus?>? get statuses => throw _privateConstructorUsedError;
  int get table => throw _privateConstructorUsedError;
  int get game => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameResultModelCopyWith<GameResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameResultModelCopyWith<$Res> {
  factory $GameResultModelCopyWith(
          GameResultModel value, $Res Function(GameResultModel) then) =
      _$GameResultModelCopyWithImpl<$Res, GameResultModel>;
  @useResult
  $Res call(
      {int gameId,
      List<PlayerRole>? roles,
      List<String> nicknames,
      String referee,
      GameWin? gameWin,
      List<double>? scores,
      List<PlayerResultStatus?>? statuses,
      int table,
      int game});
}

/// @nodoc
class _$GameResultModelCopyWithImpl<$Res, $Val extends GameResultModel>
    implements $GameResultModelCopyWith<$Res> {
  _$GameResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? roles = freezed,
    Object? nicknames = null,
    Object? referee = null,
    Object? gameWin = freezed,
    Object? scores = freezed,
    Object? statuses = freezed,
    Object? table = null,
    Object? game = null,
  }) {
    return _then(_value.copyWith(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int,
      roles: freezed == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PlayerRole>?,
      nicknames: null == nicknames
          ? _value.nicknames
          : nicknames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      referee: null == referee
          ? _value.referee
          : referee // ignore: cast_nullable_to_non_nullable
              as String,
      gameWin: freezed == gameWin
          ? _value.gameWin
          : gameWin // ignore: cast_nullable_to_non_nullable
              as GameWin?,
      scores: freezed == scores
          ? _value.scores
          : scores // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      statuses: freezed == statuses
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as List<PlayerResultStatus?>?,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as int,
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameResultModelCopyWith<$Res>
    implements $GameResultModelCopyWith<$Res> {
  factory _$$_GameResultModelCopyWith(
          _$_GameResultModel value, $Res Function(_$_GameResultModel) then) =
      __$$_GameResultModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int gameId,
      List<PlayerRole>? roles,
      List<String> nicknames,
      String referee,
      GameWin? gameWin,
      List<double>? scores,
      List<PlayerResultStatus?>? statuses,
      int table,
      int game});
}

/// @nodoc
class __$$_GameResultModelCopyWithImpl<$Res>
    extends _$GameResultModelCopyWithImpl<$Res, _$_GameResultModel>
    implements _$$_GameResultModelCopyWith<$Res> {
  __$$_GameResultModelCopyWithImpl(
      _$_GameResultModel _value, $Res Function(_$_GameResultModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? roles = freezed,
    Object? nicknames = null,
    Object? referee = null,
    Object? gameWin = freezed,
    Object? scores = freezed,
    Object? statuses = freezed,
    Object? table = null,
    Object? game = null,
  }) {
    return _then(_$_GameResultModel(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int,
      roles: freezed == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PlayerRole>?,
      nicknames: null == nicknames
          ? _value._nicknames
          : nicknames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      referee: null == referee
          ? _value.referee
          : referee // ignore: cast_nullable_to_non_nullable
              as String,
      gameWin: freezed == gameWin
          ? _value.gameWin
          : gameWin // ignore: cast_nullable_to_non_nullable
              as GameWin?,
      scores: freezed == scores
          ? _value._scores
          : scores // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      statuses: freezed == statuses
          ? _value._statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as List<PlayerResultStatus?>?,
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as int,
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_GameResultModel implements _GameResultModel {
  const _$_GameResultModel(
      {required this.gameId,
      final List<PlayerRole>? roles,
      required final List<String> nicknames,
      required this.referee,
      this.gameWin,
      final List<double>? scores,
      final List<PlayerResultStatus?>? statuses,
      required this.table,
      required this.game})
      : _roles = roles,
        _nicknames = nicknames,
        _scores = scores,
        _statuses = statuses;

  @override
  final int gameId;
  final List<PlayerRole>? _roles;
  @override
  List<PlayerRole>? get roles {
    final value = _roles;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _nicknames;
  @override
  List<String> get nicknames {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nicknames);
  }

  @override
  final String referee;
  @override
  final GameWin? gameWin;
  final List<double>? _scores;
  @override
  List<double>? get scores {
    final value = _scores;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PlayerResultStatus?>? _statuses;
  @override
  List<PlayerResultStatus?>? get statuses {
    final value = _statuses;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int table;
  @override
  final int game;

  @override
  String toString() {
    return 'GameResultModel(gameId: $gameId, roles: $roles, nicknames: $nicknames, referee: $referee, gameWin: $gameWin, scores: $scores, statuses: $statuses, table: $table, game: $game)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameResultModel &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            const DeepCollectionEquality()
                .equals(other._nicknames, _nicknames) &&
            (identical(other.referee, referee) || other.referee == referee) &&
            (identical(other.gameWin, gameWin) || other.gameWin == gameWin) &&
            const DeepCollectionEquality().equals(other._scores, _scores) &&
            const DeepCollectionEquality().equals(other._statuses, _statuses) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.game, game) || other.game == game));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      gameId,
      const DeepCollectionEquality().hash(_roles),
      const DeepCollectionEquality().hash(_nicknames),
      referee,
      gameWin,
      const DeepCollectionEquality().hash(_scores),
      const DeepCollectionEquality().hash(_statuses),
      table,
      game);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameResultModelCopyWith<_$_GameResultModel> get copyWith =>
      __$$_GameResultModelCopyWithImpl<_$_GameResultModel>(this, _$identity);
}

abstract class _GameResultModel implements GameResultModel {
  const factory _GameResultModel(
      {required final int gameId,
      final List<PlayerRole>? roles,
      required final List<String> nicknames,
      required final String referee,
      final GameWin? gameWin,
      final List<double>? scores,
      final List<PlayerResultStatus?>? statuses,
      required final int table,
      required final int game}) = _$_GameResultModel;

  @override
  int get gameId;
  @override
  List<PlayerRole>? get roles;
  @override
  List<String> get nicknames;
  @override
  String get referee;
  @override
  GameWin? get gameWin;
  @override
  List<double>? get scores;
  @override
  List<PlayerResultStatus?>? get statuses;
  @override
  int get table;
  @override
  int get game;
  @override
  @JsonKey(ignore: true)
  _$$_GameResultModelCopyWith<_$_GameResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}
