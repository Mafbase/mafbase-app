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
    required TResult Function(int? gameId, bool viewOnly) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function(DateTime dateTime) newGame,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId, bool viewOnly)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function(DateTime dateTime)? newGame,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId, bool viewOnly)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function(DateTime dateTime)? newGame,
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
abstract class _$$AddClubGameEventPageOpenedImplCopyWith<$Res> {
  factory _$$AddClubGameEventPageOpenedImplCopyWith(
          _$AddClubGameEventPageOpenedImpl value,
          $Res Function(_$AddClubGameEventPageOpenedImpl) then) =
      __$$AddClubGameEventPageOpenedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? gameId, bool viewOnly});
}

/// @nodoc
class __$$AddClubGameEventPageOpenedImplCopyWithImpl<$Res>
    extends _$AddClubGameEventCopyWithImpl<$Res,
        _$AddClubGameEventPageOpenedImpl>
    implements _$$AddClubGameEventPageOpenedImplCopyWith<$Res> {
  __$$AddClubGameEventPageOpenedImplCopyWithImpl(
      _$AddClubGameEventPageOpenedImpl _value,
      $Res Function(_$AddClubGameEventPageOpenedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = freezed,
    Object? viewOnly = null,
  }) {
    return _then(_$AddClubGameEventPageOpenedImpl(
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      viewOnly: null == viewOnly
          ? _value.viewOnly
          : viewOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AddClubGameEventPageOpenedImpl implements AddClubGameEventPageOpened {
  const _$AddClubGameEventPageOpenedImpl({this.gameId, required this.viewOnly});

  @override
  final int? gameId;
  @override
  final bool viewOnly;

  @override
  String toString() {
    return 'AddClubGameEvent.pageOpened(gameId: $gameId, viewOnly: $viewOnly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEventPageOpenedImpl &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.viewOnly, viewOnly) ||
                other.viewOnly == viewOnly));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameId, viewOnly);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClubGameEventPageOpenedImplCopyWith<_$AddClubGameEventPageOpenedImpl>
      get copyWith => __$$AddClubGameEventPageOpenedImplCopyWithImpl<
          _$AddClubGameEventPageOpenedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId, bool viewOnly) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function(DateTime dateTime) newGame,
  }) {
    return pageOpened(gameId, viewOnly);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId, bool viewOnly)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function(DateTime dateTime)? newGame,
  }) {
    return pageOpened?.call(gameId, viewOnly);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId, bool viewOnly)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function(DateTime dateTime)? newGame,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(gameId, viewOnly);
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
  const factory AddClubGameEventPageOpened(
      {final int? gameId,
      required final bool viewOnly}) = _$AddClubGameEventPageOpenedImpl;

  int? get gameId;
  bool get viewOnly;
  @JsonKey(ignore: true)
  _$$AddClubGameEventPageOpenedImplCopyWith<_$AddClubGameEventPageOpenedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddClubGameEventSubmitImplCopyWith<$Res> {
  factory _$$AddClubGameEventSubmitImplCopyWith(
          _$AddClubGameEventSubmitImpl value,
          $Res Function(_$AddClubGameEventSubmitImpl) then) =
      __$$AddClubGameEventSubmitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClubGameResult gameResult, int? gameId});
}

/// @nodoc
class __$$AddClubGameEventSubmitImplCopyWithImpl<$Res>
    extends _$AddClubGameEventCopyWithImpl<$Res, _$AddClubGameEventSubmitImpl>
    implements _$$AddClubGameEventSubmitImplCopyWith<$Res> {
  __$$AddClubGameEventSubmitImplCopyWithImpl(
      _$AddClubGameEventSubmitImpl _value,
      $Res Function(_$AddClubGameEventSubmitImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameResult = null,
    Object? gameId = freezed,
  }) {
    return _then(_$AddClubGameEventSubmitImpl(
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

class _$AddClubGameEventSubmitImpl implements AddClubGameEventSubmit {
  const _$AddClubGameEventSubmitImpl({required this.gameResult, this.gameId});

  @override
  final ClubGameResult gameResult;
  @override
  final int? gameId;

  @override
  String toString() {
    return 'AddClubGameEvent.submit(gameResult: $gameResult, gameId: $gameId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEventSubmitImpl &&
            (identical(other.gameResult, gameResult) ||
                other.gameResult == gameResult) &&
            (identical(other.gameId, gameId) || other.gameId == gameId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameResult, gameId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClubGameEventSubmitImplCopyWith<_$AddClubGameEventSubmitImpl>
      get copyWith => __$$AddClubGameEventSubmitImplCopyWithImpl<
          _$AddClubGameEventSubmitImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId, bool viewOnly) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function(DateTime dateTime) newGame,
  }) {
    return submit(gameResult, gameId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId, bool viewOnly)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function(DateTime dateTime)? newGame,
  }) {
    return submit?.call(gameResult, gameId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId, bool viewOnly)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function(DateTime dateTime)? newGame,
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
      final int? gameId}) = _$AddClubGameEventSubmitImpl;

  ClubGameResult get gameResult;
  int? get gameId;
  @JsonKey(ignore: true)
  _$$AddClubGameEventSubmitImplCopyWith<_$AddClubGameEventSubmitImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddClubGameEventPageEditImplCopyWith<$Res> {
  factory _$$AddClubGameEventPageEditImplCopyWith(
          _$AddClubGameEventPageEditImpl value,
          $Res Function(_$AddClubGameEventPageEditImpl) then) =
      __$$AddClubGameEventPageEditImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int gameId});
}

/// @nodoc
class __$$AddClubGameEventPageEditImplCopyWithImpl<$Res>
    extends _$AddClubGameEventCopyWithImpl<$Res, _$AddClubGameEventPageEditImpl>
    implements _$$AddClubGameEventPageEditImplCopyWith<$Res> {
  __$$AddClubGameEventPageEditImplCopyWithImpl(
      _$AddClubGameEventPageEditImpl _value,
      $Res Function(_$AddClubGameEventPageEditImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
  }) {
    return _then(_$AddClubGameEventPageEditImpl(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AddClubGameEventPageEditImpl implements AddClubGameEventPageEdit {
  const _$AddClubGameEventPageEditImpl({required this.gameId});

  @override
  final int gameId;

  @override
  String toString() {
    return 'AddClubGameEvent.edit(gameId: $gameId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEventPageEditImpl &&
            (identical(other.gameId, gameId) || other.gameId == gameId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClubGameEventPageEditImplCopyWith<_$AddClubGameEventPageEditImpl>
      get copyWith => __$$AddClubGameEventPageEditImplCopyWithImpl<
          _$AddClubGameEventPageEditImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId, bool viewOnly) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function(DateTime dateTime) newGame,
  }) {
    return edit(gameId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId, bool viewOnly)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function(DateTime dateTime)? newGame,
  }) {
    return edit?.call(gameId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId, bool viewOnly)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function(DateTime dateTime)? newGame,
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
      _$AddClubGameEventPageEditImpl;

  int get gameId;
  @JsonKey(ignore: true)
  _$$AddClubGameEventPageEditImplCopyWith<_$AddClubGameEventPageEditImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddClubGameEventNewPlayerImplCopyWith<$Res> {
  factory _$$AddClubGameEventNewPlayerImplCopyWith(
          _$AddClubGameEventNewPlayerImpl value,
          $Res Function(_$AddClubGameEventNewPlayerImpl) then) =
      __$$AddClubGameEventNewPlayerImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index, String nickname});
}

/// @nodoc
class __$$AddClubGameEventNewPlayerImplCopyWithImpl<$Res>
    extends _$AddClubGameEventCopyWithImpl<$Res,
        _$AddClubGameEventNewPlayerImpl>
    implements _$$AddClubGameEventNewPlayerImplCopyWith<$Res> {
  __$$AddClubGameEventNewPlayerImplCopyWithImpl(
      _$AddClubGameEventNewPlayerImpl _value,
      $Res Function(_$AddClubGameEventNewPlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? nickname = null,
  }) {
    return _then(_$AddClubGameEventNewPlayerImpl(
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

class _$AddClubGameEventNewPlayerImpl implements AddClubGameEventNewPlayer {
  const _$AddClubGameEventNewPlayerImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEventNewPlayerImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, nickname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClubGameEventNewPlayerImplCopyWith<_$AddClubGameEventNewPlayerImpl>
      get copyWith => __$$AddClubGameEventNewPlayerImplCopyWithImpl<
          _$AddClubGameEventNewPlayerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId, bool viewOnly) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function(DateTime dateTime) newGame,
  }) {
    return onNewPlayer(index, nickname);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId, bool viewOnly)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function(DateTime dateTime)? newGame,
  }) {
    return onNewPlayer?.call(index, nickname);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId, bool viewOnly)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function(DateTime dateTime)? newGame,
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
      required final String nickname}) = _$AddClubGameEventNewPlayerImpl;

  int get index;
  String get nickname;
  @JsonKey(ignore: true)
  _$$AddClubGameEventNewPlayerImplCopyWith<_$AddClubGameEventNewPlayerImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddClubGameEventNewGameImplCopyWith<$Res> {
  factory _$$AddClubGameEventNewGameImplCopyWith(
          _$AddClubGameEventNewGameImpl value,
          $Res Function(_$AddClubGameEventNewGameImpl) then) =
      __$$AddClubGameEventNewGameImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime dateTime});
}

/// @nodoc
class __$$AddClubGameEventNewGameImplCopyWithImpl<$Res>
    extends _$AddClubGameEventCopyWithImpl<$Res, _$AddClubGameEventNewGameImpl>
    implements _$$AddClubGameEventNewGameImplCopyWith<$Res> {
  __$$AddClubGameEventNewGameImplCopyWithImpl(
      _$AddClubGameEventNewGameImpl _value,
      $Res Function(_$AddClubGameEventNewGameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
  }) {
    return _then(_$AddClubGameEventNewGameImpl(
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$AddClubGameEventNewGameImpl implements AddClubGameEventNewGame {
  const _$AddClubGameEventNewGameImpl({required this.dateTime});

  @override
  final DateTime dateTime;

  @override
  String toString() {
    return 'AddClubGameEvent.newGame(dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddClubGameEventNewGameImpl &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddClubGameEventNewGameImplCopyWith<_$AddClubGameEventNewGameImpl>
      get copyWith => __$$AddClubGameEventNewGameImplCopyWithImpl<
          _$AddClubGameEventNewGameImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? gameId, bool viewOnly) pageOpened,
    required TResult Function(ClubGameResult gameResult, int? gameId) submit,
    required TResult Function(int gameId) edit,
    required TResult Function(int index, String nickname) onNewPlayer,
    required TResult Function(DateTime dateTime) newGame,
  }) {
    return newGame(dateTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? gameId, bool viewOnly)? pageOpened,
    TResult? Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult? Function(int gameId)? edit,
    TResult? Function(int index, String nickname)? onNewPlayer,
    TResult? Function(DateTime dateTime)? newGame,
  }) {
    return newGame?.call(dateTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? gameId, bool viewOnly)? pageOpened,
    TResult Function(ClubGameResult gameResult, int? gameId)? submit,
    TResult Function(int gameId)? edit,
    TResult Function(int index, String nickname)? onNewPlayer,
    TResult Function(DateTime dateTime)? newGame,
    required TResult orElse(),
  }) {
    if (newGame != null) {
      return newGame(dateTime);
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
  const factory AddClubGameEventNewGame({required final DateTime dateTime}) =
      _$AddClubGameEventNewGameImpl;

  DateTime get dateTime;
  @JsonKey(ignore: true)
  _$$AddClubGameEventNewGameImplCopyWith<_$AddClubGameEventNewGameImpl>
      get copyWith => throw _privateConstructorUsedError;
}
