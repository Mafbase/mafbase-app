// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RatingState {
  String get clubName => throw _privateConstructorUsedError;
  List<ClubRatingRowModel> get rows => throw _privateConstructorUsedError;
  int get games => throw _privateConstructorUsedError;
  int get mafiaWins => throw _privateConstructorUsedError;
  int get citizenWins => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of RatingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingStateCopyWith<RatingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingStateCopyWith<$Res> {
  factory $RatingStateCopyWith(
          RatingState value, $Res Function(RatingState) then) =
      _$RatingStateCopyWithImpl<$Res, RatingState>;
  @useResult
  $Res call(
      {String clubName,
      List<ClubRatingRowModel> rows,
      int games,
      int mafiaWins,
      int citizenWins,
      bool isLoading});
}

/// @nodoc
class _$RatingStateCopyWithImpl<$Res, $Val extends RatingState>
    implements $RatingStateCopyWith<$Res> {
  _$RatingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubName = null,
    Object? rows = null,
    Object? games = null,
    Object? mafiaWins = null,
    Object? citizenWins = null,
    Object? isLoading = null,
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
      mafiaWins: null == mafiaWins
          ? _value.mafiaWins
          : mafiaWins // ignore: cast_nullable_to_non_nullable
              as int,
      citizenWins: null == citizenWins
          ? _value.citizenWins
          : citizenWins // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RatingStateImplCopyWith<$Res>
    implements $RatingStateCopyWith<$Res> {
  factory _$$RatingStateImplCopyWith(
          _$RatingStateImpl value, $Res Function(_$RatingStateImpl) then) =
      __$$RatingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clubName,
      List<ClubRatingRowModel> rows,
      int games,
      int mafiaWins,
      int citizenWins,
      bool isLoading});
}

/// @nodoc
class __$$RatingStateImplCopyWithImpl<$Res>
    extends _$RatingStateCopyWithImpl<$Res, _$RatingStateImpl>
    implements _$$RatingStateImplCopyWith<$Res> {
  __$$RatingStateImplCopyWithImpl(
      _$RatingStateImpl _value, $Res Function(_$RatingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RatingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubName = null,
    Object? rows = null,
    Object? games = null,
    Object? mafiaWins = null,
    Object? citizenWins = null,
    Object? isLoading = null,
  }) {
    return _then(_$RatingStateImpl(
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
      mafiaWins: null == mafiaWins
          ? _value.mafiaWins
          : mafiaWins // ignore: cast_nullable_to_non_nullable
              as int,
      citizenWins: null == citizenWins
          ? _value.citizenWins
          : citizenWins // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RatingStateImpl implements _RatingState {
  const _$RatingStateImpl(
      {this.clubName = "",
      final List<ClubRatingRowModel> rows = const [],
      this.games = 0,
      this.mafiaWins = 0,
      this.citizenWins = 0,
      this.isLoading = true})
      : _rows = rows;

  @override
  @JsonKey()
  final String clubName;
  final List<ClubRatingRowModel> _rows;
  @override
  @JsonKey()
  List<ClubRatingRowModel> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  @JsonKey()
  final int games;
  @override
  @JsonKey()
  final int mafiaWins;
  @override
  @JsonKey()
  final int citizenWins;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'RatingState(clubName: $clubName, rows: $rows, games: $games, mafiaWins: $mafiaWins, citizenWins: $citizenWins, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingStateImpl &&
            (identical(other.clubName, clubName) ||
                other.clubName == clubName) &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            (identical(other.games, games) || other.games == games) &&
            (identical(other.mafiaWins, mafiaWins) ||
                other.mafiaWins == mafiaWins) &&
            (identical(other.citizenWins, citizenWins) ||
                other.citizenWins == citizenWins) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      clubName,
      const DeepCollectionEquality().hash(_rows),
      games,
      mafiaWins,
      citizenWins,
      isLoading);

  /// Create a copy of RatingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingStateImplCopyWith<_$RatingStateImpl> get copyWith =>
      __$$RatingStateImplCopyWithImpl<_$RatingStateImpl>(this, _$identity);
}

abstract class _RatingState implements RatingState {
  const factory _RatingState(
      {final String clubName,
      final List<ClubRatingRowModel> rows,
      final int games,
      final int mafiaWins,
      final int citizenWins,
      final bool isLoading}) = _$RatingStateImpl;

  @override
  String get clubName;
  @override
  List<ClubRatingRowModel> get rows;
  @override
  int get games;
  @override
  int get mafiaWins;
  @override
  int get citizenWins;
  @override
  bool get isLoading;

  /// Create a copy of RatingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingStateImplCopyWith<_$RatingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
