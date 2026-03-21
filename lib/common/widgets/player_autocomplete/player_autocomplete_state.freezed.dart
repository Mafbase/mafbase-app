// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_autocomplete_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayerAutoCompleteState {
  List<PlayerModel> get results => throw _privateConstructorUsedError;
  String? get query => throw _privateConstructorUsedError;

  /// Create a copy of PlayerAutoCompleteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerAutoCompleteStateCopyWith<PlayerAutoCompleteState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerAutoCompleteStateCopyWith<$Res> {
  factory $PlayerAutoCompleteStateCopyWith(PlayerAutoCompleteState value, $Res Function(PlayerAutoCompleteState) then) =
      _$PlayerAutoCompleteStateCopyWithImpl<$Res, PlayerAutoCompleteState>;
  @useResult
  $Res call({List<PlayerModel> results, String? query});
}

/// @nodoc
class _$PlayerAutoCompleteStateCopyWithImpl<$Res, $Val extends PlayerAutoCompleteState>
    implements $PlayerAutoCompleteStateCopyWith<$Res> {
  _$PlayerAutoCompleteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerAutoCompleteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? query = freezed,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerAutoCompleteStateImplCopyWith<$Res> implements $PlayerAutoCompleteStateCopyWith<$Res> {
  factory _$$PlayerAutoCompleteStateImplCopyWith(
          _$PlayerAutoCompleteStateImpl value, $Res Function(_$PlayerAutoCompleteStateImpl) then) =
      __$$PlayerAutoCompleteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PlayerModel> results, String? query});
}

/// @nodoc
class __$$PlayerAutoCompleteStateImplCopyWithImpl<$Res>
    extends _$PlayerAutoCompleteStateCopyWithImpl<$Res, _$PlayerAutoCompleteStateImpl>
    implements _$$PlayerAutoCompleteStateImplCopyWith<$Res> {
  __$$PlayerAutoCompleteStateImplCopyWithImpl(
      _$PlayerAutoCompleteStateImpl _value, $Res Function(_$PlayerAutoCompleteStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerAutoCompleteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? query = freezed,
  }) {
    return _then(_$PlayerAutoCompleteStateImpl(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PlayerAutoCompleteStateImpl implements _PlayerAutoCompleteState {
  const _$PlayerAutoCompleteStateImpl({final List<PlayerModel> results = const [], this.query}) : _results = results;

  final List<PlayerModel> _results;
  @override
  @JsonKey()
  List<PlayerModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  final String? query;

  @override
  String toString() {
    return 'PlayerAutoCompleteState(results: $results, query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerAutoCompleteStateImpl &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_results), query);

  /// Create a copy of PlayerAutoCompleteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerAutoCompleteStateImplCopyWith<_$PlayerAutoCompleteStateImpl> get copyWith =>
      __$$PlayerAutoCompleteStateImplCopyWithImpl<_$PlayerAutoCompleteStateImpl>(this, _$identity);
}

abstract class _PlayerAutoCompleteState implements PlayerAutoCompleteState {
  const factory _PlayerAutoCompleteState({final List<PlayerModel> results, final String? query}) =
      _$PlayerAutoCompleteStateImpl;

  @override
  List<PlayerModel> get results;
  @override
  String? get query;

  /// Create a copy of PlayerAutoCompleteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerAutoCompleteStateImplCopyWith<_$PlayerAutoCompleteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
