// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_autocomplete_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayerAutoCompleteEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) search,
    required TResult Function() clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? search,
    TResult? Function()? clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? search,
    TResult Function()? clear,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlayerAutoCompleteEventSearch value) search,
    required TResult Function(PlayerAutoCompleteEventClear value) clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlayerAutoCompleteEventSearch value)? search,
    TResult? Function(PlayerAutoCompleteEventClear value)? clear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlayerAutoCompleteEventSearch value)? search,
    TResult Function(PlayerAutoCompleteEventClear value)? clear,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerAutoCompleteEventCopyWith<$Res> {
  factory $PlayerAutoCompleteEventCopyWith(PlayerAutoCompleteEvent value, $Res Function(PlayerAutoCompleteEvent) then) =
      _$PlayerAutoCompleteEventCopyWithImpl<$Res, PlayerAutoCompleteEvent>;
}

/// @nodoc
class _$PlayerAutoCompleteEventCopyWithImpl<$Res, $Val extends PlayerAutoCompleteEvent>
    implements $PlayerAutoCompleteEventCopyWith<$Res> {
  _$PlayerAutoCompleteEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerAutoCompleteEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PlayerAutoCompleteEventSearchImplCopyWith<$Res> {
  factory _$$PlayerAutoCompleteEventSearchImplCopyWith(
          _$PlayerAutoCompleteEventSearchImpl value, $Res Function(_$PlayerAutoCompleteEventSearchImpl) then) =
      __$$PlayerAutoCompleteEventSearchImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$PlayerAutoCompleteEventSearchImplCopyWithImpl<$Res>
    extends _$PlayerAutoCompleteEventCopyWithImpl<$Res, _$PlayerAutoCompleteEventSearchImpl>
    implements _$$PlayerAutoCompleteEventSearchImplCopyWith<$Res> {
  __$$PlayerAutoCompleteEventSearchImplCopyWithImpl(
      _$PlayerAutoCompleteEventSearchImpl _value, $Res Function(_$PlayerAutoCompleteEventSearchImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerAutoCompleteEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$PlayerAutoCompleteEventSearchImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PlayerAutoCompleteEventSearchImpl implements PlayerAutoCompleteEventSearch {
  const _$PlayerAutoCompleteEventSearchImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'PlayerAutoCompleteEvent.search(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerAutoCompleteEventSearchImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of PlayerAutoCompleteEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerAutoCompleteEventSearchImplCopyWith<_$PlayerAutoCompleteEventSearchImpl> get copyWith =>
      __$$PlayerAutoCompleteEventSearchImplCopyWithImpl<_$PlayerAutoCompleteEventSearchImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) search,
    required TResult Function() clear,
  }) {
    return search(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? search,
    TResult? Function()? clear,
  }) {
    return search?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? search,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlayerAutoCompleteEventSearch value) search,
    required TResult Function(PlayerAutoCompleteEventClear value) clear,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlayerAutoCompleteEventSearch value)? search,
    TResult? Function(PlayerAutoCompleteEventClear value)? clear,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlayerAutoCompleteEventSearch value)? search,
    TResult Function(PlayerAutoCompleteEventClear value)? clear,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class PlayerAutoCompleteEventSearch implements PlayerAutoCompleteEvent {
  const factory PlayerAutoCompleteEventSearch(final String query) = _$PlayerAutoCompleteEventSearchImpl;

  String get query;

  /// Create a copy of PlayerAutoCompleteEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerAutoCompleteEventSearchImplCopyWith<_$PlayerAutoCompleteEventSearchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PlayerAutoCompleteEventClearImplCopyWith<$Res> {
  factory _$$PlayerAutoCompleteEventClearImplCopyWith(
          _$PlayerAutoCompleteEventClearImpl value, $Res Function(_$PlayerAutoCompleteEventClearImpl) then) =
      __$$PlayerAutoCompleteEventClearImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlayerAutoCompleteEventClearImplCopyWithImpl<$Res>
    extends _$PlayerAutoCompleteEventCopyWithImpl<$Res, _$PlayerAutoCompleteEventClearImpl>
    implements _$$PlayerAutoCompleteEventClearImplCopyWith<$Res> {
  __$$PlayerAutoCompleteEventClearImplCopyWithImpl(
      _$PlayerAutoCompleteEventClearImpl _value, $Res Function(_$PlayerAutoCompleteEventClearImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerAutoCompleteEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PlayerAutoCompleteEventClearImpl implements PlayerAutoCompleteEventClear {
  const _$PlayerAutoCompleteEventClearImpl();

  @override
  String toString() {
    return 'PlayerAutoCompleteEvent.clear()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$PlayerAutoCompleteEventClearImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) search,
    required TResult Function() clear,
  }) {
    return clear();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? search,
    TResult? Function()? clear,
  }) {
    return clear?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? search,
    TResult Function()? clear,
    required TResult orElse(),
  }) {
    if (clear != null) {
      return clear();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlayerAutoCompleteEventSearch value) search,
    required TResult Function(PlayerAutoCompleteEventClear value) clear,
  }) {
    return clear(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlayerAutoCompleteEventSearch value)? search,
    TResult? Function(PlayerAutoCompleteEventClear value)? clear,
  }) {
    return clear?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlayerAutoCompleteEventSearch value)? search,
    TResult Function(PlayerAutoCompleteEventClear value)? clear,
    required TResult orElse(),
  }) {
    if (clear != null) {
      return clear(this);
    }
    return orElse();
  }
}

abstract class PlayerAutoCompleteEventClear implements PlayerAutoCompleteEvent {
  const factory PlayerAutoCompleteEventClear() = _$PlayerAutoCompleteEventClearImpl;
}
