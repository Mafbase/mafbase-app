// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seating_inserting_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SeatingInsertingState {
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of SeatingInsertingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeatingInsertingStateCopyWith<SeatingInsertingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatingInsertingStateCopyWith<$Res> {
  factory $SeatingInsertingStateCopyWith(SeatingInsertingState value,
          $Res Function(SeatingInsertingState) then) =
      _$SeatingInsertingStateCopyWithImpl<$Res, SeatingInsertingState>;
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class _$SeatingInsertingStateCopyWithImpl<$Res,
        $Val extends SeatingInsertingState>
    implements $SeatingInsertingStateCopyWith<$Res> {
  _$SeatingInsertingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeatingInsertingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeatingInsertingStateImplCopyWith<$Res>
    implements $SeatingInsertingStateCopyWith<$Res> {
  factory _$$SeatingInsertingStateImplCopyWith(
          _$SeatingInsertingStateImpl value,
          $Res Function(_$SeatingInsertingStateImpl) then) =
      __$$SeatingInsertingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class __$$SeatingInsertingStateImplCopyWithImpl<$Res>
    extends _$SeatingInsertingStateCopyWithImpl<$Res,
        _$SeatingInsertingStateImpl>
    implements _$$SeatingInsertingStateImplCopyWith<$Res> {
  __$$SeatingInsertingStateImplCopyWithImpl(_$SeatingInsertingStateImpl _value,
      $Res Function(_$SeatingInsertingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SeatingInsertingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_$SeatingInsertingStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SeatingInsertingStateImpl implements _SeatingInsertingState {
  const _$SeatingInsertingStateImpl({this.isLoading = false});

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'SeatingInsertingState(isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatingInsertingStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading);

  /// Create a copy of SeatingInsertingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatingInsertingStateImplCopyWith<_$SeatingInsertingStateImpl>
      get copyWith => __$$SeatingInsertingStateImplCopyWithImpl<
          _$SeatingInsertingStateImpl>(this, _$identity);
}

abstract class _SeatingInsertingState implements SeatingInsertingState {
  const factory _SeatingInsertingState({final bool isLoading}) =
      _$SeatingInsertingStateImpl;

  @override
  bool get isLoading;

  /// Create a copy of SeatingInsertingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeatingInsertingStateImplCopyWith<_$SeatingInsertingStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
