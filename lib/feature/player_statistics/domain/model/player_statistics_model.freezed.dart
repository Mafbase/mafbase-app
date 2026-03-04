// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_statistics_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayerStatisticsModel {
  int get playerId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  PlayerRoleStatsModel get overall => throw _privateConstructorUsedError;
  PlayerRoleStatsModel get citizen => throw _privateConstructorUsedError;
  PlayerRoleStatsModel get mafia => throw _privateConstructorUsedError;
  PlayerRoleStatsModel get don => throw _privateConstructorUsedError;
  PlayerRoleStatsModel get sheriff => throw _privateConstructorUsedError;
  List<PlayerPairStatModel> get sameCityTop =>
      throw _privateConstructorUsedError;
  List<PlayerPairStatModel> get sameMafiaTop =>
      throw _privateConstructorUsedError;
  List<PlayerPairStatModel> get diffTeamTop =>
      throw _privateConstructorUsedError;

  /// Create a copy of PlayerStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerStatisticsModelCopyWith<PlayerStatisticsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStatisticsModelCopyWith<$Res> {
  factory $PlayerStatisticsModelCopyWith(PlayerStatisticsModel value,
          $Res Function(PlayerStatisticsModel) then) =
      _$PlayerStatisticsModelCopyWithImpl<$Res, PlayerStatisticsModel>;
  @useResult
  $Res call(
      {int playerId,
      String nickname,
      PlayerRoleStatsModel overall,
      PlayerRoleStatsModel citizen,
      PlayerRoleStatsModel mafia,
      PlayerRoleStatsModel don,
      PlayerRoleStatsModel sheriff,
      List<PlayerPairStatModel> sameCityTop,
      List<PlayerPairStatModel> sameMafiaTop,
      List<PlayerPairStatModel> diffTeamTop});

  $PlayerRoleStatsModelCopyWith<$Res> get overall;
  $PlayerRoleStatsModelCopyWith<$Res> get citizen;
  $PlayerRoleStatsModelCopyWith<$Res> get mafia;
  $PlayerRoleStatsModelCopyWith<$Res> get don;
  $PlayerRoleStatsModelCopyWith<$Res> get sheriff;
}

/// @nodoc
class _$PlayerStatisticsModelCopyWithImpl<$Res,
        $Val extends PlayerStatisticsModel>
    implements $PlayerStatisticsModelCopyWith<$Res> {
  _$PlayerStatisticsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? nickname = null,
    Object? overall = null,
    Object? citizen = null,
    Object? mafia = null,
    Object? don = null,
    Object? sheriff = null,
    Object? sameCityTop = null,
    Object? sameMafiaTop = null,
    Object? diffTeamTop = null,
  }) {
    return _then(_value.copyWith(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      overall: null == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as PlayerRoleStatsModel,
      citizen: null == citizen
          ? _value.citizen
          : citizen // ignore: cast_nullable_to_non_nullable
              as PlayerRoleStatsModel,
      mafia: null == mafia
          ? _value.mafia
          : mafia // ignore: cast_nullable_to_non_nullable
              as PlayerRoleStatsModel,
      don: null == don
          ? _value.don
          : don // ignore: cast_nullable_to_non_nullable
              as PlayerRoleStatsModel,
      sheriff: null == sheriff
          ? _value.sheriff
          : sheriff // ignore: cast_nullable_to_non_nullable
              as PlayerRoleStatsModel,
      sameCityTop: null == sameCityTop
          ? _value.sameCityTop
          : sameCityTop // ignore: cast_nullable_to_non_nullable
              as List<PlayerPairStatModel>,
      sameMafiaTop: null == sameMafiaTop
          ? _value.sameMafiaTop
          : sameMafiaTop // ignore: cast_nullable_to_non_nullable
              as List<PlayerPairStatModel>,
      diffTeamTop: null == diffTeamTop
          ? _value.diffTeamTop
          : diffTeamTop // ignore: cast_nullable_to_non_nullable
              as List<PlayerPairStatModel>,
    ) as $Val);
  }

  /// Create a copy of PlayerStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerRoleStatsModelCopyWith<$Res> get overall {
    return $PlayerRoleStatsModelCopyWith<$Res>(_value.overall, (value) {
      return _then(_value.copyWith(overall: value) as $Val);
    });
  }

  /// Create a copy of PlayerStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerRoleStatsModelCopyWith<$Res> get citizen {
    return $PlayerRoleStatsModelCopyWith<$Res>(_value.citizen, (value) {
      return _then(_value.copyWith(citizen: value) as $Val);
    });
  }

  /// Create a copy of PlayerStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerRoleStatsModelCopyWith<$Res> get mafia {
    return $PlayerRoleStatsModelCopyWith<$Res>(_value.mafia, (value) {
      return _then(_value.copyWith(mafia: value) as $Val);
    });
  }

  /// Create a copy of PlayerStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerRoleStatsModelCopyWith<$Res> get don {
    return $PlayerRoleStatsModelCopyWith<$Res>(_value.don, (value) {
      return _then(_value.copyWith(don: value) as $Val);
    });
  }

  /// Create a copy of PlayerStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerRoleStatsModelCopyWith<$Res> get sheriff {
    return $PlayerRoleStatsModelCopyWith<$Res>(_value.sheriff, (value) {
      return _then(_value.copyWith(sheriff: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerStatisticsModelImplCopyWith<$Res>
    implements $PlayerStatisticsModelCopyWith<$Res> {
  factory _$$PlayerStatisticsModelImplCopyWith(
          _$PlayerStatisticsModelImpl value,
          $Res Function(_$PlayerStatisticsModelImpl) then) =
      __$$PlayerStatisticsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int playerId,
      String nickname,
      PlayerRoleStatsModel overall,
      PlayerRoleStatsModel citizen,
      PlayerRoleStatsModel mafia,
      PlayerRoleStatsModel don,
      PlayerRoleStatsModel sheriff,
      List<PlayerPairStatModel> sameCityTop,
      List<PlayerPairStatModel> sameMafiaTop,
      List<PlayerPairStatModel> diffTeamTop});

  @override
  $PlayerRoleStatsModelCopyWith<$Res> get overall;
  @override
  $PlayerRoleStatsModelCopyWith<$Res> get citizen;
  @override
  $PlayerRoleStatsModelCopyWith<$Res> get mafia;
  @override
  $PlayerRoleStatsModelCopyWith<$Res> get don;
  @override
  $PlayerRoleStatsModelCopyWith<$Res> get sheriff;
}

/// @nodoc
class __$$PlayerStatisticsModelImplCopyWithImpl<$Res>
    extends _$PlayerStatisticsModelCopyWithImpl<$Res,
        _$PlayerStatisticsModelImpl>
    implements _$$PlayerStatisticsModelImplCopyWith<$Res> {
  __$$PlayerStatisticsModelImplCopyWithImpl(_$PlayerStatisticsModelImpl _value,
      $Res Function(_$PlayerStatisticsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? nickname = null,
    Object? overall = null,
    Object? citizen = null,
    Object? mafia = null,
    Object? don = null,
    Object? sheriff = null,
    Object? sameCityTop = null,
    Object? sameMafiaTop = null,
    Object? diffTeamTop = null,
  }) {
    return _then(_$PlayerStatisticsModelImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      overall: null == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as PlayerRoleStatsModel,
      citizen: null == citizen
          ? _value.citizen
          : citizen // ignore: cast_nullable_to_non_nullable
              as PlayerRoleStatsModel,
      mafia: null == mafia
          ? _value.mafia
          : mafia // ignore: cast_nullable_to_non_nullable
              as PlayerRoleStatsModel,
      don: null == don
          ? _value.don
          : don // ignore: cast_nullable_to_non_nullable
              as PlayerRoleStatsModel,
      sheriff: null == sheriff
          ? _value.sheriff
          : sheriff // ignore: cast_nullable_to_non_nullable
              as PlayerRoleStatsModel,
      sameCityTop: null == sameCityTop
          ? _value._sameCityTop
          : sameCityTop // ignore: cast_nullable_to_non_nullable
              as List<PlayerPairStatModel>,
      sameMafiaTop: null == sameMafiaTop
          ? _value._sameMafiaTop
          : sameMafiaTop // ignore: cast_nullable_to_non_nullable
              as List<PlayerPairStatModel>,
      diffTeamTop: null == diffTeamTop
          ? _value._diffTeamTop
          : diffTeamTop // ignore: cast_nullable_to_non_nullable
              as List<PlayerPairStatModel>,
    ));
  }
}

/// @nodoc

class _$PlayerStatisticsModelImpl implements _PlayerStatisticsModel {
  const _$PlayerStatisticsModelImpl(
      {required this.playerId,
      required this.nickname,
      required this.overall,
      required this.citizen,
      required this.mafia,
      required this.don,
      required this.sheriff,
      required final List<PlayerPairStatModel> sameCityTop,
      required final List<PlayerPairStatModel> sameMafiaTop,
      required final List<PlayerPairStatModel> diffTeamTop})
      : _sameCityTop = sameCityTop,
        _sameMafiaTop = sameMafiaTop,
        _diffTeamTop = diffTeamTop;

  @override
  final int playerId;
  @override
  final String nickname;
  @override
  final PlayerRoleStatsModel overall;
  @override
  final PlayerRoleStatsModel citizen;
  @override
  final PlayerRoleStatsModel mafia;
  @override
  final PlayerRoleStatsModel don;
  @override
  final PlayerRoleStatsModel sheriff;
  final List<PlayerPairStatModel> _sameCityTop;
  @override
  List<PlayerPairStatModel> get sameCityTop {
    if (_sameCityTop is EqualUnmodifiableListView) return _sameCityTop;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sameCityTop);
  }

  final List<PlayerPairStatModel> _sameMafiaTop;
  @override
  List<PlayerPairStatModel> get sameMafiaTop {
    if (_sameMafiaTop is EqualUnmodifiableListView) return _sameMafiaTop;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sameMafiaTop);
  }

  final List<PlayerPairStatModel> _diffTeamTop;
  @override
  List<PlayerPairStatModel> get diffTeamTop {
    if (_diffTeamTop is EqualUnmodifiableListView) return _diffTeamTop;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_diffTeamTop);
  }

  @override
  String toString() {
    return 'PlayerStatisticsModel(playerId: $playerId, nickname: $nickname, overall: $overall, citizen: $citizen, mafia: $mafia, don: $don, sheriff: $sheriff, sameCityTop: $sameCityTop, sameMafiaTop: $sameMafiaTop, diffTeamTop: $diffTeamTop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatisticsModelImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.overall, overall) || other.overall == overall) &&
            (identical(other.citizen, citizen) || other.citizen == citizen) &&
            (identical(other.mafia, mafia) || other.mafia == mafia) &&
            (identical(other.don, don) || other.don == don) &&
            (identical(other.sheriff, sheriff) || other.sheriff == sheriff) &&
            const DeepCollectionEquality()
                .equals(other._sameCityTop, _sameCityTop) &&
            const DeepCollectionEquality()
                .equals(other._sameMafiaTop, _sameMafiaTop) &&
            const DeepCollectionEquality()
                .equals(other._diffTeamTop, _diffTeamTop));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      playerId,
      nickname,
      overall,
      citizen,
      mafia,
      don,
      sheriff,
      const DeepCollectionEquality().hash(_sameCityTop),
      const DeepCollectionEquality().hash(_sameMafiaTop),
      const DeepCollectionEquality().hash(_diffTeamTop));

  /// Create a copy of PlayerStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatisticsModelImplCopyWith<_$PlayerStatisticsModelImpl>
      get copyWith => __$$PlayerStatisticsModelImplCopyWithImpl<
          _$PlayerStatisticsModelImpl>(this, _$identity);
}

abstract class _PlayerStatisticsModel implements PlayerStatisticsModel {
  const factory _PlayerStatisticsModel(
          {required final int playerId,
          required final String nickname,
          required final PlayerRoleStatsModel overall,
          required final PlayerRoleStatsModel citizen,
          required final PlayerRoleStatsModel mafia,
          required final PlayerRoleStatsModel don,
          required final PlayerRoleStatsModel sheriff,
          required final List<PlayerPairStatModel> sameCityTop,
          required final List<PlayerPairStatModel> sameMafiaTop,
          required final List<PlayerPairStatModel> diffTeamTop}) =
      _$PlayerStatisticsModelImpl;

  @override
  int get playerId;
  @override
  String get nickname;
  @override
  PlayerRoleStatsModel get overall;
  @override
  PlayerRoleStatsModel get citizen;
  @override
  PlayerRoleStatsModel get mafia;
  @override
  PlayerRoleStatsModel get don;
  @override
  PlayerRoleStatsModel get sheriff;
  @override
  List<PlayerPairStatModel> get sameCityTop;
  @override
  List<PlayerPairStatModel> get sameMafiaTop;
  @override
  List<PlayerPairStatModel> get diffTeamTop;

  /// Create a copy of PlayerStatisticsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerStatisticsModelImplCopyWith<_$PlayerStatisticsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayerRoleStatsModel {
  int get games => throw _privateConstructorUsedError;
  int get wins => throw _privateConstructorUsedError;
  double get winRate => throw _privateConstructorUsedError;
  double get avgBonusScore => throw _privateConstructorUsedError;

  /// Create a copy of PlayerRoleStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerRoleStatsModelCopyWith<PlayerRoleStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerRoleStatsModelCopyWith<$Res> {
  factory $PlayerRoleStatsModelCopyWith(PlayerRoleStatsModel value,
          $Res Function(PlayerRoleStatsModel) then) =
      _$PlayerRoleStatsModelCopyWithImpl<$Res, PlayerRoleStatsModel>;
  @useResult
  $Res call({int games, int wins, double winRate, double avgBonusScore});
}

/// @nodoc
class _$PlayerRoleStatsModelCopyWithImpl<$Res,
        $Val extends PlayerRoleStatsModel>
    implements $PlayerRoleStatsModelCopyWith<$Res> {
  _$PlayerRoleStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerRoleStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? games = null,
    Object? wins = null,
    Object? winRate = null,
    Object? avgBonusScore = null,
  }) {
    return _then(_value.copyWith(
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      winRate: null == winRate
          ? _value.winRate
          : winRate // ignore: cast_nullable_to_non_nullable
              as double,
      avgBonusScore: null == avgBonusScore
          ? _value.avgBonusScore
          : avgBonusScore // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerRoleStatsModelImplCopyWith<$Res>
    implements $PlayerRoleStatsModelCopyWith<$Res> {
  factory _$$PlayerRoleStatsModelImplCopyWith(_$PlayerRoleStatsModelImpl value,
          $Res Function(_$PlayerRoleStatsModelImpl) then) =
      __$$PlayerRoleStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int games, int wins, double winRate, double avgBonusScore});
}

/// @nodoc
class __$$PlayerRoleStatsModelImplCopyWithImpl<$Res>
    extends _$PlayerRoleStatsModelCopyWithImpl<$Res, _$PlayerRoleStatsModelImpl>
    implements _$$PlayerRoleStatsModelImplCopyWith<$Res> {
  __$$PlayerRoleStatsModelImplCopyWithImpl(_$PlayerRoleStatsModelImpl _value,
      $Res Function(_$PlayerRoleStatsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerRoleStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? games = null,
    Object? wins = null,
    Object? winRate = null,
    Object? avgBonusScore = null,
  }) {
    return _then(_$PlayerRoleStatsModelImpl(
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      winRate: null == winRate
          ? _value.winRate
          : winRate // ignore: cast_nullable_to_non_nullable
              as double,
      avgBonusScore: null == avgBonusScore
          ? _value.avgBonusScore
          : avgBonusScore // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$PlayerRoleStatsModelImpl implements _PlayerRoleStatsModel {
  const _$PlayerRoleStatsModelImpl(
      {required this.games,
      required this.wins,
      required this.winRate,
      required this.avgBonusScore});

  @override
  final int games;
  @override
  final int wins;
  @override
  final double winRate;
  @override
  final double avgBonusScore;

  @override
  String toString() {
    return 'PlayerRoleStatsModel(games: $games, wins: $wins, winRate: $winRate, avgBonusScore: $avgBonusScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerRoleStatsModelImpl &&
            (identical(other.games, games) || other.games == games) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.winRate, winRate) || other.winRate == winRate) &&
            (identical(other.avgBonusScore, avgBonusScore) ||
                other.avgBonusScore == avgBonusScore));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, games, wins, winRate, avgBonusScore);

  /// Create a copy of PlayerRoleStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerRoleStatsModelImplCopyWith<_$PlayerRoleStatsModelImpl>
      get copyWith =>
          __$$PlayerRoleStatsModelImplCopyWithImpl<_$PlayerRoleStatsModelImpl>(
              this, _$identity);
}

abstract class _PlayerRoleStatsModel implements PlayerRoleStatsModel {
  const factory _PlayerRoleStatsModel(
      {required final int games,
      required final int wins,
      required final double winRate,
      required final double avgBonusScore}) = _$PlayerRoleStatsModelImpl;

  @override
  int get games;
  @override
  int get wins;
  @override
  double get winRate;
  @override
  double get avgBonusScore;

  /// Create a copy of PlayerRoleStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerRoleStatsModelImplCopyWith<_$PlayerRoleStatsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayerPairStatModel {
  int get playerId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  int get games => throw _privateConstructorUsedError;
  int get wins => throw _privateConstructorUsedError;
  double get winRate => throw _privateConstructorUsedError;

  /// Create a copy of PlayerPairStatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerPairStatModelCopyWith<PlayerPairStatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerPairStatModelCopyWith<$Res> {
  factory $PlayerPairStatModelCopyWith(
          PlayerPairStatModel value, $Res Function(PlayerPairStatModel) then) =
      _$PlayerPairStatModelCopyWithImpl<$Res, PlayerPairStatModel>;
  @useResult
  $Res call(
      {int playerId, String nickname, int games, int wins, double winRate});
}

/// @nodoc
class _$PlayerPairStatModelCopyWithImpl<$Res, $Val extends PlayerPairStatModel>
    implements $PlayerPairStatModelCopyWith<$Res> {
  _$PlayerPairStatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerPairStatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? nickname = null,
    Object? games = null,
    Object? wins = null,
    Object? winRate = null,
  }) {
    return _then(_value.copyWith(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      winRate: null == winRate
          ? _value.winRate
          : winRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerPairStatModelImplCopyWith<$Res>
    implements $PlayerPairStatModelCopyWith<$Res> {
  factory _$$PlayerPairStatModelImplCopyWith(_$PlayerPairStatModelImpl value,
          $Res Function(_$PlayerPairStatModelImpl) then) =
      __$$PlayerPairStatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int playerId, String nickname, int games, int wins, double winRate});
}

/// @nodoc
class __$$PlayerPairStatModelImplCopyWithImpl<$Res>
    extends _$PlayerPairStatModelCopyWithImpl<$Res, _$PlayerPairStatModelImpl>
    implements _$$PlayerPairStatModelImplCopyWith<$Res> {
  __$$PlayerPairStatModelImplCopyWithImpl(_$PlayerPairStatModelImpl _value,
      $Res Function(_$PlayerPairStatModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerPairStatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? nickname = null,
    Object? games = null,
    Object? wins = null,
    Object? winRate = null,
  }) {
    return _then(_$PlayerPairStatModelImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      winRate: null == winRate
          ? _value.winRate
          : winRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$PlayerPairStatModelImpl implements _PlayerPairStatModel {
  const _$PlayerPairStatModelImpl(
      {required this.playerId,
      required this.nickname,
      required this.games,
      required this.wins,
      required this.winRate});

  @override
  final int playerId;
  @override
  final String nickname;
  @override
  final int games;
  @override
  final int wins;
  @override
  final double winRate;

  @override
  String toString() {
    return 'PlayerPairStatModel(playerId: $playerId, nickname: $nickname, games: $games, wins: $wins, winRate: $winRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerPairStatModelImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.games, games) || other.games == games) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.winRate, winRate) || other.winRate == winRate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, playerId, nickname, games, wins, winRate);

  /// Create a copy of PlayerPairStatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerPairStatModelImplCopyWith<_$PlayerPairStatModelImpl> get copyWith =>
      __$$PlayerPairStatModelImplCopyWithImpl<_$PlayerPairStatModelImpl>(
          this, _$identity);
}

abstract class _PlayerPairStatModel implements PlayerPairStatModel {
  const factory _PlayerPairStatModel(
      {required final int playerId,
      required final String nickname,
      required final int games,
      required final int wins,
      required final double winRate}) = _$PlayerPairStatModelImpl;

  @override
  int get playerId;
  @override
  String get nickname;
  @override
  int get games;
  @override
  int get wins;
  @override
  double get winRate;

  /// Create a copy of PlayerPairStatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerPairStatModelImplCopyWith<_$PlayerPairStatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
