// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seating_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeatingPageState {
  List<Pair<PlayerModel, PlayerModel>> get cannotMeet =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<List<GameResultModel>> get games => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeatingPageStateCopyWith<SeatingPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatingPageStateCopyWith<$Res> {
  factory $SeatingPageStateCopyWith(
          SeatingPageState value, $Res Function(SeatingPageState) then) =
      _$SeatingPageStateCopyWithImpl<$Res, SeatingPageState>;
  @useResult
  $Res call(
      {List<Pair<PlayerModel, PlayerModel>> cannotMeet,
      bool isLoading,
      List<List<GameResultModel>> games});
}

/// @nodoc
class _$SeatingPageStateCopyWithImpl<$Res, $Val extends SeatingPageState>
    implements $SeatingPageStateCopyWith<$Res> {
  _$SeatingPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cannotMeet = null,
    Object? isLoading = null,
    Object? games = null,
  }) {
    return _then(_value.copyWith(
      cannotMeet: null == cannotMeet
          ? _value.cannotMeet
          : cannotMeet // ignore: cast_nullable_to_non_nullable
              as List<Pair<PlayerModel, PlayerModel>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as List<List<GameResultModel>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeatingPageStateImplCopyWith<$Res>
    implements $SeatingPageStateCopyWith<$Res> {
  factory _$$SeatingPageStateImplCopyWith(_$SeatingPageStateImpl value,
          $Res Function(_$SeatingPageStateImpl) then) =
      __$$SeatingPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Pair<PlayerModel, PlayerModel>> cannotMeet,
      bool isLoading,
      List<List<GameResultModel>> games});
}

/// @nodoc
class __$$SeatingPageStateImplCopyWithImpl<$Res>
    extends _$SeatingPageStateCopyWithImpl<$Res, _$SeatingPageStateImpl>
    implements _$$SeatingPageStateImplCopyWith<$Res> {
  __$$SeatingPageStateImplCopyWithImpl(_$SeatingPageStateImpl _value,
      $Res Function(_$SeatingPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cannotMeet = null,
    Object? isLoading = null,
    Object? games = null,
  }) {
    return _then(_$SeatingPageStateImpl(
      cannotMeet: null == cannotMeet
          ? _value._cannotMeet
          : cannotMeet // ignore: cast_nullable_to_non_nullable
              as List<Pair<PlayerModel, PlayerModel>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      games: null == games
          ? _value._games
          : games // ignore: cast_nullable_to_non_nullable
              as List<List<GameResultModel>>,
    ));
  }
}

/// @nodoc

class _$SeatingPageStateImpl implements _SeatingPageState {
  const _$SeatingPageStateImpl(
      {final List<Pair<PlayerModel, PlayerModel>> cannotMeet = const [],
      this.isLoading = true,
      final List<List<GameResultModel>> games = const []})
      : _cannotMeet = cannotMeet,
        _games = games;

  final List<Pair<PlayerModel, PlayerModel>> _cannotMeet;
  @override
  @JsonKey()
  List<Pair<PlayerModel, PlayerModel>> get cannotMeet {
    if (_cannotMeet is EqualUnmodifiableListView) return _cannotMeet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cannotMeet);
  }

  @override
  @JsonKey()
  final bool isLoading;
  final List<List<GameResultModel>> _games;
  @override
  @JsonKey()
  List<List<GameResultModel>> get games {
    if (_games is EqualUnmodifiableListView) return _games;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_games);
  }

  @override
  String toString() {
    return 'SeatingPageState(cannotMeet: $cannotMeet, isLoading: $isLoading, games: $games)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatingPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._cannotMeet, _cannotMeet) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._games, _games));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_cannotMeet),
      isLoading,
      const DeepCollectionEquality().hash(_games));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatingPageStateImplCopyWith<_$SeatingPageStateImpl> get copyWith =>
      __$$SeatingPageStateImplCopyWithImpl<_$SeatingPageStateImpl>(
          this, _$identity);
}

abstract class _SeatingPageState implements SeatingPageState {
  const factory _SeatingPageState(
      {final List<Pair<PlayerModel, PlayerModel>> cannotMeet,
      final bool isLoading,
      final List<List<GameResultModel>> games}) = _$SeatingPageStateImpl;

  @override
  List<Pair<PlayerModel, PlayerModel>> get cannotMeet;
  @override
  bool get isLoading;
  @override
  List<List<GameResultModel>> get games;
  @override
  @JsonKey(ignore: true)
  _$$SeatingPageStateImplCopyWith<_$SeatingPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
