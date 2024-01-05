// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournaments_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TournamentsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() opened,
    required TResult Function() create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? opened,
    TResult? Function()? create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? opened,
    TResult Function()? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TournamentOpenedEvent value) opened,
    required TResult Function(TournamentsEventCreate value) create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TournamentOpenedEvent value)? opened,
    TResult? Function(TournamentsEventCreate value)? create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TournamentOpenedEvent value)? opened,
    TResult Function(TournamentsEventCreate value)? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentsEventCopyWith<$Res> {
  factory $TournamentsEventCopyWith(
          TournamentsEvent value, $Res Function(TournamentsEvent) then) =
      _$TournamentsEventCopyWithImpl<$Res, TournamentsEvent>;
}

/// @nodoc
class _$TournamentsEventCopyWithImpl<$Res, $Val extends TournamentsEvent>
    implements $TournamentsEventCopyWith<$Res> {
  _$TournamentsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TournamentOpenedEventImplCopyWith<$Res> {
  factory _$$TournamentOpenedEventImplCopyWith(
          _$TournamentOpenedEventImpl value,
          $Res Function(_$TournamentOpenedEventImpl) then) =
      __$$TournamentOpenedEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TournamentOpenedEventImplCopyWithImpl<$Res>
    extends _$TournamentsEventCopyWithImpl<$Res, _$TournamentOpenedEventImpl>
    implements _$$TournamentOpenedEventImplCopyWith<$Res> {
  __$$TournamentOpenedEventImplCopyWithImpl(_$TournamentOpenedEventImpl _value,
      $Res Function(_$TournamentOpenedEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TournamentOpenedEventImpl implements TournamentOpenedEvent {
  const _$TournamentOpenedEventImpl();

  @override
  String toString() {
    return 'TournamentsEvent.opened()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentOpenedEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() opened,
    required TResult Function() create,
  }) {
    return opened();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? opened,
    TResult? Function()? create,
  }) {
    return opened?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? opened,
    TResult Function()? create,
    required TResult orElse(),
  }) {
    if (opened != null) {
      return opened();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TournamentOpenedEvent value) opened,
    required TResult Function(TournamentsEventCreate value) create,
  }) {
    return opened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TournamentOpenedEvent value)? opened,
    TResult? Function(TournamentsEventCreate value)? create,
  }) {
    return opened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TournamentOpenedEvent value)? opened,
    TResult Function(TournamentsEventCreate value)? create,
    required TResult orElse(),
  }) {
    if (opened != null) {
      return opened(this);
    }
    return orElse();
  }
}

abstract class TournamentOpenedEvent implements TournamentsEvent {
  const factory TournamentOpenedEvent() = _$TournamentOpenedEventImpl;
}

/// @nodoc
abstract class _$$TournamentsEventCreateImplCopyWith<$Res> {
  factory _$$TournamentsEventCreateImplCopyWith(
          _$TournamentsEventCreateImpl value,
          $Res Function(_$TournamentsEventCreateImpl) then) =
      __$$TournamentsEventCreateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TournamentsEventCreateImplCopyWithImpl<$Res>
    extends _$TournamentsEventCopyWithImpl<$Res, _$TournamentsEventCreateImpl>
    implements _$$TournamentsEventCreateImplCopyWith<$Res> {
  __$$TournamentsEventCreateImplCopyWithImpl(
      _$TournamentsEventCreateImpl _value,
      $Res Function(_$TournamentsEventCreateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TournamentsEventCreateImpl implements TournamentsEventCreate {
  const _$TournamentsEventCreateImpl();

  @override
  String toString() {
    return 'TournamentsEvent.create()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentsEventCreateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() opened,
    required TResult Function() create,
  }) {
    return create();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? opened,
    TResult? Function()? create,
  }) {
    return create?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? opened,
    TResult Function()? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TournamentOpenedEvent value) opened,
    required TResult Function(TournamentsEventCreate value) create,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TournamentOpenedEvent value)? opened,
    TResult? Function(TournamentsEventCreate value)? create,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TournamentOpenedEvent value)? opened,
    TResult Function(TournamentsEventCreate value)? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }
}

abstract class TournamentsEventCreate implements TournamentsEvent {
  const factory TournamentsEventCreate() = _$TournamentsEventCreateImpl;
}
