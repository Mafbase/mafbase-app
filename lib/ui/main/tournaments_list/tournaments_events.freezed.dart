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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? opened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? opened,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TournamentOpenedEvent value) opened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TournamentOpenedEvent value)? opened,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TournamentOpenedEvent value)? opened,
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
abstract class _$$TournamentOpenedEventCopyWith<$Res> {
  factory _$$TournamentOpenedEventCopyWith(_$TournamentOpenedEvent value,
          $Res Function(_$TournamentOpenedEvent) then) =
      __$$TournamentOpenedEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TournamentOpenedEventCopyWithImpl<$Res>
    extends _$TournamentsEventCopyWithImpl<$Res, _$TournamentOpenedEvent>
    implements _$$TournamentOpenedEventCopyWith<$Res> {
  __$$TournamentOpenedEventCopyWithImpl(_$TournamentOpenedEvent _value,
      $Res Function(_$TournamentOpenedEvent) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TournamentOpenedEvent implements TournamentOpenedEvent {
  const _$TournamentOpenedEvent();

  @override
  String toString() {
    return 'TournamentsEvent.opened()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TournamentOpenedEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() opened,
  }) {
    return opened();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? opened,
  }) {
    return opened?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? opened,
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
  }) {
    return opened(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TournamentOpenedEvent value)? opened,
  }) {
    return opened?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TournamentOpenedEvent value)? opened,
    required TResult orElse(),
  }) {
    if (opened != null) {
      return opened(this);
    }
    return orElse();
  }
}

abstract class TournamentOpenedEvent implements TournamentsEvent {
  const factory TournamentOpenedEvent() = _$TournamentOpenedEvent;
}
