// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_control_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TranslationControlEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, PlayerRole role) changeRole,
    required TResult Function(int index, PlayerStatus status) changeStatus,
    required TResult Function(int gameIndex) selectGame,
    required TResult Function(SeatingContent event) stateReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index, PlayerRole role)? changeRole,
    TResult? Function(int index, PlayerStatus status)? changeStatus,
    TResult? Function(int gameIndex)? selectGame,
    TResult? Function(SeatingContent event)? stateReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index, PlayerRole role)? changeRole,
    TResult Function(int index, PlayerStatus status)? changeStatus,
    TResult Function(int gameIndex)? selectGame,
    TResult Function(SeatingContent event)? stateReceived,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TranslationControlEventChangeRole value)
        changeRole,
    required TResult Function(TranslationControlEventChangeStatus value)
        changeStatus,
    required TResult Function(TranslationControlEventSelectGame value)
        selectGame,
    required TResult Function(TranslationControlEventStateReceived value)
        stateReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TranslationControlEventChangeRole value)? changeRole,
    TResult? Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult? Function(TranslationControlEventSelectGame value)? selectGame,
    TResult? Function(TranslationControlEventStateReceived value)?
        stateReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TranslationControlEventChangeRole value)? changeRole,
    TResult Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult Function(TranslationControlEventSelectGame value)? selectGame,
    TResult Function(TranslationControlEventStateReceived value)? stateReceived,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationControlEventCopyWith<$Res> {
  factory $TranslationControlEventCopyWith(TranslationControlEvent value,
          $Res Function(TranslationControlEvent) then) =
      _$TranslationControlEventCopyWithImpl<$Res, TranslationControlEvent>;
}

/// @nodoc
class _$TranslationControlEventCopyWithImpl<$Res,
        $Val extends TranslationControlEvent>
    implements $TranslationControlEventCopyWith<$Res> {
  _$TranslationControlEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TranslationControlEventChangeRoleCopyWith<$Res> {
  factory _$$TranslationControlEventChangeRoleCopyWith(
          _$TranslationControlEventChangeRole value,
          $Res Function(_$TranslationControlEventChangeRole) then) =
      __$$TranslationControlEventChangeRoleCopyWithImpl<$Res>;
  @useResult
  $Res call({int index, PlayerRole role});
}

/// @nodoc
class __$$TranslationControlEventChangeRoleCopyWithImpl<$Res>
    extends _$TranslationControlEventCopyWithImpl<$Res,
        _$TranslationControlEventChangeRole>
    implements _$$TranslationControlEventChangeRoleCopyWith<$Res> {
  __$$TranslationControlEventChangeRoleCopyWithImpl(
      _$TranslationControlEventChangeRole _value,
      $Res Function(_$TranslationControlEventChangeRole) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? role = null,
  }) {
    return _then(_$TranslationControlEventChangeRole(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as PlayerRole,
    ));
  }
}

/// @nodoc

class _$TranslationControlEventChangeRole
    implements TranslationControlEventChangeRole {
  const _$TranslationControlEventChangeRole(
      {required this.index, required this.role});

  @override
  final int index;
  @override
  final PlayerRole role;

  @override
  String toString() {
    return 'TranslationControlEvent.changeRole(index: $index, role: $role)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationControlEventChangeRole &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.role, role) || other.role == role));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationControlEventChangeRoleCopyWith<
          _$TranslationControlEventChangeRole>
      get copyWith => __$$TranslationControlEventChangeRoleCopyWithImpl<
          _$TranslationControlEventChangeRole>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, PlayerRole role) changeRole,
    required TResult Function(int index, PlayerStatus status) changeStatus,
    required TResult Function(int gameIndex) selectGame,
    required TResult Function(SeatingContent event) stateReceived,
  }) {
    return changeRole(index, role);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index, PlayerRole role)? changeRole,
    TResult? Function(int index, PlayerStatus status)? changeStatus,
    TResult? Function(int gameIndex)? selectGame,
    TResult? Function(SeatingContent event)? stateReceived,
  }) {
    return changeRole?.call(index, role);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index, PlayerRole role)? changeRole,
    TResult Function(int index, PlayerStatus status)? changeStatus,
    TResult Function(int gameIndex)? selectGame,
    TResult Function(SeatingContent event)? stateReceived,
    required TResult orElse(),
  }) {
    if (changeRole != null) {
      return changeRole(index, role);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TranslationControlEventChangeRole value)
        changeRole,
    required TResult Function(TranslationControlEventChangeStatus value)
        changeStatus,
    required TResult Function(TranslationControlEventSelectGame value)
        selectGame,
    required TResult Function(TranslationControlEventStateReceived value)
        stateReceived,
  }) {
    return changeRole(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TranslationControlEventChangeRole value)? changeRole,
    TResult? Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult? Function(TranslationControlEventSelectGame value)? selectGame,
    TResult? Function(TranslationControlEventStateReceived value)?
        stateReceived,
  }) {
    return changeRole?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TranslationControlEventChangeRole value)? changeRole,
    TResult Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult Function(TranslationControlEventSelectGame value)? selectGame,
    TResult Function(TranslationControlEventStateReceived value)? stateReceived,
    required TResult orElse(),
  }) {
    if (changeRole != null) {
      return changeRole(this);
    }
    return orElse();
  }
}

abstract class TranslationControlEventChangeRole
    implements TranslationControlEvent {
  const factory TranslationControlEventChangeRole(
      {required final int index,
      required final PlayerRole role}) = _$TranslationControlEventChangeRole;

  int get index;
  PlayerRole get role;
  @JsonKey(ignore: true)
  _$$TranslationControlEventChangeRoleCopyWith<
          _$TranslationControlEventChangeRole>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TranslationControlEventChangeStatusCopyWith<$Res> {
  factory _$$TranslationControlEventChangeStatusCopyWith(
          _$TranslationControlEventChangeStatus value,
          $Res Function(_$TranslationControlEventChangeStatus) then) =
      __$$TranslationControlEventChangeStatusCopyWithImpl<$Res>;
  @useResult
  $Res call({int index, PlayerStatus status});
}

/// @nodoc
class __$$TranslationControlEventChangeStatusCopyWithImpl<$Res>
    extends _$TranslationControlEventCopyWithImpl<$Res,
        _$TranslationControlEventChangeStatus>
    implements _$$TranslationControlEventChangeStatusCopyWith<$Res> {
  __$$TranslationControlEventChangeStatusCopyWithImpl(
      _$TranslationControlEventChangeStatus _value,
      $Res Function(_$TranslationControlEventChangeStatus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? status = null,
  }) {
    return _then(_$TranslationControlEventChangeStatus(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlayerStatus,
    ));
  }
}

/// @nodoc

class _$TranslationControlEventChangeStatus
    implements TranslationControlEventChangeStatus {
  const _$TranslationControlEventChangeStatus(
      {required this.index, required this.status});

  @override
  final int index;
  @override
  final PlayerStatus status;

  @override
  String toString() {
    return 'TranslationControlEvent.changeStatus(index: $index, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationControlEventChangeStatus &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationControlEventChangeStatusCopyWith<
          _$TranslationControlEventChangeStatus>
      get copyWith => __$$TranslationControlEventChangeStatusCopyWithImpl<
          _$TranslationControlEventChangeStatus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, PlayerRole role) changeRole,
    required TResult Function(int index, PlayerStatus status) changeStatus,
    required TResult Function(int gameIndex) selectGame,
    required TResult Function(SeatingContent event) stateReceived,
  }) {
    return changeStatus(index, status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index, PlayerRole role)? changeRole,
    TResult? Function(int index, PlayerStatus status)? changeStatus,
    TResult? Function(int gameIndex)? selectGame,
    TResult? Function(SeatingContent event)? stateReceived,
  }) {
    return changeStatus?.call(index, status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index, PlayerRole role)? changeRole,
    TResult Function(int index, PlayerStatus status)? changeStatus,
    TResult Function(int gameIndex)? selectGame,
    TResult Function(SeatingContent event)? stateReceived,
    required TResult orElse(),
  }) {
    if (changeStatus != null) {
      return changeStatus(index, status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TranslationControlEventChangeRole value)
        changeRole,
    required TResult Function(TranslationControlEventChangeStatus value)
        changeStatus,
    required TResult Function(TranslationControlEventSelectGame value)
        selectGame,
    required TResult Function(TranslationControlEventStateReceived value)
        stateReceived,
  }) {
    return changeStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TranslationControlEventChangeRole value)? changeRole,
    TResult? Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult? Function(TranslationControlEventSelectGame value)? selectGame,
    TResult? Function(TranslationControlEventStateReceived value)?
        stateReceived,
  }) {
    return changeStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TranslationControlEventChangeRole value)? changeRole,
    TResult Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult Function(TranslationControlEventSelectGame value)? selectGame,
    TResult Function(TranslationControlEventStateReceived value)? stateReceived,
    required TResult orElse(),
  }) {
    if (changeStatus != null) {
      return changeStatus(this);
    }
    return orElse();
  }
}

abstract class TranslationControlEventChangeStatus
    implements TranslationControlEvent {
  const factory TranslationControlEventChangeStatus(
          {required final int index, required final PlayerStatus status}) =
      _$TranslationControlEventChangeStatus;

  int get index;
  PlayerStatus get status;
  @JsonKey(ignore: true)
  _$$TranslationControlEventChangeStatusCopyWith<
          _$TranslationControlEventChangeStatus>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TranslationControlEventSelectGameCopyWith<$Res> {
  factory _$$TranslationControlEventSelectGameCopyWith(
          _$TranslationControlEventSelectGame value,
          $Res Function(_$TranslationControlEventSelectGame) then) =
      __$$TranslationControlEventSelectGameCopyWithImpl<$Res>;
  @useResult
  $Res call({int gameIndex});
}

/// @nodoc
class __$$TranslationControlEventSelectGameCopyWithImpl<$Res>
    extends _$TranslationControlEventCopyWithImpl<$Res,
        _$TranslationControlEventSelectGame>
    implements _$$TranslationControlEventSelectGameCopyWith<$Res> {
  __$$TranslationControlEventSelectGameCopyWithImpl(
      _$TranslationControlEventSelectGame _value,
      $Res Function(_$TranslationControlEventSelectGame) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameIndex = null,
  }) {
    return _then(_$TranslationControlEventSelectGame(
      gameIndex: null == gameIndex
          ? _value.gameIndex
          : gameIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TranslationControlEventSelectGame
    implements TranslationControlEventSelectGame {
  const _$TranslationControlEventSelectGame({required this.gameIndex});

  @override
  final int gameIndex;

  @override
  String toString() {
    return 'TranslationControlEvent.selectGame(gameIndex: $gameIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationControlEventSelectGame &&
            (identical(other.gameIndex, gameIndex) ||
                other.gameIndex == gameIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationControlEventSelectGameCopyWith<
          _$TranslationControlEventSelectGame>
      get copyWith => __$$TranslationControlEventSelectGameCopyWithImpl<
          _$TranslationControlEventSelectGame>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, PlayerRole role) changeRole,
    required TResult Function(int index, PlayerStatus status) changeStatus,
    required TResult Function(int gameIndex) selectGame,
    required TResult Function(SeatingContent event) stateReceived,
  }) {
    return selectGame(gameIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index, PlayerRole role)? changeRole,
    TResult? Function(int index, PlayerStatus status)? changeStatus,
    TResult? Function(int gameIndex)? selectGame,
    TResult? Function(SeatingContent event)? stateReceived,
  }) {
    return selectGame?.call(gameIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index, PlayerRole role)? changeRole,
    TResult Function(int index, PlayerStatus status)? changeStatus,
    TResult Function(int gameIndex)? selectGame,
    TResult Function(SeatingContent event)? stateReceived,
    required TResult orElse(),
  }) {
    if (selectGame != null) {
      return selectGame(gameIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TranslationControlEventChangeRole value)
        changeRole,
    required TResult Function(TranslationControlEventChangeStatus value)
        changeStatus,
    required TResult Function(TranslationControlEventSelectGame value)
        selectGame,
    required TResult Function(TranslationControlEventStateReceived value)
        stateReceived,
  }) {
    return selectGame(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TranslationControlEventChangeRole value)? changeRole,
    TResult? Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult? Function(TranslationControlEventSelectGame value)? selectGame,
    TResult? Function(TranslationControlEventStateReceived value)?
        stateReceived,
  }) {
    return selectGame?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TranslationControlEventChangeRole value)? changeRole,
    TResult Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult Function(TranslationControlEventSelectGame value)? selectGame,
    TResult Function(TranslationControlEventStateReceived value)? stateReceived,
    required TResult orElse(),
  }) {
    if (selectGame != null) {
      return selectGame(this);
    }
    return orElse();
  }
}

abstract class TranslationControlEventSelectGame
    implements TranslationControlEvent {
  const factory TranslationControlEventSelectGame(
      {required final int gameIndex}) = _$TranslationControlEventSelectGame;

  int get gameIndex;
  @JsonKey(ignore: true)
  _$$TranslationControlEventSelectGameCopyWith<
          _$TranslationControlEventSelectGame>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TranslationControlEventStateReceivedCopyWith<$Res> {
  factory _$$TranslationControlEventStateReceivedCopyWith(
          _$TranslationControlEventStateReceived value,
          $Res Function(_$TranslationControlEventStateReceived) then) =
      __$$TranslationControlEventStateReceivedCopyWithImpl<$Res>;
  @useResult
  $Res call({SeatingContent event});
}

/// @nodoc
class __$$TranslationControlEventStateReceivedCopyWithImpl<$Res>
    extends _$TranslationControlEventCopyWithImpl<$Res,
        _$TranslationControlEventStateReceived>
    implements _$$TranslationControlEventStateReceivedCopyWith<$Res> {
  __$$TranslationControlEventStateReceivedCopyWithImpl(
      _$TranslationControlEventStateReceived _value,
      $Res Function(_$TranslationControlEventStateReceived) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
  }) {
    return _then(_$TranslationControlEventStateReceived(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as SeatingContent,
    ));
  }
}

/// @nodoc

class _$TranslationControlEventStateReceived
    implements TranslationControlEventStateReceived {
  const _$TranslationControlEventStateReceived({required this.event});

  @override
  final SeatingContent event;

  @override
  String toString() {
    return 'TranslationControlEvent.stateReceived(event: $event)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationControlEventStateReceived &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(runtimeType, event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationControlEventStateReceivedCopyWith<
          _$TranslationControlEventStateReceived>
      get copyWith => __$$TranslationControlEventStateReceivedCopyWithImpl<
          _$TranslationControlEventStateReceived>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, PlayerRole role) changeRole,
    required TResult Function(int index, PlayerStatus status) changeStatus,
    required TResult Function(int gameIndex) selectGame,
    required TResult Function(SeatingContent event) stateReceived,
  }) {
    return stateReceived(event);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index, PlayerRole role)? changeRole,
    TResult? Function(int index, PlayerStatus status)? changeStatus,
    TResult? Function(int gameIndex)? selectGame,
    TResult? Function(SeatingContent event)? stateReceived,
  }) {
    return stateReceived?.call(event);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index, PlayerRole role)? changeRole,
    TResult Function(int index, PlayerStatus status)? changeStatus,
    TResult Function(int gameIndex)? selectGame,
    TResult Function(SeatingContent event)? stateReceived,
    required TResult orElse(),
  }) {
    if (stateReceived != null) {
      return stateReceived(event);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TranslationControlEventChangeRole value)
        changeRole,
    required TResult Function(TranslationControlEventChangeStatus value)
        changeStatus,
    required TResult Function(TranslationControlEventSelectGame value)
        selectGame,
    required TResult Function(TranslationControlEventStateReceived value)
        stateReceived,
  }) {
    return stateReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TranslationControlEventChangeRole value)? changeRole,
    TResult? Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult? Function(TranslationControlEventSelectGame value)? selectGame,
    TResult? Function(TranslationControlEventStateReceived value)?
        stateReceived,
  }) {
    return stateReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TranslationControlEventChangeRole value)? changeRole,
    TResult Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult Function(TranslationControlEventSelectGame value)? selectGame,
    TResult Function(TranslationControlEventStateReceived value)? stateReceived,
    required TResult orElse(),
  }) {
    if (stateReceived != null) {
      return stateReceived(this);
    }
    return orElse();
  }
}

abstract class TranslationControlEventStateReceived
    implements TranslationControlEvent {
  const factory TranslationControlEventStateReceived(
          {required final SeatingContent event}) =
      _$TranslationControlEventStateReceived;

  SeatingContent get event;
  @JsonKey(ignore: true)
  _$$TranslationControlEventStateReceivedCopyWith<
          _$TranslationControlEventStateReceived>
      get copyWith => throw _privateConstructorUsedError;
}
