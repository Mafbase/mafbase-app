// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RatingModel {
  String get clubName => throw _privateConstructorUsedError;
  List<ClubRatingRowModel> get rows => throw _privateConstructorUsedError;
  int get games => throw _privateConstructorUsedError;
  int get citizenWins => throw _privateConstructorUsedError;
  int get mafiaWins => throw _privateConstructorUsedError;

  /// Create a copy of RatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingModelCopyWith<RatingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingModelCopyWith<$Res> {
  factory $RatingModelCopyWith(
          RatingModel value, $Res Function(RatingModel) then) =
      _$RatingModelCopyWithImpl<$Res, RatingModel>;
  @useResult
  $Res call(
      {String clubName,
      List<ClubRatingRowModel> rows,
      int games,
      int citizenWins,
      int mafiaWins});
}

/// @nodoc
class _$RatingModelCopyWithImpl<$Res, $Val extends RatingModel>
    implements $RatingModelCopyWith<$Res> {
  _$RatingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubName = null,
    Object? rows = null,
    Object? games = null,
    Object? citizenWins = null,
    Object? mafiaWins = null,
  }) {
    return _then(_value.copyWith(
      clubName: null == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<ClubRatingRowModel>,
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as int,
      citizenWins: null == citizenWins
          ? _value.citizenWins
          : citizenWins // ignore: cast_nullable_to_non_nullable
              as int,
      mafiaWins: null == mafiaWins
          ? _value.mafiaWins
          : mafiaWins // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RatingModelImplCopyWith<$Res>
    implements $RatingModelCopyWith<$Res> {
  factory _$$RatingModelImplCopyWith(
          _$RatingModelImpl value, $Res Function(_$RatingModelImpl) then) =
      __$$RatingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clubName,
      List<ClubRatingRowModel> rows,
      int games,
      int citizenWins,
      int mafiaWins});
}

/// @nodoc
class __$$RatingModelImplCopyWithImpl<$Res>
    extends _$RatingModelCopyWithImpl<$Res, _$RatingModelImpl>
    implements _$$RatingModelImplCopyWith<$Res> {
  __$$RatingModelImplCopyWithImpl(
      _$RatingModelImpl _value, $Res Function(_$RatingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RatingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubName = null,
    Object? rows = null,
    Object? games = null,
    Object? citizenWins = null,
    Object? mafiaWins = null,
  }) {
    return _then(_$RatingModelImpl(
      clubName: null == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String,
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<ClubRatingRowModel>,
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as int,
      citizenWins: null == citizenWins
          ? _value.citizenWins
          : citizenWins // ignore: cast_nullable_to_non_nullable
              as int,
      mafiaWins: null == mafiaWins
          ? _value.mafiaWins
          : mafiaWins // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RatingModelImpl implements _RatingModel {
  const _$RatingModelImpl(
      {required this.clubName,
      required final List<ClubRatingRowModel> rows,
      required this.games,
      required this.citizenWins,
      required this.mafiaWins})
      : _rows = rows;

  @override
  final String clubName;
  final List<ClubRatingRowModel> _rows;
  @override
  List<ClubRatingRowModel> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  final int games;
  @override
  final int citizenWins;
  @override
  final int mafiaWins;

  @override
  String toString() {
    return 'RatingModel(clubName: $clubName, rows: $rows, games: $games, citizenWins: $citizenWins, mafiaWins: $mafiaWins)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingModelImpl &&
            (identical(other.clubName, clubName) ||
                other.clubName == clubName) &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            (identical(other.games, games) || other.games == games) &&
            (identical(other.citizenWins, citizenWins) ||
                other.citizenWins == citizenWins) &&
            (identical(other.mafiaWins, mafiaWins) ||
                other.mafiaWins == mafiaWins));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      clubName,
      const DeepCollectionEquality().hash(_rows),
      games,
      citizenWins,
      mafiaWins);

  /// Create a copy of RatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingModelImplCopyWith<_$RatingModelImpl> get copyWith =>
      __$$RatingModelImplCopyWithImpl<_$RatingModelImpl>(this, _$identity);
}

abstract class _RatingModel implements RatingModel {
  const factory _RatingModel(
      {required final String clubName,
      required final List<ClubRatingRowModel> rows,
      required final int games,
      required final int citizenWins,
      required final int mafiaWins}) = _$RatingModelImpl;

  @override
  String get clubName;
  @override
  List<ClubRatingRowModel> get rows;
  @override
  int get games;
  @override
  int get citizenWins;
  @override
  int get mafiaWins;

  /// Create a copy of RatingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingModelImplCopyWith<_$RatingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
