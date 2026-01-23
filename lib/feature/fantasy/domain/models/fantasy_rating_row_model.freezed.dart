// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fantasy_rating_row_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FantasyRatingRowModel {
  String get nickname => throw _privateConstructorUsedError;
  List<FantasyPredictionItemModel> get predictions =>
      throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  int get playerId => throw _privateConstructorUsedError;

  /// Create a copy of FantasyRatingRowModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FantasyRatingRowModelCopyWith<FantasyRatingRowModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FantasyRatingRowModelCopyWith<$Res> {
  factory $FantasyRatingRowModelCopyWith(FantasyRatingRowModel value,
          $Res Function(FantasyRatingRowModel) then) =
      _$FantasyRatingRowModelCopyWithImpl<$Res, FantasyRatingRowModel>;
  @useResult
  $Res call(
      {String nickname,
      List<FantasyPredictionItemModel> predictions,
      int totalPoints,
      int playerId});
}

/// @nodoc
class _$FantasyRatingRowModelCopyWithImpl<$Res,
        $Val extends FantasyRatingRowModel>
    implements $FantasyRatingRowModelCopyWith<$Res> {
  _$FantasyRatingRowModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FantasyRatingRowModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? predictions = null,
    Object? totalPoints = null,
    Object? playerId = null,
  }) {
    return _then(_value.copyWith(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      predictions: null == predictions
          ? _value.predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as List<FantasyPredictionItemModel>,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FantasyRatingRowModelImplCopyWith<$Res>
    implements $FantasyRatingRowModelCopyWith<$Res> {
  factory _$$FantasyRatingRowModelImplCopyWith(
          _$FantasyRatingRowModelImpl value,
          $Res Function(_$FantasyRatingRowModelImpl) then) =
      __$$FantasyRatingRowModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nickname,
      List<FantasyPredictionItemModel> predictions,
      int totalPoints,
      int playerId});
}

/// @nodoc
class __$$FantasyRatingRowModelImplCopyWithImpl<$Res>
    extends _$FantasyRatingRowModelCopyWithImpl<$Res,
        _$FantasyRatingRowModelImpl>
    implements _$$FantasyRatingRowModelImplCopyWith<$Res> {
  __$$FantasyRatingRowModelImplCopyWithImpl(_$FantasyRatingRowModelImpl _value,
      $Res Function(_$FantasyRatingRowModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FantasyRatingRowModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? predictions = null,
    Object? totalPoints = null,
    Object? playerId = null,
  }) {
    return _then(_$FantasyRatingRowModelImpl(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      predictions: null == predictions
          ? _value._predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as List<FantasyPredictionItemModel>,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FantasyRatingRowModelImpl implements _FantasyRatingRowModel {
  const _$FantasyRatingRowModelImpl(
      {required this.nickname,
      required final List<FantasyPredictionItemModel> predictions,
      required this.totalPoints,
      required this.playerId})
      : _predictions = predictions;

  @override
  final String nickname;
  final List<FantasyPredictionItemModel> _predictions;
  @override
  List<FantasyPredictionItemModel> get predictions {
    if (_predictions is EqualUnmodifiableListView) return _predictions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_predictions);
  }

  @override
  final int totalPoints;
  @override
  final int playerId;

  @override
  String toString() {
    return 'FantasyRatingRowModel(nickname: $nickname, predictions: $predictions, totalPoints: $totalPoints, playerId: $playerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FantasyRatingRowModelImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            const DeepCollectionEquality()
                .equals(other._predictions, _predictions) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nickname,
      const DeepCollectionEquality().hash(_predictions), totalPoints, playerId);

  /// Create a copy of FantasyRatingRowModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FantasyRatingRowModelImplCopyWith<_$FantasyRatingRowModelImpl>
      get copyWith => __$$FantasyRatingRowModelImplCopyWithImpl<
          _$FantasyRatingRowModelImpl>(this, _$identity);
}

abstract class _FantasyRatingRowModel implements FantasyRatingRowModel {
  const factory _FantasyRatingRowModel(
      {required final String nickname,
      required final List<FantasyPredictionItemModel> predictions,
      required final int totalPoints,
      required final int playerId}) = _$FantasyRatingRowModelImpl;

  @override
  String get nickname;
  @override
  List<FantasyPredictionItemModel> get predictions;
  @override
  int get totalPoints;
  @override
  int get playerId;

  /// Create a copy of FantasyRatingRowModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FantasyRatingRowModelImplCopyWith<_$FantasyRatingRowModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
