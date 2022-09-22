// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'seating_inserting_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeatingInsertingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int tournamentId) save,
    required TResult Function(Stream<List<int>> bytesStream) onFileSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int tournamentId)? save,
    TResult Function(Stream<List<int>> bytesStream)? onFileSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int tournamentId)? save,
    TResult Function(Stream<List<int>> bytesStream)? onFileSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SeatingInsertingSaveEvent value) save,
    required TResult Function(SeatingInsertingFileSelectedEvent value)
        onFileSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SeatingInsertingSaveEvent value)? save,
    TResult Function(SeatingInsertingFileSelectedEvent value)? onFileSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SeatingInsertingSaveEvent value)? save,
    TResult Function(SeatingInsertingFileSelectedEvent value)? onFileSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatingInsertingEventCopyWith<$Res> {
  factory $SeatingInsertingEventCopyWith(SeatingInsertingEvent value,
          $Res Function(SeatingInsertingEvent) then) =
      _$SeatingInsertingEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$SeatingInsertingEventCopyWithImpl<$Res>
    implements $SeatingInsertingEventCopyWith<$Res> {
  _$SeatingInsertingEventCopyWithImpl(this._value, this._then);

  final SeatingInsertingEvent _value;
  // ignore: unused_field
  final $Res Function(SeatingInsertingEvent) _then;
}

/// @nodoc
abstract class _$$SeatingInsertingSaveEventCopyWith<$Res> {
  factory _$$SeatingInsertingSaveEventCopyWith(
          _$SeatingInsertingSaveEvent value,
          $Res Function(_$SeatingInsertingSaveEvent) then) =
      __$$SeatingInsertingSaveEventCopyWithImpl<$Res>;
  $Res call({int tournamentId});
}

/// @nodoc
class __$$SeatingInsertingSaveEventCopyWithImpl<$Res>
    extends _$SeatingInsertingEventCopyWithImpl<$Res>
    implements _$$SeatingInsertingSaveEventCopyWith<$Res> {
  __$$SeatingInsertingSaveEventCopyWithImpl(_$SeatingInsertingSaveEvent _value,
      $Res Function(_$SeatingInsertingSaveEvent) _then)
      : super(_value, (v) => _then(v as _$SeatingInsertingSaveEvent));

  @override
  _$SeatingInsertingSaveEvent get _value =>
      super._value as _$SeatingInsertingSaveEvent;

  @override
  $Res call({
    Object? tournamentId = freezed,
  }) {
    return _then(_$SeatingInsertingSaveEvent(
      tournamentId: tournamentId == freezed
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SeatingInsertingSaveEvent implements SeatingInsertingSaveEvent {
  const _$SeatingInsertingSaveEvent({required this.tournamentId});

  @override
  final int tournamentId;

  @override
  String toString() {
    return 'SeatingInsertingEvent.save(tournamentId: $tournamentId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatingInsertingSaveEvent &&
            const DeepCollectionEquality()
                .equals(other.tournamentId, tournamentId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(tournamentId));

  @JsonKey(ignore: true)
  @override
  _$$SeatingInsertingSaveEventCopyWith<_$SeatingInsertingSaveEvent>
      get copyWith => __$$SeatingInsertingSaveEventCopyWithImpl<
          _$SeatingInsertingSaveEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int tournamentId) save,
    required TResult Function(Stream<List<int>> bytesStream) onFileSelected,
  }) {
    return save(tournamentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int tournamentId)? save,
    TResult Function(Stream<List<int>> bytesStream)? onFileSelected,
  }) {
    return save?.call(tournamentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int tournamentId)? save,
    TResult Function(Stream<List<int>> bytesStream)? onFileSelected,
    required TResult orElse(),
  }) {
    if (save != null) {
      return save(tournamentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SeatingInsertingSaveEvent value) save,
    required TResult Function(SeatingInsertingFileSelectedEvent value)
        onFileSelected,
  }) {
    return save(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SeatingInsertingSaveEvent value)? save,
    TResult Function(SeatingInsertingFileSelectedEvent value)? onFileSelected,
  }) {
    return save?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SeatingInsertingSaveEvent value)? save,
    TResult Function(SeatingInsertingFileSelectedEvent value)? onFileSelected,
    required TResult orElse(),
  }) {
    if (save != null) {
      return save(this);
    }
    return orElse();
  }
}

abstract class SeatingInsertingSaveEvent implements SeatingInsertingEvent {
  const factory SeatingInsertingSaveEvent({required final int tournamentId}) =
      _$SeatingInsertingSaveEvent;

  int get tournamentId;
  @JsonKey(ignore: true)
  _$$SeatingInsertingSaveEventCopyWith<_$SeatingInsertingSaveEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SeatingInsertingFileSelectedEventCopyWith<$Res> {
  factory _$$SeatingInsertingFileSelectedEventCopyWith(
          _$SeatingInsertingFileSelectedEvent value,
          $Res Function(_$SeatingInsertingFileSelectedEvent) then) =
      __$$SeatingInsertingFileSelectedEventCopyWithImpl<$Res>;
  $Res call({Stream<List<int>> bytesStream});
}

/// @nodoc
class __$$SeatingInsertingFileSelectedEventCopyWithImpl<$Res>
    extends _$SeatingInsertingEventCopyWithImpl<$Res>
    implements _$$SeatingInsertingFileSelectedEventCopyWith<$Res> {
  __$$SeatingInsertingFileSelectedEventCopyWithImpl(
      _$SeatingInsertingFileSelectedEvent _value,
      $Res Function(_$SeatingInsertingFileSelectedEvent) _then)
      : super(_value, (v) => _then(v as _$SeatingInsertingFileSelectedEvent));

  @override
  _$SeatingInsertingFileSelectedEvent get _value =>
      super._value as _$SeatingInsertingFileSelectedEvent;

  @override
  $Res call({
    Object? bytesStream = freezed,
  }) {
    return _then(_$SeatingInsertingFileSelectedEvent(
      bytesStream: bytesStream == freezed
          ? _value.bytesStream
          : bytesStream // ignore: cast_nullable_to_non_nullable
              as Stream<List<int>>,
    ));
  }
}

/// @nodoc

class _$SeatingInsertingFileSelectedEvent
    implements SeatingInsertingFileSelectedEvent {
  const _$SeatingInsertingFileSelectedEvent({required this.bytesStream});

  @override
  final Stream<List<int>> bytesStream;

  @override
  String toString() {
    return 'SeatingInsertingEvent.onFileSelected(bytesStream: $bytesStream)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatingInsertingFileSelectedEvent &&
            const DeepCollectionEquality()
                .equals(other.bytesStream, bytesStream));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(bytesStream));

  @JsonKey(ignore: true)
  @override
  _$$SeatingInsertingFileSelectedEventCopyWith<
          _$SeatingInsertingFileSelectedEvent>
      get copyWith => __$$SeatingInsertingFileSelectedEventCopyWithImpl<
          _$SeatingInsertingFileSelectedEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int tournamentId) save,
    required TResult Function(Stream<List<int>> bytesStream) onFileSelected,
  }) {
    return onFileSelected(bytesStream);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int tournamentId)? save,
    TResult Function(Stream<List<int>> bytesStream)? onFileSelected,
  }) {
    return onFileSelected?.call(bytesStream);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int tournamentId)? save,
    TResult Function(Stream<List<int>> bytesStream)? onFileSelected,
    required TResult orElse(),
  }) {
    if (onFileSelected != null) {
      return onFileSelected(bytesStream);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SeatingInsertingSaveEvent value) save,
    required TResult Function(SeatingInsertingFileSelectedEvent value)
        onFileSelected,
  }) {
    return onFileSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SeatingInsertingSaveEvent value)? save,
    TResult Function(SeatingInsertingFileSelectedEvent value)? onFileSelected,
  }) {
    return onFileSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SeatingInsertingSaveEvent value)? save,
    TResult Function(SeatingInsertingFileSelectedEvent value)? onFileSelected,
    required TResult orElse(),
  }) {
    if (onFileSelected != null) {
      return onFileSelected(this);
    }
    return orElse();
  }
}

abstract class SeatingInsertingFileSelectedEvent
    implements SeatingInsertingEvent {
  const factory SeatingInsertingFileSelectedEvent(
          {required final Stream<List<int>> bytesStream}) =
      _$SeatingInsertingFileSelectedEvent;

  Stream<List<int>> get bytesStream;
  @JsonKey(ignore: true)
  _$$SeatingInsertingFileSelectedEventCopyWith<
          _$SeatingInsertingFileSelectedEvent>
      get copyWith => throw _privateConstructorUsedError;
}
