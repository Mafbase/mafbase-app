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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeatingInsertingState {
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
abstract class _$$_SeatingInsertingStateCopyWith<$Res>
    implements $SeatingInsertingStateCopyWith<$Res> {
  factory _$$_SeatingInsertingStateCopyWith(_$_SeatingInsertingState value,
          $Res Function(_$_SeatingInsertingState) then) =
      __$$_SeatingInsertingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class __$$_SeatingInsertingStateCopyWithImpl<$Res>
    extends _$SeatingInsertingStateCopyWithImpl<$Res, _$_SeatingInsertingState>
    implements _$$_SeatingInsertingStateCopyWith<$Res> {
  __$$_SeatingInsertingStateCopyWithImpl(_$_SeatingInsertingState _value,
      $Res Function(_$_SeatingInsertingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_$_SeatingInsertingState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SeatingInsertingState implements _SeatingInsertingState {
  const _$_SeatingInsertingState({this.isLoading = false});

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'SeatingInsertingState(isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeatingInsertingState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeatingInsertingStateCopyWith<_$_SeatingInsertingState> get copyWith =>
      __$$_SeatingInsertingStateCopyWithImpl<_$_SeatingInsertingState>(
          this, _$identity);
}

abstract class _SeatingInsertingState implements SeatingInsertingState {
  const factory _SeatingInsertingState({final bool isLoading}) =
      _$_SeatingInsertingState;

  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_SeatingInsertingStateCopyWith<_$_SeatingInsertingState> get copyWith =>
      throw _privateConstructorUsedError;
}
