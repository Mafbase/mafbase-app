// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'add_club_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddClubGameState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<PlayerModel> get players => throw _privateConstructorUsedError;
  bool get canEdit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddClubGameStateCopyWith<AddClubGameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddClubGameStateCopyWith<$Res> {
  factory $AddClubGameStateCopyWith(
          AddClubGameState value, $Res Function(AddClubGameState) then) =
      _$AddClubGameStateCopyWithImpl<$Res>;
  $Res call({bool isLoading, List<PlayerModel> players, bool canEdit});
}

/// @nodoc
class _$AddClubGameStateCopyWithImpl<$Res>
    implements $AddClubGameStateCopyWith<$Res> {
  _$AddClubGameStateCopyWithImpl(this._value, this._then);

  final AddClubGameState _value;
  // ignore: unused_field
  final $Res Function(AddClubGameState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? players = freezed,
    Object? canEdit = freezed,
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
      canEdit: canEdit == freezed
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_AddClubGameStateCopyWith<$Res>
    implements $AddClubGameStateCopyWith<$Res> {
  factory _$$_AddClubGameStateCopyWith(
          _$_AddClubGameState value, $Res Function(_$_AddClubGameState) then) =
      __$$_AddClubGameStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoading, List<PlayerModel> players, bool canEdit});
}

/// @nodoc
class __$$_AddClubGameStateCopyWithImpl<$Res>
    extends _$AddClubGameStateCopyWithImpl<$Res>
    implements _$$_AddClubGameStateCopyWith<$Res> {
  __$$_AddClubGameStateCopyWithImpl(
      _$_AddClubGameState _value, $Res Function(_$_AddClubGameState) _then)
      : super(_value, (v) => _then(v as _$_AddClubGameState));

  @override
  _$_AddClubGameState get _value => super._value as _$_AddClubGameState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? players = freezed,
    Object? canEdit = freezed,
  }) {
    return _then(_$_AddClubGameState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      players: players == freezed
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      canEdit: canEdit == freezed
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AddClubGameState implements _AddClubGameState {
  const _$_AddClubGameState(
      {this.isLoading = true,
      final List<PlayerModel> players = const [],
      this.canEdit = false})
      : _players = players;

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

  @override
  @JsonKey()
  final bool canEdit;

  @override
  String toString() {
    return 'AddClubGameState(isLoading: $isLoading, players: $players, canEdit: $canEdit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddClubGameState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality().equals(other.canEdit, canEdit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(_players),
      const DeepCollectionEquality().hash(canEdit));

  @JsonKey(ignore: true)
  @override
  _$$_AddClubGameStateCopyWith<_$_AddClubGameState> get copyWith =>
      __$$_AddClubGameStateCopyWithImpl<_$_AddClubGameState>(this, _$identity);
}

abstract class _AddClubGameState implements AddClubGameState {
  const factory _AddClubGameState(
      {final bool isLoading,
      final List<PlayerModel> players,
      final bool canEdit}) = _$_AddClubGameState;

  @override
  bool get isLoading;
  @override
  List<PlayerModel> get players;
  @override
  bool get canEdit;
  @override
  @JsonKey(ignore: true)
  _$$_AddClubGameStateCopyWith<_$_AddClubGameState> get copyWith =>
      throw _privateConstructorUsedError;
}
