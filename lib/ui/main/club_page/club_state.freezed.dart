// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClubState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  ClubModel? get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClubStateCopyWith<ClubState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubStateCopyWith<$Res> {
  factory $ClubStateCopyWith(ClubState value, $Res Function(ClubState) then) =
      _$ClubStateCopyWithImpl<$Res, ClubState>;
  @useResult
  $Res call({dynamic isLoading, ClubModel? model});

  $ClubModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$ClubStateCopyWithImpl<$Res, $Val extends ClubState>
    implements $ClubStateCopyWith<$Res> {
  _$ClubStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? model = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as ClubModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClubModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $ClubModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ClubStateCopyWith<$Res> implements $ClubStateCopyWith<$Res> {
  factory _$$_ClubStateCopyWith(
          _$_ClubState value, $Res Function(_$_ClubState) then) =
      __$$_ClubStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic isLoading, ClubModel? model});

  @override
  $ClubModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_ClubStateCopyWithImpl<$Res>
    extends _$ClubStateCopyWithImpl<$Res, _$_ClubState>
    implements _$$_ClubStateCopyWith<$Res> {
  __$$_ClubStateCopyWithImpl(
      _$_ClubState _value, $Res Function(_$_ClubState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? model = freezed,
  }) {
    return _then(_$_ClubState(
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as ClubModel?,
    ));
  }
}

/// @nodoc

class _$_ClubState implements _ClubState {
  const _$_ClubState({this.isLoading = true, this.model});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final ClubModel? model;

  @override
  String toString() {
    return 'ClubState(isLoading: $isLoading, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClubState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(isLoading), model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClubStateCopyWith<_$_ClubState> get copyWith =>
      __$$_ClubStateCopyWithImpl<_$_ClubState>(this, _$identity);
}

abstract class _ClubState implements ClubState {
  const factory _ClubState({final dynamic isLoading, final ClubModel? model}) =
      _$_ClubState;

  @override
  dynamic get isLoading;
  @override
  ClubModel? get model;
  @override
  @JsonKey(ignore: true)
  _$$_ClubStateCopyWith<_$_ClubState> get copyWith =>
      throw _privateConstructorUsedError;
}
