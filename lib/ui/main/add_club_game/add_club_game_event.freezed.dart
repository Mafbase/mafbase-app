// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_club_game_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddClubGameEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function() newGame,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function()? newGame,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function()? newGame,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddClubGameEventPageOpened value) pageOpened,
    required TResult Function(AddClubGameEventSubmit value) submit,
    required TResult Function(AddClubGameEventPageEdit value) edit,
    required TResult Function(AddClubGameEventNewPlayer value) onNewPlayer,
    required TResult Function(AddClubGameEventNewGame value) newGame,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult? Function(AddClubGameEventSubmit value)? submit,
    TResult? Function(AddClubGameEventPageEdit value)? edit,
    TResult? Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult? Function(AddClubGameEventNewGame value)? newGame,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult Function(AddClubGameEventSubmit value)? submit,
    TResult Function(AddClubGameEventPageEdit value)? edit,
    TResult Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult Function(AddClubGameEventNewGame value)? newGame,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddClubGameEventCopyWith<$Res> {
  factory $AddClubGameEventCopyWith(
          AddClubGameEvent value, $Res Function(AddClubGameEvent) then) =
      _$AddClubGameEventCopyWithImpl<$Res, AddClubGameEvent>;
}

/// @nodoc
class _$AddClubGameEventCopyWithImpl<$Res, $Val extends AddClubGameEvent>
    implements $AddClubGameEventCopyWith<$Res> {
  _$AddClubGameEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AddClubGameEventPageOpenedCopyWith<$Res> {
  factory _$$AddClubGameEventPageOpenedCopyWith(
          _$AddClubGameEventPageOpened value,
          $Res Function(_$AddClubGameEventPageOpened) then) =
      __$$AddClubGameEventPageOpenedCopyWithImpl<$Res>;
  @useResult
  $Res call({int? gameId});
}

/// @nodoc
class __$$AddClubGameEventPageOpenedCopyWithImpl<$Res>
    extends _$AddClubGameEventCopyWithImpl<$Res, _$AddClubGameEventPageOpened>
    implements _$$AddClubGameEventPageOpenedCopyWith<$Res> {
  __$$AddClubGameEventPageOpenedCopyWithImpl(
      _$AddClubGameEventPageOpened _value,
      $Res Function(_$AddClubGameEventPageOpened) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = freezed,
  }) {
    return _then(_$AddClubGameEventPageOpened(
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$AddClubGameEventPageOpened implements AddClubGameEventPageOpened {
  const _$AddClubGameEventPageOpened({this.gameId});

  @override
  final int? gameId;

  @override
  String toString() {
    return 'AddClubGameEvent.pageOpened(gameId: $gameId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEventPageOpened &&
            (identical(other.gameId, gameId) || other.gameId == gameId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClubGameEventPageOpenedCopyWith<_$AddClubGameEventPageOpened>
      get copyWith => __$$AddClubGameEventPageOpenedCopyWithImpl<
          _$AddClubGameEventPageOpened>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function() newGame,
  }) {
    return pageOpened(gameId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function()? newGame,
  }) {
    return pageOpened?.call(gameId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function()? newGame,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(gameId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddClubGameEventPageOpened value) pageOpened,
    required TResult Function(AddClubGameEventSubmit value) submit,
    required TResult Function(AddClubGameEventPageEdit value) edit,
    required TResult Function(AddClubGameEventNewPlayer value) onNewPlayer,
    required TResult Function(AddClubGameEventNewGame value) newGame,
  }) {
    return pageOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult? Function(AddClubGameEventSubmit value)? submit,
    TResult? Function(AddClubGameEventPageEdit value)? edit,
    TResult? Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult? Function(AddClubGameEventNewGame value)? newGame,
  }) {
    return pageOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult Function(AddClubGameEventSubmit value)? submit,
    TResult Function(AddClubGameEventPageEdit value)? edit,
    TResult Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult Function(AddClubGameEventNewGame value)? newGame,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(this);
    }
    return orElse();
  }
}

abstract class AddClubGameEventPageOpened implements AddClubGameEvent {
  const factory AddClubGameEventPageOpened({final int? gameId}) =
      _$AddClubGameEventPageOpened;

  int? get gameId;
  @JsonKey(ignore: true)
  _$$AddClubGameEventPageOpenedCopyWith<_$AddClubGameEventPageOpened>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddClubGameEventSubmitCopyWith<$Res> {
  factory _$$AddClubGameEventSubmitCopyWith(_$AddClubGameEventSubmit value,
          $Res Function(_$AddClubGameEventSubmit) then) =
      __$$AddClubGameEventSubmitCopyWithImpl<$Res>;
  @useResult
  $Res call({ClubGameResult gameResult, int? gameId});
}

/// @nodoc
class __$$AddClubGameEventSubmitCopyWithImpl<$Res>
    extends _$AddClubGameEventCopyWithImpl<$Res, _$AddClubGameEventSubmit>
    implements _$$AddClubGameEventSubmitCopyWith<$Res> {
  __$$AddClubGameEventSubmitCopyWithImpl(_$AddClubGameEventSubmit _value,
      $Res Function(_$AddClubGameEventSubmit) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameResult = null,
    Object? gameId = freezed,
  }) {
    return _then(_$AddClubGameEventSubmit(
      gameResult: null == gameResult
          ? _value.gameResult
          : gameResult // ignore: cast_nullable_to_non_nullable
              as ClubGameResult,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$AddClubGameEventSubmit implements AddClubGameEventSubmit {
  const _$AddClubGameEventSubmit({required this.gameResult, this.gameId});

  @override
  final ClubGameResult gameResult;
  @override
  final int? gameId;

  @override
  String toString() {
    return 'AddClubGameEvent.submit(gameResult: $gameResult, gameId: $gameId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEventSubmit &&
            (identical(other.gameResult, gameResult) ||
                other.gameResult == gameResult) &&
            (identical(other.gameId, gameId) || other.gameId == gameId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameResult, gameId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClubGameEventSubmitCopyWith<_$AddClubGameEventSubmit> get copyWith =>
      __$$AddClubGameEventSubmitCopyWithImpl<_$AddClubGameEventSubmit>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function() newGame,
  }) {
    return submit(gameResult, gameId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function()? newGame,
  }) {
    return submit?.call(gameResult, gameId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function()? newGame,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(gameResult, gameId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddClubGameEventPageOpened value) pageOpened,
    required TResult Function(AddClubGameEventSubmit value) submit,
    required TResult Function(AddClubGameEventPageEdit value) edit,
    required TResult Function(AddClubGameEventNewPlayer value) onNewPlayer,
    required TResult Function(AddClubGameEventNewGame value) newGame,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult? Function(AddClubGameEventSubmit value)? submit,
    TResult? Function(AddClubGameEventPageEdit value)? edit,
    TResult? Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult? Function(AddClubGameEventNewGame value)? newGame,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult Function(AddClubGameEventSubmit value)? submit,
    TResult Function(AddClubGameEventPageEdit value)? edit,
    TResult Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult Function(AddClubGameEventNewGame value)? newGame,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(this);
    }
    return orElse();
  }
}

abstract class AddClubGameEventSubmit implements AddClubGameEvent {
  const factory AddClubGameEventSubmit(
      {required final ClubGameResult gameResult,
      final int? gameId}) = _$AddClubGameEventSubmit;

  ClubGameResult get gameResult;
  int? get gameId;
  @JsonKey(ignore: true)
  _$$AddClubGameEventSubmitCopyWith<_$AddClubGameEventSubmit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddClubGameEventPageEditCopyWith<$Res> {
  factory _$$AddClubGameEventPageEditCopyWith(_$AddClubGameEventPageEdit value,
          $Res Function(_$AddClubGameEventPageEdit) then) =
      __$$AddClubGameEventPageEditCopyWithImpl<$Res>;
  @useResult
  $Res call({int gameId});
}

/// @nodoc
class __$$AddClubGameEventPageEditCopyWithImpl<$Res>
    extends _$AddClubGameEventCopyWithImpl<$Res, _$AddClubGameEventPageEdit>
    implements _$$AddClubGameEventPageEditCopyWith<$Res> {
  __$$AddClubGameEventPageEditCopyWithImpl(_$AddClubGameEventPageEdit _value,
      $Res Function(_$AddClubGameEventPageEdit) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
  }) {
    return _then(_$AddClubGameEventPageEdit(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AddClubGameEventPageEdit implements AddClubGameEventPageEdit {
  const _$AddClubGameEventPageEdit({required this.gameId});

  @override
  final int gameId;

  @override
  String toString() {
    return 'AddClubGameEvent.edit(gameId: $gameId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEventPageEdit &&
            (identical(other.gameId, gameId) || other.gameId == gameId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClubGameEventPageEditCopyWith<_$AddClubGameEventPageEdit>
      get copyWith =>
          __$$AddClubGameEventPageEditCopyWithImpl<_$AddClubGameEventPageEdit>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function() newGame,
  }) {
    return edit(gameId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function()? newGame,
  }) {
    return edit?.call(gameId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function()? newGame,
    required TResult orElse(),
  }) {
    if (edit != null) {
      return edit(gameId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddClubGameEventPageOpened value) pageOpened,
    required TResult Function(AddClubGameEventSubmit value) submit,
    required TResult Function(AddClubGameEventPageEdit value) edit,
    required TResult Function(AddClubGameEventNewPlayer value) onNewPlayer,
    required TResult Function(AddClubGameEventNewGame value) newGame,
  }) {
    return edit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult? Function(AddClubGameEventSubmit value)? submit,
    TResult? Function(AddClubGameEventPageEdit value)? edit,
    TResult? Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult? Function(AddClubGameEventNewGame value)? newGame,
  }) {
    return edit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult Function(AddClubGameEventSubmit value)? submit,
    TResult Function(AddClubGameEventPageEdit value)? edit,
    TResult Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult Function(AddClubGameEventNewGame value)? newGame,
    required TResult orElse(),
  }) {
    if (edit != null) {
      return edit(this);
    }
    return orElse();
  }
}

abstract class AddClubGameEventPageEdit implements AddClubGameEvent {
  const factory AddClubGameEventPageEdit({required final int gameId}) =
      _$AddClubGameEventPageEdit;

  int get gameId;
  @JsonKey(ignore: true)
  _$$AddClubGameEventPageEditCopyWith<_$AddClubGameEventPageEdit>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddClubGameEventNewPlayerCopyWith<$Res> {
  factory _$$AddClubGameEventNewPlayerCopyWith(
          _$AddClubGameEventNewPlayer value,
          $Res Function(_$AddClubGameEventNewPlayer) then) =
      __$$AddClubGameEventNewPlayerCopyWithImpl<$Res>;
  @useResult
  $Res call({int index, String nickname});
}

/// @nodoc
class __$$AddClubGameEventNewPlayerCopyWithImpl<$Res>
    extends _$AddClubGameEventCopyWithImpl<$Res, _$AddClubGameEventNewPlayer>
    implements _$$AddClubGameEventNewPlayerCopyWith<$Res> {
  __$$AddClubGameEventNewPlayerCopyWithImpl(_$AddClubGameEventNewPlayer _value,
      $Res Function(_$AddClubGameEventNewPlayer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? nickname = null,
  }) {
    return _then(_$AddClubGameEventNewPlayer(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddClubGameEventNewPlayer implements AddClubGameEventNewPlayer {
  const _$AddClubGameEventNewPlayer(
      {required this.index, required this.nickname});

  @override
  final int index;
  @override
  final String nickname;

  @override
  String toString() {
    return 'AddClubGameEvent.onNewPlayer(index: $index, nickname: $nickname)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEventNewPlayer &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, nickname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClubGameEventNewPlayerCopyWith<_$AddClubGameEventNewPlayer>
      get copyWith => __$$AddClubGameEventNewPlayerCopyWithImpl<
          _$AddClubGameEventNewPlayer>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function() newGame,
  }) {
    return onNewPlayer(index, nickname);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function()? newGame,
  }) {
    return onNewPlayer?.call(index, nickname);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function()? newGame,
    required TResult orElse(),
  }) {
    if (onNewPlayer != null) {
      return onNewPlayer(index, nickname);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddClubGameEventPageOpened value) pageOpened,
    required TResult Function(AddClubGameEventSubmit value) submit,
    required TResult Function(AddClubGameEventPageEdit value) edit,
    required TResult Function(AddClubGameEventNewPlayer value) onNewPlayer,
    required TResult Function(AddClubGameEventNewGame value) newGame,
  }) {
    return onNewPlayer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult? Function(AddClubGameEventSubmit value)? submit,
    TResult? Function(AddClubGameEventPageEdit value)? edit,
    TResult? Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult? Function(AddClubGameEventNewGame value)? newGame,
  }) {
    return onNewPlayer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult Function(AddClubGameEventSubmit value)? submit,
    TResult Function(AddClubGameEventPageEdit value)? edit,
    TResult Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult Function(AddClubGameEventNewGame value)? newGame,
    required TResult orElse(),
  }) {
    if (onNewPlayer != null) {
      return onNewPlayer(this);
    }
    return orElse();
  }
}

abstract class AddClubGameEventNewPlayer implements AddClubGameEvent {
  const factory AddClubGameEventNewPlayer(
      {required final int index,
      required final String nickname}) = _$AddClubGameEventNewPlayer;

  int get index;
  String get nickname;
  @JsonKey(ignore: true)
  _$$AddClubGameEventNewPlayerCopyWith<_$AddClubGameEventNewPlayer>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddClubGameEventNewGameCopyWith<$Res> {
  factory _$$AddClubGameEventNewGameCopyWith(_$AddClubGameEventNewGame value,
          $Res Function(_$AddClubGameEventNewGame) then) =
      __$$AddClubGameEventNewGameCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddClubGameEventNewGameCopyWithImpl<$Res>
    extends _$AddClubGameEventCopyWithImpl<$Res, _$AddClubGameEventNewGame>
    implements _$$AddClubGameEventNewGameCopyWith<$Res> {
  __$$AddClubGameEventNewGameCopyWithImpl(_$AddClubGameEventNewGame _value,
      $Res Function(_$AddClubGameEventNewGame) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AddClubGameEventNewGame implements AddClubGameEventNewGame {
  const _$AddClubGameEventNewGame();

  @override
  String toString() {
    return 'AddClubGameEvent.newGame()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEventNewGame);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function() newGame,
  }) {
    return newGame();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function()? newGame,
  }) {
    return newGame?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function()? newGame,
    required TResult orElse(),
  }) {
    if (newGame != null) {
      return newGame();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddClubGameEventPageOpened value) pageOpened,
    required TResult Function(AddClubGameEventSubmit value) submit,
    required TResult Function(AddClubGameEventPageEdit value) edit,
    required TResult Function(AddClubGameEventNewPlayer value) onNewPlayer,
    required TResult Function(AddClubGameEventNewGame value) newGame,
  }) {
    return newGame(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult? Function(AddClubGameEventSubmit value)? submit,
    TResult? Function(AddClubGameEventPageEdit value)? edit,
    TResult? Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult? Function(AddClubGameEventNewGame value)? newGame,
  }) {
    return newGame?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddClubGameEventPageOpened value)? pageOpened,
    TResult Function(AddClubGameEventSubmit value)? submit,
    TResult Function(AddClubGameEventPageEdit value)? edit,
    TResult Function(AddClubGameEventNewPlayer value)? onNewPlayer,
    TResult Function(AddClubGameEventNewGame value)? newGame,
    required TResult orElse(),
  }) {
    if (newGame != null) {
      return newGame(this);
    }
    return orElse();
  }
}

abstract class AddClubGameEventNewGame implements AddClubGameEvent {
  const factory AddClubGameEventNewGame() = _$AddClubGameEventNewGame;
}
