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
    required TResult Function() pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index, PlayerRole role)? changeRole,
    TResult? Function(int index, PlayerStatus status)? changeStatus,
    TResult? Function(int gameIndex)? selectGame,
    TResult? Function(SeatingContent event)? stateReceived,
    TResult? Function()? pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index, PlayerRole role)? changeRole,
    TResult Function(int index, PlayerStatus status)? changeStatus,
    TResult Function(int gameIndex)? selectGame,
    TResult Function(SeatingContent event)? stateReceived,
    TResult Function()? pageOpened,
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
    required TResult Function(TranslationControlEventPageOpened value)
        pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TranslationControlEventChangeRole value)? changeRole,
    TResult? Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult? Function(TranslationControlEventSelectGame value)? selectGame,
    TResult? Function(TranslationControlEventStateReceived value)?
        stateReceived,
    TResult? Function(TranslationControlEventPageOpened value)? pageOpened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TranslationControlEventChangeRole value)? changeRole,
    TResult Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult Function(TranslationControlEventSelectGame value)? selectGame,
    TResult Function(TranslationControlEventStateReceived value)? stateReceived,
    TResult Function(TranslationControlEventPageOpened value)? pageOpened,
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
abstract class _$$TranslationControlEventChangeRoleImplCopyWith<$Res> {
  factory _$$TranslationControlEventChangeRoleImplCopyWith(
          _$TranslationControlEventChangeRoleImpl value,
          $Res Function(_$TranslationControlEventChangeRoleImpl) then) =
      __$$TranslationControlEventChangeRoleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index, PlayerRole role});
}

/// @nodoc
class __$$TranslationControlEventChangeRoleImplCopyWithImpl<$Res>
    extends _$TranslationControlEventCopyWithImpl<$Res,
        _$TranslationControlEventChangeRoleImpl>
    implements _$$TranslationControlEventChangeRoleImplCopyWith<$Res> {
  __$$TranslationControlEventChangeRoleImplCopyWithImpl(
      _$TranslationControlEventChangeRoleImpl _value,
      $Res Function(_$TranslationControlEventChangeRoleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? role = null,
  }) {
    return _then(_$TranslationControlEventChangeRoleImpl(
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

class _$TranslationControlEventChangeRoleImpl
    implements TranslationControlEventChangeRole {
  const _$TranslationControlEventChangeRoleImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationControlEventChangeRoleImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.role, role) || other.role == role));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationControlEventChangeRoleImplCopyWith<
          _$TranslationControlEventChangeRoleImpl>
      get copyWith => __$$TranslationControlEventChangeRoleImplCopyWithImpl<
          _$TranslationControlEventChangeRoleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, PlayerRole role) changeRole,
    required TResult Function(int index, PlayerStatus status) changeStatus,
    required TResult Function(int gameIndex) selectGame,
    required TResult Function(SeatingContent event) stateReceived,
    required TResult Function() pageOpened,
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
    TResult? Function()? pageOpened,
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
    TResult Function()? pageOpened,
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
    required TResult Function(TranslationControlEventPageOpened value)
        pageOpened,
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
    TResult? Function(TranslationControlEventPageOpened value)? pageOpened,
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
    TResult Function(TranslationControlEventPageOpened value)? pageOpened,
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
          {required final int index, required final PlayerRole role}) =
      _$TranslationControlEventChangeRoleImpl;

  int get index;
  PlayerRole get role;
  @JsonKey(ignore: true)
  _$$TranslationControlEventChangeRoleImplCopyWith<
          _$TranslationControlEventChangeRoleImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TranslationControlEventChangeStatusImplCopyWith<$Res> {
  factory _$$TranslationControlEventChangeStatusImplCopyWith(
          _$TranslationControlEventChangeStatusImpl value,
          $Res Function(_$TranslationControlEventChangeStatusImpl) then) =
      __$$TranslationControlEventChangeStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index, PlayerStatus status});
}

/// @nodoc
class __$$TranslationControlEventChangeStatusImplCopyWithImpl<$Res>
    extends _$TranslationControlEventCopyWithImpl<$Res,
        _$TranslationControlEventChangeStatusImpl>
    implements _$$TranslationControlEventChangeStatusImplCopyWith<$Res> {
  __$$TranslationControlEventChangeStatusImplCopyWithImpl(
      _$TranslationControlEventChangeStatusImpl _value,
      $Res Function(_$TranslationControlEventChangeStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? status = null,
  }) {
    return _then(_$TranslationControlEventChangeStatusImpl(
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

class _$TranslationControlEventChangeStatusImpl
    implements TranslationControlEventChangeStatus {
  const _$TranslationControlEventChangeStatusImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationControlEventChangeStatusImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationControlEventChangeStatusImplCopyWith<
          _$TranslationControlEventChangeStatusImpl>
      get copyWith => __$$TranslationControlEventChangeStatusImplCopyWithImpl<
          _$TranslationControlEventChangeStatusImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, PlayerRole role) changeRole,
    required TResult Function(int index, PlayerStatus status) changeStatus,
    required TResult Function(int gameIndex) selectGame,
    required TResult Function(SeatingContent event) stateReceived,
    required TResult Function() pageOpened,
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
    TResult? Function()? pageOpened,
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
    TResult Function()? pageOpened,
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
    required TResult Function(TranslationControlEventPageOpened value)
        pageOpened,
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
    TResult? Function(TranslationControlEventPageOpened value)? pageOpened,
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
    TResult Function(TranslationControlEventPageOpened value)? pageOpened,
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
      _$TranslationControlEventChangeStatusImpl;

  int get index;
  PlayerStatus get status;
  @JsonKey(ignore: true)
  _$$TranslationControlEventChangeStatusImplCopyWith<
          _$TranslationControlEventChangeStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TranslationControlEventSelectGameImplCopyWith<$Res> {
  factory _$$TranslationControlEventSelectGameImplCopyWith(
          _$TranslationControlEventSelectGameImpl value,
          $Res Function(_$TranslationControlEventSelectGameImpl) then) =
      __$$TranslationControlEventSelectGameImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int gameIndex});
}

/// @nodoc
class __$$TranslationControlEventSelectGameImplCopyWithImpl<$Res>
    extends _$TranslationControlEventCopyWithImpl<$Res,
        _$TranslationControlEventSelectGameImpl>
    implements _$$TranslationControlEventSelectGameImplCopyWith<$Res> {
  __$$TranslationControlEventSelectGameImplCopyWithImpl(
      _$TranslationControlEventSelectGameImpl _value,
      $Res Function(_$TranslationControlEventSelectGameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameIndex = null,
  }) {
    return _then(_$TranslationControlEventSelectGameImpl(
      gameIndex: null == gameIndex
          ? _value.gameIndex
          : gameIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TranslationControlEventSelectGameImpl
    implements TranslationControlEventSelectGame {
  const _$TranslationControlEventSelectGameImpl({required this.gameIndex});

  @override
  final int gameIndex;

  @override
  String toString() {
    return 'TranslationControlEvent.selectGame(gameIndex: $gameIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationControlEventSelectGameImpl &&
            (identical(other.gameIndex, gameIndex) ||
                other.gameIndex == gameIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationControlEventSelectGameImplCopyWith<
          _$TranslationControlEventSelectGameImpl>
      get copyWith => __$$TranslationControlEventSelectGameImplCopyWithImpl<
          _$TranslationControlEventSelectGameImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, PlayerRole role) changeRole,
    required TResult Function(int index, PlayerStatus status) changeStatus,
    required TResult Function(int gameIndex) selectGame,
    required TResult Function(SeatingContent event) stateReceived,
    required TResult Function() pageOpened,
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
    TResult? Function()? pageOpened,
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
    TResult Function()? pageOpened,
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
    required TResult Function(TranslationControlEventPageOpened value)
        pageOpened,
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
    TResult? Function(TranslationControlEventPageOpened value)? pageOpened,
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
    TResult Function(TranslationControlEventPageOpened value)? pageOpened,
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
      {required final int gameIndex}) = _$TranslationControlEventSelectGameImpl;

  int get gameIndex;
  @JsonKey(ignore: true)
  _$$TranslationControlEventSelectGameImplCopyWith<
          _$TranslationControlEventSelectGameImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TranslationControlEventStateReceivedImplCopyWith<$Res> {
  factory _$$TranslationControlEventStateReceivedImplCopyWith(
          _$TranslationControlEventStateReceivedImpl value,
          $Res Function(_$TranslationControlEventStateReceivedImpl) then) =
      __$$TranslationControlEventStateReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SeatingContent event});
}

/// @nodoc
class __$$TranslationControlEventStateReceivedImplCopyWithImpl<$Res>
    extends _$TranslationControlEventCopyWithImpl<$Res,
        _$TranslationControlEventStateReceivedImpl>
    implements _$$TranslationControlEventStateReceivedImplCopyWith<$Res> {
  __$$TranslationControlEventStateReceivedImplCopyWithImpl(
      _$TranslationControlEventStateReceivedImpl _value,
      $Res Function(_$TranslationControlEventStateReceivedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
  }) {
    return _then(_$TranslationControlEventStateReceivedImpl(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as SeatingContent,
    ));
  }
}

/// @nodoc

class _$TranslationControlEventStateReceivedImpl
    implements TranslationControlEventStateReceived {
  const _$TranslationControlEventStateReceivedImpl({required this.event});

  @override
  final SeatingContent event;

  @override
  String toString() {
    return 'TranslationControlEvent.stateReceived(event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationControlEventStateReceivedImpl &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(runtimeType, event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationControlEventStateReceivedImplCopyWith<
          _$TranslationControlEventStateReceivedImpl>
      get copyWith => __$$TranslationControlEventStateReceivedImplCopyWithImpl<
          _$TranslationControlEventStateReceivedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, PlayerRole role) changeRole,
    required TResult Function(int index, PlayerStatus status) changeStatus,
    required TResult Function(int gameIndex) selectGame,
    required TResult Function(SeatingContent event) stateReceived,
    required TResult Function() pageOpened,
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
    TResult? Function()? pageOpened,
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
    TResult Function()? pageOpened,
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
    required TResult Function(TranslationControlEventPageOpened value)
        pageOpened,
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
    TResult? Function(TranslationControlEventPageOpened value)? pageOpened,
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
    TResult Function(TranslationControlEventPageOpened value)? pageOpened,
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
      _$TranslationControlEventStateReceivedImpl;

  SeatingContent get event;
  @JsonKey(ignore: true)
  _$$TranslationControlEventStateReceivedImplCopyWith<
          _$TranslationControlEventStateReceivedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TranslationControlEventPageOpenedImplCopyWith<$Res> {
  factory _$$TranslationControlEventPageOpenedImplCopyWith(
          _$TranslationControlEventPageOpenedImpl value,
          $Res Function(_$TranslationControlEventPageOpenedImpl) then) =
      __$$TranslationControlEventPageOpenedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TranslationControlEventPageOpenedImplCopyWithImpl<$Res>
    extends _$TranslationControlEventCopyWithImpl<$Res,
        _$TranslationControlEventPageOpenedImpl>
    implements _$$TranslationControlEventPageOpenedImplCopyWith<$Res> {
  __$$TranslationControlEventPageOpenedImplCopyWithImpl(
      _$TranslationControlEventPageOpenedImpl _value,
      $Res Function(_$TranslationControlEventPageOpenedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TranslationControlEventPageOpenedImpl
    implements TranslationControlEventPageOpened {
  const _$TranslationControlEventPageOpenedImpl();

  @override
  String toString() {
    return 'TranslationControlEvent.pageOpened()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationControlEventPageOpenedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index, PlayerRole role) changeRole,
    required TResult Function(int index, PlayerStatus status) changeStatus,
    required TResult Function(int gameIndex) selectGame,
    required TResult Function(SeatingContent event) stateReceived,
    required TResult Function() pageOpened,
  }) {
    return pageOpened();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index, PlayerRole role)? changeRole,
    TResult? Function(int index, PlayerStatus status)? changeStatus,
    TResult? Function(int gameIndex)? selectGame,
    TResult? Function(SeatingContent event)? stateReceived,
    TResult? Function()? pageOpened,
  }) {
    return pageOpened?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index, PlayerRole role)? changeRole,
    TResult Function(int index, PlayerStatus status)? changeStatus,
    TResult Function(int gameIndex)? selectGame,
    TResult Function(SeatingContent event)? stateReceived,
    TResult Function()? pageOpened,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened();
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
    required TResult Function(TranslationControlEventPageOpened value)
        pageOpened,
  }) {
    return pageOpened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TranslationControlEventChangeRole value)? changeRole,
    TResult? Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult? Function(TranslationControlEventSelectGame value)? selectGame,
    TResult? Function(TranslationControlEventStateReceived value)?
        stateReceived,
    TResult? Function(TranslationControlEventPageOpened value)? pageOpened,
  }) {
    return pageOpened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TranslationControlEventChangeRole value)? changeRole,
    TResult Function(TranslationControlEventChangeStatus value)? changeStatus,
    TResult Function(TranslationControlEventSelectGame value)? selectGame,
    TResult Function(TranslationControlEventStateReceived value)? stateReceived,
    TResult Function(TranslationControlEventPageOpened value)? pageOpened,
    required TResult orElse(),
  }) {
    if (pageOpened != null) {
      return pageOpened(this);
    }
    return orElse();
  }
}

abstract class TranslationControlEventPageOpened
    implements TranslationControlEvent {
  const factory TranslationControlEventPageOpened() =
      _$TranslationControlEventPageOpenedImpl;
}
