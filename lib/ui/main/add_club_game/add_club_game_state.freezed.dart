// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_club_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddClubGameState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<PlayerModel> get players => throw _privateConstructorUsedError;
  bool get canEdit => throw _privateConstructorUsedError;
  String get clubName => throw _privateConstructorUsedError;
  List<CiSchemeModel> get ciSchemes => throw _privateConstructorUsedError;
  bool get isTournament => throw _privateConstructorUsedError;

  /// Create a copy of AddClubGameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddClubGameStateCopyWith<AddClubGameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddClubGameStateCopyWith<$Res> {
  factory $AddClubGameStateCopyWith(
          AddClubGameState value, $Res Function(AddClubGameState) then) =
      _$AddClubGameStateCopyWithImpl<$Res, AddClubGameState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<PlayerModel> players,
      bool canEdit,
      String clubName,
      List<CiSchemeModel> ciSchemes,
      bool isTournament});
}

/// @nodoc
class _$AddClubGameStateCopyWithImpl<$Res, $Val extends AddClubGameState>
    implements $AddClubGameStateCopyWith<$Res> {
  _$AddClubGameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddClubGameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? players = null,
    Object? canEdit = null,
    Object? clubName = null,
    Object? ciSchemes = null,
    Object? isTournament = null,
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
      canEdit: null == canEdit
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      clubName: null == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String,
      ciSchemes: null == ciSchemes
          ? _value.ciSchemes
          : ciSchemes // ignore: cast_nullable_to_non_nullable
              as List<CiSchemeModel>,
      isTournament: null == isTournament
          ? _value.isTournament
          : isTournament // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddClubGameStateImplCopyWith<$Res>
    implements $AddClubGameStateCopyWith<$Res> {
  factory _$$AddClubGameStateImplCopyWith(_$AddClubGameStateImpl value,
          $Res Function(_$AddClubGameStateImpl) then) =
      __$$AddClubGameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<PlayerModel> players,
      bool canEdit,
      String clubName,
      List<CiSchemeModel> ciSchemes,
      bool isTournament});
}

/// @nodoc
class __$$AddClubGameStateImplCopyWithImpl<$Res>
    extends _$AddClubGameStateCopyWithImpl<$Res, _$AddClubGameStateImpl>
    implements _$$AddClubGameStateImplCopyWith<$Res> {
  __$$AddClubGameStateImplCopyWithImpl(_$AddClubGameStateImpl _value,
      $Res Function(_$AddClubGameStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddClubGameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? players = null,
    Object? canEdit = null,
    Object? clubName = null,
    Object? ciSchemes = null,
    Object? isTournament = null,
  }) {
    return _then(_$AddClubGameStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      canEdit: null == canEdit
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      clubName: null == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String,
      ciSchemes: null == ciSchemes
          ? _value._ciSchemes
          : ciSchemes // ignore: cast_nullable_to_non_nullable
              as List<CiSchemeModel>,
      isTournament: null == isTournament
          ? _value.isTournament
          : isTournament // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AddClubGameStateImpl implements _AddClubGameState {
  const _$AddClubGameStateImpl(
      {this.isLoading = true,
      final List<PlayerModel> players = const [],
      this.canEdit = false,
      this.clubName = "",
      final List<CiSchemeModel> ciSchemes = const [],
      this.isTournament = false})
      : _players = players,
        _ciSchemes = ciSchemes;

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

  @override
  @JsonKey()
  final bool canEdit;
  @override
  @JsonKey()
  final String clubName;
  final List<CiSchemeModel> _ciSchemes;
  @override
  @JsonKey()
  List<CiSchemeModel> get ciSchemes {
    if (_ciSchemes is EqualUnmodifiableListView) return _ciSchemes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ciSchemes);
  }

  @override
  @JsonKey()
  final bool isTournament;

  @override
  String toString() {
    return 'AddClubGameState(isLoading: $isLoading, players: $players, canEdit: $canEdit, clubName: $clubName, ciSchemes: $ciSchemes, isTournament: $isTournament)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit) &&
            (identical(other.clubName, clubName) ||
                other.clubName == clubName) &&
            const DeepCollectionEquality()
                .equals(other._ciSchemes, _ciSchemes) &&
            (identical(other.isTournament, isTournament) ||
                other.isTournament == isTournament));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_players),
      canEdit,
      clubName,
      const DeepCollectionEquality().hash(_ciSchemes),
      isTournament);

  /// Create a copy of AddClubGameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClubGameStateImplCopyWith<_$AddClubGameStateImpl> get copyWith =>
      __$$AddClubGameStateImplCopyWithImpl<_$AddClubGameStateImpl>(
          this, _$identity);
}

abstract class _AddClubGameState implements AddClubGameState {
  const factory _AddClubGameState(
      {final bool isLoading,
      final List<PlayerModel> players,
      final bool canEdit,
      final String clubName,
      final List<CiSchemeModel> ciSchemes,
      final bool isTournament}) = _$AddClubGameStateImpl;

  @override
  bool get isLoading;
  @override
  List<PlayerModel> get players;
  @override
  bool get canEdit;
  @override
  String get clubName;
  @override
  List<CiSchemeModel> get ciSchemes;
  @override
  bool get isTournament;

  /// Create a copy of AddClubGameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddClubGameStateImplCopyWith<_$AddClubGameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
