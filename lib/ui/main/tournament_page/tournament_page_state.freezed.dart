// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$TournamentPageStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      List<PlayerModel> players,
      List<PlayerModel> tournamentPlayers,
      List<List<PlayerModel>> cannotMeet});
}

/// @nodoc
class _$TournamentPageStateCopyWithImpl<$Res>
    implements $TournamentPageStateCopyWith<$Res> {
  _$TournamentPageStateCopyWithImpl(this._value, this._then);

  final TournamentPageState _value;
  // ignore: unused_field
  final $Res Function(TournamentPageState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? players = freezed,
    Object? tournamentPlayers = freezed,
    Object? cannotMeet = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      players: players == freezed
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      tournamentPlayers: tournamentPlayers == freezed
          ? _value.tournamentPlayers
          : tournamentPlayers // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      cannotMeet: cannotMeet == freezed
          ? _value.cannotMeet
          : cannotMeet // ignore: cast_nullable_to_non_nullable
              as List<List<PlayerModel>>,
    ));
  }
}

/// @nodoc
abstract class _$$_TournamentPageStateCopyWith<$Res>
    implements $TournamentPageStateCopyWith<$Res> {
  factory _$$_TournamentPageStateCopyWith(_$_TournamentPageState value,
          $Res Function(_$_TournamentPageState) then) =
      __$$_TournamentPageStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      List<PlayerModel> players,
      List<PlayerModel> tournamentPlayers,
      List<List<PlayerModel>> cannotMeet});
}

/// @nodoc
class __$$_TournamentPageStateCopyWithImpl<$Res>
    extends _$TournamentPageStateCopyWithImpl<$Res>
    implements _$$_TournamentPageStateCopyWith<$Res> {
  __$$_TournamentPageStateCopyWithImpl(_$_TournamentPageState _value,
      $Res Function(_$_TournamentPageState) _then)
      : super(_value, (v) => _then(v as _$_TournamentPageState));

  @override
  _$_TournamentPageState get _value => super._value as _$_TournamentPageState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? players = freezed,
    Object? tournamentPlayers = freezed,
    Object? cannotMeet = freezed,
  }) {
    return _then(_$_TournamentPageState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      players: players == freezed
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      tournamentPlayers: tournamentPlayers == freezed
          ? _value._tournamentPlayers
          : tournamentPlayers // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      cannotMeet: cannotMeet == freezed
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
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<PlayerModel> _tournamentPlayers;
  @override
  @JsonKey()
  List<PlayerModel> get tournamentPlayers {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tournamentPlayers);
  }

  final List<List<PlayerModel>> _cannotMeet;
  @override
  @JsonKey()
  List<List<PlayerModel>> get cannotMeet {
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
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality()
                .equals(other._tournamentPlayers, _tournamentPlayers) &&
            const DeepCollectionEquality()
                .equals(other._cannotMeet, _cannotMeet));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(_players),
      const DeepCollectionEquality().hash(_tournamentPlayers),
      const DeepCollectionEquality().hash(_cannotMeet));

  @JsonKey(ignore: true)
  @override
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
