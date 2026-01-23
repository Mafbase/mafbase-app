// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fantasy_current_game_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FantasyCurrentGameInfoModel {
  int get gameNumber => throw _privateConstructorUsedError;
  bool get canPredict => throw _privateConstructorUsedError;
  bool get canParticipate => throw _privateConstructorUsedError;

  /// Create a copy of FantasyCurrentGameInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FantasyCurrentGameInfoModelCopyWith<FantasyCurrentGameInfoModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FantasyCurrentGameInfoModelCopyWith<$Res> {
  factory $FantasyCurrentGameInfoModelCopyWith(
          FantasyCurrentGameInfoModel value,
          $Res Function(FantasyCurrentGameInfoModel) then) =
      _$FantasyCurrentGameInfoModelCopyWithImpl<$Res,
          FantasyCurrentGameInfoModel>;
  @useResult
  $Res call({int gameNumber, bool canPredict, bool canParticipate});
}

/// @nodoc
class _$FantasyCurrentGameInfoModelCopyWithImpl<$Res,
        $Val extends FantasyCurrentGameInfoModel>
    implements $FantasyCurrentGameInfoModelCopyWith<$Res> {
  _$FantasyCurrentGameInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FantasyCurrentGameInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameNumber = null,
    Object? canPredict = null,
    Object? canParticipate = null,
  }) {
    return _then(_value.copyWith(
      gameNumber: null == gameNumber
          ? _value.gameNumber
          : gameNumber // ignore: cast_nullable_to_non_nullable
              as int,
      canPredict: null == canPredict
          ? _value.canPredict
          : canPredict // ignore: cast_nullable_to_non_nullable
              as bool,
      canParticipate: null == canParticipate
          ? _value.canParticipate
          : canParticipate // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FantasyCurrentGameInfoModelImplCopyWith<$Res>
    implements $FantasyCurrentGameInfoModelCopyWith<$Res> {
  factory _$$FantasyCurrentGameInfoModelImplCopyWith(
          _$FantasyCurrentGameInfoModelImpl value,
          $Res Function(_$FantasyCurrentGameInfoModelImpl) then) =
      __$$FantasyCurrentGameInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int gameNumber, bool canPredict, bool canParticipate});
}

/// @nodoc
class __$$FantasyCurrentGameInfoModelImplCopyWithImpl<$Res>
    extends _$FantasyCurrentGameInfoModelCopyWithImpl<$Res,
        _$FantasyCurrentGameInfoModelImpl>
    implements _$$FantasyCurrentGameInfoModelImplCopyWith<$Res> {
  __$$FantasyCurrentGameInfoModelImplCopyWithImpl(
      _$FantasyCurrentGameInfoModelImpl _value,
      $Res Function(_$FantasyCurrentGameInfoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FantasyCurrentGameInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameNumber = null,
    Object? canPredict = null,
    Object? canParticipate = null,
  }) {
    return _then(_$FantasyCurrentGameInfoModelImpl(
      gameNumber: null == gameNumber
          ? _value.gameNumber
          : gameNumber // ignore: cast_nullable_to_non_nullable
              as int,
      canPredict: null == canPredict
          ? _value.canPredict
          : canPredict // ignore: cast_nullable_to_non_nullable
              as bool,
      canParticipate: null == canParticipate
          ? _value.canParticipate
          : canParticipate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FantasyCurrentGameInfoModelImpl
    implements _FantasyCurrentGameInfoModel {
  const _$FantasyCurrentGameInfoModelImpl(
      {required this.gameNumber,
      required this.canPredict,
      required this.canParticipate});

  @override
  final int gameNumber;
  @override
  final bool canPredict;
  @override
  final bool canParticipate;

  @override
  String toString() {
    return 'FantasyCurrentGameInfoModel(gameNumber: $gameNumber, canPredict: $canPredict, canParticipate: $canParticipate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FantasyCurrentGameInfoModelImpl &&
            (identical(other.gameNumber, gameNumber) ||
                other.gameNumber == gameNumber) &&
            (identical(other.canPredict, canPredict) ||
                other.canPredict == canPredict) &&
            (identical(other.canParticipate, canParticipate) ||
                other.canParticipate == canParticipate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, gameNumber, canPredict, canParticipate);

  /// Create a copy of FantasyCurrentGameInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FantasyCurrentGameInfoModelImplCopyWith<_$FantasyCurrentGameInfoModelImpl>
      get copyWith => __$$FantasyCurrentGameInfoModelImplCopyWithImpl<
          _$FantasyCurrentGameInfoModelImpl>(this, _$identity);
}

abstract class _FantasyCurrentGameInfoModel
    implements FantasyCurrentGameInfoModel {
  const factory _FantasyCurrentGameInfoModel(
      {required final int gameNumber,
      required final bool canPredict,
      required final bool canParticipate}) = _$FantasyCurrentGameInfoModelImpl;

  @override
  int get gameNumber;
  @override
  bool get canPredict;
  @override
  bool get canParticipate;

  /// Create a copy of FantasyCurrentGameInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FantasyCurrentGameInfoModelImplCopyWith<_$FantasyCurrentGameInfoModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
