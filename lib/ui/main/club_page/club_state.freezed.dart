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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClubState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  ClubModel? get model => throw _privateConstructorUsedError;
  dynamic get isOwner => throw _privateConstructorUsedError;
  DateTime? get hideDate => throw _privateConstructorUsedError;

  /// Create a copy of ClubState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubStateCopyWith<ClubState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubStateCopyWith<$Res> {
  factory $ClubStateCopyWith(ClubState value, $Res Function(ClubState) then) =
      _$ClubStateCopyWithImpl<$Res, ClubState>;
  @useResult
  $Res call(
      {dynamic isLoading,
      ClubModel? model,
      dynamic isOwner,
      DateTime? hideDate});

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

  /// Create a copy of ClubState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? model = freezed,
    Object? isOwner = freezed,
    Object? hideDate = freezed,
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
      isOwner: freezed == isOwner
          ? _value.isOwner
          : isOwner // ignore: cast_nullable_to_non_nullable
              as dynamic,
      hideDate: freezed == hideDate
          ? _value.hideDate
          : hideDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of ClubState
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$ClubStateImplCopyWith<$Res>
    implements $ClubStateCopyWith<$Res> {
  factory _$$ClubStateImplCopyWith(
          _$ClubStateImpl value, $Res Function(_$ClubStateImpl) then) =
      __$$ClubStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic isLoading,
      ClubModel? model,
      dynamic isOwner,
      DateTime? hideDate});

  @override
  $ClubModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$ClubStateImplCopyWithImpl<$Res>
    extends _$ClubStateCopyWithImpl<$Res, _$ClubStateImpl>
    implements _$$ClubStateImplCopyWith<$Res> {
  __$$ClubStateImplCopyWithImpl(
      _$ClubStateImpl _value, $Res Function(_$ClubStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClubState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? model = freezed,
    Object? isOwner = freezed,
    Object? hideDate = freezed,
  }) {
    return _then(_$ClubStateImpl(
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as ClubModel?,
      isOwner: freezed == isOwner ? _value.isOwner! : isOwner,
      hideDate: freezed == hideDate
          ? _value.hideDate
          : hideDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ClubStateImpl implements _ClubState {
  const _$ClubStateImpl(
      {this.isLoading = true, this.model, this.isOwner = false, this.hideDate});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final ClubModel? model;
  @override
  @JsonKey()
  final dynamic isOwner;
  @override
  final DateTime? hideDate;

  @override
  String toString() {
    return 'ClubState(isLoading: $isLoading, model: $model, isOwner: $isOwner, hideDate: $hideDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubStateImpl &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            (identical(other.model, model) || other.model == model) &&
            const DeepCollectionEquality().equals(other.isOwner, isOwner) &&
            (identical(other.hideDate, hideDate) ||
                other.hideDate == hideDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      model,
      const DeepCollectionEquality().hash(isOwner),
      hideDate);

  /// Create a copy of ClubState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubStateImplCopyWith<_$ClubStateImpl> get copyWith =>
      __$$ClubStateImplCopyWithImpl<_$ClubStateImpl>(this, _$identity);
}

abstract class _ClubState implements ClubState {
  const factory _ClubState(
      {final dynamic isLoading,
      final ClubModel? model,
      final dynamic isOwner,
      final DateTime? hideDate}) = _$ClubStateImpl;

  @override
  dynamic get isLoading;
  @override
  ClubModel? get model;
  @override
  dynamic get isOwner;
  @override
  DateTime? get hideDate;

  /// Create a copy of ClubState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubStateImplCopyWith<_$ClubStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
