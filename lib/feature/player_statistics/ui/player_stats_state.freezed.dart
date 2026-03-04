// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_stats_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayerStatsState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  PlayerStatisticsModel? get statistics => throw _privateConstructorUsedError;

  /// Create a copy of PlayerStatsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerStatsStateCopyWith<PlayerStatsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStatsStateCopyWith<$Res> {
  factory $PlayerStatsStateCopyWith(
          PlayerStatsState value, $Res Function(PlayerStatsState) then) =
      _$PlayerStatsStateCopyWithImpl<$Res, PlayerStatsState>;
  @useResult
  $Res call({bool isLoading, bool hasError, PlayerStatisticsModel? statistics});

  $PlayerStatisticsModelCopyWith<$Res>? get statistics;
}

/// @nodoc
class _$PlayerStatsStateCopyWithImpl<$Res, $Val extends PlayerStatsState>
    implements $PlayerStatsStateCopyWith<$Res> {
  _$PlayerStatsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerStatsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? hasError = null,
    Object? statistics = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as PlayerStatisticsModel?,
    ) as $Val);
  }

  /// Create a copy of PlayerStatsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerStatisticsModelCopyWith<$Res>? get statistics {
    if (_value.statistics == null) {
      return null;
    }

    return $PlayerStatisticsModelCopyWith<$Res>(_value.statistics!, (value) {
      return _then(_value.copyWith(statistics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerStatsStateImplCopyWith<$Res>
    implements $PlayerStatsStateCopyWith<$Res> {
  factory _$$PlayerStatsStateImplCopyWith(_$PlayerStatsStateImpl value,
          $Res Function(_$PlayerStatsStateImpl) then) =
      __$$PlayerStatsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, bool hasError, PlayerStatisticsModel? statistics});

  @override
  $PlayerStatisticsModelCopyWith<$Res>? get statistics;
}

/// @nodoc
class __$$PlayerStatsStateImplCopyWithImpl<$Res>
    extends _$PlayerStatsStateCopyWithImpl<$Res, _$PlayerStatsStateImpl>
    implements _$$PlayerStatsStateImplCopyWith<$Res> {
  __$$PlayerStatsStateImplCopyWithImpl(_$PlayerStatsStateImpl _value,
      $Res Function(_$PlayerStatsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerStatsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? hasError = null,
    Object? statistics = freezed,
  }) {
    return _then(_$PlayerStatsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as PlayerStatisticsModel?,
    ));
  }
}

/// @nodoc

class _$PlayerStatsStateImpl implements _PlayerStatsState {
  const _$PlayerStatsStateImpl(
      {this.isLoading = true, this.hasError = false, this.statistics});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool hasError;
  @override
  final PlayerStatisticsModel? statistics;

  @override
  String toString() {
    return 'PlayerStatsState(isLoading: $isLoading, hasError: $hasError, statistics: $statistics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.statistics, statistics) ||
                other.statistics == statistics));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, hasError, statistics);

  /// Create a copy of PlayerStatsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatsStateImplCopyWith<_$PlayerStatsStateImpl> get copyWith =>
      __$$PlayerStatsStateImplCopyWithImpl<_$PlayerStatsStateImpl>(
          this, _$identity);
}

abstract class _PlayerStatsState implements PlayerStatsState {
  const factory _PlayerStatsState(
      {final bool isLoading,
      final bool hasError,
      final PlayerStatisticsModel? statistics}) = _$PlayerStatsStateImpl;

  @override
  bool get isLoading;
  @override
  bool get hasError;
  @override
  PlayerStatisticsModel? get statistics;

  /// Create a copy of PlayerStatsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerStatsStateImplCopyWith<_$PlayerStatsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
