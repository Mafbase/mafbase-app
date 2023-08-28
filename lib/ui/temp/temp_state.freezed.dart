// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temp_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TempState {
  TempStyle get style => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempStateCopyWith<TempState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempStateCopyWith<$Res> {
  factory $TempStateCopyWith(TempState value, $Res Function(TempState) then) =
      _$TempStateCopyWithImpl<$Res, TempState>;
  @useResult
  $Res call({TempStyle style});
}

/// @nodoc
class _$TempStateCopyWithImpl<$Res, $Val extends TempState>
    implements $TempStateCopyWith<$Res> {
  _$TempStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? style = null,
  }) {
    return _then(_value.copyWith(
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as TempStyle,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TempStateCopyWith<$Res> implements $TempStateCopyWith<$Res> {
  factory _$$_TempStateCopyWith(
          _$_TempState value, $Res Function(_$_TempState) then) =
      __$$_TempStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TempStyle style});
}

/// @nodoc
class __$$_TempStateCopyWithImpl<$Res>
    extends _$TempStateCopyWithImpl<$Res, _$_TempState>
    implements _$$_TempStateCopyWith<$Res> {
  __$$_TempStateCopyWithImpl(
      _$_TempState _value, $Res Function(_$_TempState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? style = null,
  }) {
    return _then(_$_TempState(
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as TempStyle,
    ));
  }
}

/// @nodoc

class _$_TempState implements _TempState {
  const _$_TempState({required this.style});

  @override
  final TempStyle style;

  @override
  String toString() {
    return 'TempState(style: $style)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TempState &&
            (identical(other.style, style) || other.style == style));
  }

  @override
  int get hashCode => Object.hash(runtimeType, style);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TempStateCopyWith<_$_TempState> get copyWith =>
      __$$_TempStateCopyWithImpl<_$_TempState>(this, _$identity);
}

abstract class _TempState implements TempState {
  const factory _TempState({required final TempStyle style}) = _$_TempState;

  @override
  TempStyle get style;
  @override
  @JsonKey(ignore: true)
  _$$_TempStateCopyWith<_$_TempState> get copyWith =>
      throw _privateConstructorUsedError;
}
