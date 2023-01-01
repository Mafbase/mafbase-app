// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TournamentPageState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<PlayerModel> get players => throw _privateConstructorUsedError;
  List<PlayerModel> get tournamentPlayers => throw _privateConstructorUsedError;
  List<List<PlayerModel>> get cannotMeet => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TournamentPageStateCopyWith<TournamentPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentPageStateCopyWith<$Res> {
  factory $TournamentPageStateCopyWith(
          TournamentPageState value, $Res Function(TournamentPageState) then) =
      _$TournamentPageStateCopyWithImpl<$Res, TournamentPageState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<PlayerModel> players,
      List<PlayerModel> tournamentPlayers,
      List<List<PlayerModel>> cannotMeet});
}

/// @nodoc
class _$TournamentPageStateCopyWithImpl<$Res, $Val extends TournamentPageState>
    implements $TournamentPageStateCopyWith<$Res> {
  _$TournamentPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? players = null,
    Object? tournamentPlayers = null,
    Object? cannotMeet = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      tournamentPlayers: null == tournamentPlayers
          ? _value.tournamentPlayers
          : tournamentPlayers // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      cannotMeet: null == cannotMeet
          ? _value.cannotMeet
          : cannotMeet // ignore: cast_nullable_to_non_nullable
              as List<List<PlayerModel>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TournamentPageStateCopyWith<$Res>
    implements $TournamentPageStateCopyWith<$Res> {
  factory _$$_TournamentPageStateCopyWith(_$_TournamentPageState value,
          $Res Function(_$_TournamentPageState) then) =
      __$$_TournamentPageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<PlayerModel> players,
      List<PlayerModel> tournamentPlayers,
      List<List<PlayerModel>> cannotMeet});
}

/// @nodoc
class __$$_TournamentPageStateCopyWithImpl<$Res>
    extends _$TournamentPageStateCopyWithImpl<$Res, _$_TournamentPageState>
    implements _$$_TournamentPageStateCopyWith<$Res> {
  __$$_TournamentPageStateCopyWithImpl(_$_TournamentPageState _value,
      $Res Function(_$_TournamentPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? players = null,
    Object? tournamentPlayers = null,
    Object? cannotMeet = null,
  }) {
    return _then(_$_TournamentPageState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      tournamentPlayers: null == tournamentPlayers
          ? _value._tournamentPlayers
          : tournamentPlayers // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      cannotMeet: null == cannotMeet
          ? _value._cannotMeet
          : cannotMeet // ignore: cast_nullable_to_non_nullable
              as List<List<PlayerModel>>,
    ));
  }
}

/// @nodoc

class _$_TournamentPageState implements _TournamentPageState {
  const _$_TournamentPageState(
      {this.isLoading = true,
      final List<PlayerModel> players = const [],
      final List<PlayerModel> tournamentPlayers = const [],
      final List<List<PlayerModel>> cannotMeet = const []})
      : _players = players,
        _tournamentPlayers = tournamentPlayers,
        _cannotMeet = cannotMeet;

  @override
  @JsonKey()
  final bool isLoading;
  final List<PlayerModel> _players;
  @override
  @JsonKey()
  List<PlayerModel> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<PlayerModel> _tournamentPlayers;
  @override
  @JsonKey()
  List<PlayerModel> get tournamentPlayers {
    if (_tournamentPlayers is EqualUnmodifiableListView)
      return _tournamentPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tournamentPlayers);
  }

  final List<List<PlayerModel>> _cannotMeet;
  @override
  @JsonKey()
  List<List<PlayerModel>> get cannotMeet {
    if (_cannotMeet is EqualUnmodifiableListView) return _cannotMeet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cannotMeet);
  }

  @override
  String toString() {
    return 'TournamentPageState(isLoading: $isLoading, players: $players, tournamentPlayers: $tournamentPlayers, cannotMeet: $cannotMeet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TournamentPageState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality()
                .equals(other._tournamentPlayers, _tournamentPlayers) &&
            const DeepCollectionEquality()
                .equals(other._cannotMeet, _cannotMeet));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_players),
      const DeepCollectionEquality().hash(_tournamentPlayers),
      const DeepCollectionEquality().hash(_cannotMeet));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TournamentPageStateCopyWith<_$_TournamentPageState> get copyWith =>
      __$$_TournamentPageStateCopyWithImpl<_$_TournamentPageState>(
          this, _$identity);
}

abstract class _TournamentPageState implements TournamentPageState {
  const factory _TournamentPageState(
      {final bool isLoading,
      final List<PlayerModel> players,
      final List<PlayerModel> tournamentPlayers,
      final List<List<PlayerModel>> cannotMeet}) = _$_TournamentPageState;

  @override
  bool get isLoading;
  @override
  List<PlayerModel> get players;
  @override
  List<PlayerModel> get tournamentPlayers;
  @override
  List<List<PlayerModel>> get cannotMeet;
  @override
  @JsonKey(ignore: true)
  _$$_TournamentPageStateCopyWith<_$_TournamentPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
