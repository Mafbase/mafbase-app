// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fantasy_prediction_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FantasyPredictionItemModel {
  int get gameNumber => throw _privateConstructorUsedError;
  GameWin? get prediction => throw _privateConstructorUsedError;
  GameWin? get actualResult => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  /// Create a copy of FantasyPredictionItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FantasyPredictionItemModelCopyWith<FantasyPredictionItemModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FantasyPredictionItemModelCopyWith<$Res> {
  factory $FantasyPredictionItemModelCopyWith(FantasyPredictionItemModel value,
          $Res Function(FantasyPredictionItemModel) then) =
      _$FantasyPredictionItemModelCopyWithImpl<$Res,
          FantasyPredictionItemModel>;
  @useResult
  $Res call(
      {int gameNumber, GameWin? prediction, GameWin? actualResult, int points});
}

/// @nodoc
class _$FantasyPredictionItemModelCopyWithImpl<$Res,
        $Val extends FantasyPredictionItemModel>
    implements $FantasyPredictionItemModelCopyWith<$Res> {
  _$FantasyPredictionItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FantasyPredictionItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameNumber = null,
    Object? prediction = freezed,
    Object? actualResult = freezed,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      gameNumber: null == gameNumber
          ? _value.gameNumber
          : gameNumber // ignore: cast_nullable_to_non_nullable
              as int,
      prediction: freezed == prediction
          ? _value.prediction
          : prediction // ignore: cast_nullable_to_non_nullable
              as GameWin?,
      actualResult: freezed == actualResult
          ? _value.actualResult
          : actualResult // ignore: cast_nullable_to_non_nullable
              as GameWin?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FantasyPredictionItemModelImplCopyWith<$Res>
    implements $FantasyPredictionItemModelCopyWith<$Res> {
  factory _$$FantasyPredictionItemModelImplCopyWith(
          _$FantasyPredictionItemModelImpl value,
          $Res Function(_$FantasyPredictionItemModelImpl) then) =
      __$$FantasyPredictionItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int gameNumber, GameWin? prediction, GameWin? actualResult, int points});
}

/// @nodoc
class __$$FantasyPredictionItemModelImplCopyWithImpl<$Res>
    extends _$FantasyPredictionItemModelCopyWithImpl<$Res,
        _$FantasyPredictionItemModelImpl>
    implements _$$FantasyPredictionItemModelImplCopyWith<$Res> {
  __$$FantasyPredictionItemModelImplCopyWithImpl(
      _$FantasyPredictionItemModelImpl _value,
      $Res Function(_$FantasyPredictionItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FantasyPredictionItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameNumber = null,
    Object? prediction = freezed,
    Object? actualResult = freezed,
    Object? points = null,
  }) {
    return _then(_$FantasyPredictionItemModelImpl(
      gameNumber: null == gameNumber
          ? _value.gameNumber
          : gameNumber // ignore: cast_nullable_to_non_nullable
              as int,
      prediction: freezed == prediction
          ? _value.prediction
          : prediction // ignore: cast_nullable_to_non_nullable
              as GameWin?,
      actualResult: freezed == actualResult
          ? _value.actualResult
          : actualResult // ignore: cast_nullable_to_non_nullable
              as GameWin?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FantasyPredictionItemModelImpl implements _FantasyPredictionItemModel {
  const _$FantasyPredictionItemModelImpl(
      {required this.gameNumber,
      this.prediction,
      this.actualResult,
      required this.points});

  @override
  final int gameNumber;
  @override
  final GameWin? prediction;
  @override
  final GameWin? actualResult;
  @override
  final int points;

  @override
  String toString() {
    return 'FantasyPredictionItemModel(gameNumber: $gameNumber, prediction: $prediction, actualResult: $actualResult, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FantasyPredictionItemModelImpl &&
            (identical(other.gameNumber, gameNumber) ||
                other.gameNumber == gameNumber) &&
            (identical(other.prediction, prediction) ||
                other.prediction == prediction) &&
            (identical(other.actualResult, actualResult) ||
                other.actualResult == actualResult) &&
            (identical(other.points, points) || other.points == points));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, gameNumber, prediction, actualResult, points);

  /// Create a copy of FantasyPredictionItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FantasyPredictionItemModelImplCopyWith<_$FantasyPredictionItemModelImpl>
      get copyWith => __$$FantasyPredictionItemModelImplCopyWithImpl<
          _$FantasyPredictionItemModelImpl>(this, _$identity);
}

abstract class _FantasyPredictionItemModel
    implements FantasyPredictionItemModel {
  const factory _FantasyPredictionItemModel(
      {required final int gameNumber,
      final GameWin? prediction,
      final GameWin? actualResult,
      required final int points}) = _$FantasyPredictionItemModelImpl;

  @override
  int get gameNumber;
  @override
  GameWin? get prediction;
  @override
  GameWin? get actualResult;
  @override
  int get points;

  /// Create a copy of FantasyPredictionItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FantasyPredictionItemModelImplCopyWith<_$FantasyPredictionItemModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
