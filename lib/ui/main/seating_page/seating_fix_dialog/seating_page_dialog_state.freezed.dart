// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seating_page_dialog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeatingPageDialogState {
  bool get loading => throw _privateConstructorUsedError;
  String? get incorrectPlayer => throw _privateConstructorUsedError;
  List<String> get notFound => throw _privateConstructorUsedError;
  List<PlayerModel> get players => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeatingPageDialogStateCopyWith<SeatingPageDialogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatingPageDialogStateCopyWith<$Res> {
  factory $SeatingPageDialogStateCopyWith(SeatingPageDialogState value,
          $Res Function(SeatingPageDialogState) then) =
      _$SeatingPageDialogStateCopyWithImpl<$Res, SeatingPageDialogState>;
  @useResult
  $Res call(
      {bool loading,
      String? incorrectPlayer,
      List<String> notFound,
      List<PlayerModel> players});
}

/// @nodoc
class _$SeatingPageDialogStateCopyWithImpl<$Res,
        $Val extends SeatingPageDialogState>
    implements $SeatingPageDialogStateCopyWith<$Res> {
  _$SeatingPageDialogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? incorrectPlayer = freezed,
    Object? notFound = null,
    Object? players = null,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      incorrectPlayer: freezed == incorrectPlayer
          ? _value.incorrectPlayer
          : incorrectPlayer // ignore: cast_nullable_to_non_nullable
              as String?,
      notFound: null == notFound
          ? _value.notFound
          : notFound // ignore: cast_nullable_to_non_nullable
              as List<String>,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeatingPageDialogStateImplCopyWith<$Res>
    implements $SeatingPageDialogStateCopyWith<$Res> {
  factory _$$SeatingPageDialogStateImplCopyWith(
          _$SeatingPageDialogStateImpl value,
          $Res Function(_$SeatingPageDialogStateImpl) then) =
      __$$SeatingPageDialogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      String? incorrectPlayer,
      List<String> notFound,
      List<PlayerModel> players});
}

/// @nodoc
class __$$SeatingPageDialogStateImplCopyWithImpl<$Res>
    extends _$SeatingPageDialogStateCopyWithImpl<$Res,
        _$SeatingPageDialogStateImpl>
    implements _$$SeatingPageDialogStateImplCopyWith<$Res> {
  __$$SeatingPageDialogStateImplCopyWithImpl(
      _$SeatingPageDialogStateImpl _value,
      $Res Function(_$SeatingPageDialogStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? incorrectPlayer = freezed,
    Object? notFound = null,
    Object? players = null,
  }) {
    return _then(_$SeatingPageDialogStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      incorrectPlayer: freezed == incorrectPlayer
          ? _value.incorrectPlayer
          : incorrectPlayer // ignore: cast_nullable_to_non_nullable
              as String?,
      notFound: null == notFound
          ? _value._notFound
          : notFound // ignore: cast_nullable_to_non_nullable
              as List<String>,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
    ));
  }
}

/// @nodoc

class _$SeatingPageDialogStateImpl implements _SeatingPageDialogState {
  const _$SeatingPageDialogStateImpl(
      {this.loading = true,
      this.incorrectPlayer,
      required final List<String> notFound,
      final List<PlayerModel> players = const []})
      : _notFound = notFound,
        _players = players;

  @override
  @JsonKey()
  final bool loading;
  @override
  final String? incorrectPlayer;
  final List<String> _notFound;
  @override
  List<String> get notFound {
    if (_notFound is EqualUnmodifiableListView) return _notFound;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notFound);
  }

  final List<PlayerModel> _players;
  @override
  @JsonKey()
  List<PlayerModel> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  String toString() {
    return 'SeatingPageDialogState(loading: $loading, incorrectPlayer: $incorrectPlayer, notFound: $notFound, players: $players)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatingPageDialogStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.incorrectPlayer, incorrectPlayer) ||
                other.incorrectPlayer == incorrectPlayer) &&
            const DeepCollectionEquality().equals(other._notFound, _notFound) &&
            const DeepCollectionEquality().equals(other._players, _players));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      incorrectPlayer,
      const DeepCollectionEquality().hash(_notFound),
      const DeepCollectionEquality().hash(_players));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatingPageDialogStateImplCopyWith<_$SeatingPageDialogStateImpl>
      get copyWith => __$$SeatingPageDialogStateImplCopyWithImpl<
          _$SeatingPageDialogStateImpl>(this, _$identity);
}

abstract class _SeatingPageDialogState implements SeatingPageDialogState {
  const factory _SeatingPageDialogState(
      {final bool loading,
      final String? incorrectPlayer,
      required final List<String> notFound,
      final List<PlayerModel> players}) = _$SeatingPageDialogStateImpl;

  @override
  bool get loading;
  @override
  String? get incorrectPlayer;
  @override
  List<String> get notFound;
  @override
  List<PlayerModel> get players;
  @override
  @JsonKey(ignore: true)
  _$$SeatingPageDialogStateImplCopyWith<_$SeatingPageDialogStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
