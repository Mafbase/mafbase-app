// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'club_rating_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClubRatingRowModel {
  String get nickname => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  double get addScore => throw _privateConstructorUsedError;
  int get wins => throw _privateConstructorUsedError;
  int get roleWins => throw _privateConstructorUsedError;
  int get died => throw _privateConstructorUsedError;
  List<double?> get games => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClubRatingRowModelCopyWith<ClubRatingRowModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubRatingRowModelCopyWith<$Res> {
  factory $ClubRatingRowModelCopyWith(
          ClubRatingRowModel value, $Res Function(ClubRatingRowModel) then) =
      _$ClubRatingRowModelCopyWithImpl<$Res>;
  $Res call(
      {String nickname,
      double score,
      double addScore,
      int wins,
      int roleWins,
      int died,
      List<double?> games});
}

/// @nodoc
class _$ClubRatingRowModelCopyWithImpl<$Res>
    implements $ClubRatingRowModelCopyWith<$Res> {
  _$ClubRatingRowModelCopyWithImpl(this._value, this._then);

  final ClubRatingRowModel _value;
  // ignore: unused_field
  final $Res Function(ClubRatingRowModel) _then;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? score = freezed,
    Object? addScore = freezed,
    Object? wins = freezed,
    Object? roleWins = freezed,
    Object? died = freezed,
    Object? games = freezed,
  }) {
    return _then(_value.copyWith(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      score: score == freezed
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      addScore: addScore == freezed
          ? _value.addScore
          : addScore // ignore: cast_nullable_to_non_nullable
              as double,
      wins: wins == freezed
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      roleWins: roleWins == freezed
          ? _value.roleWins
          : roleWins // ignore: cast_nullable_to_non_nullable
              as int,
      died: died == freezed
          ? _value.died
          : died // ignore: cast_nullable_to_non_nullable
              as int,
      games: games == freezed
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as List<double?>,
    ));
  }
}

/// @nodoc
abstract class _$$_ClubRatingRowModelCopyWith<$Res>
    implements $ClubRatingRowModelCopyWith<$Res> {
  factory _$$_ClubRatingRowModelCopyWith(_$_ClubRatingRowModel value,
          $Res Function(_$_ClubRatingRowModel) then) =
      __$$_ClubRatingRowModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String nickname,
      double score,
      double addScore,
      int wins,
      int roleWins,
      int died,
      List<double?> games});
}

/// @nodoc
class __$$_ClubRatingRowModelCopyWithImpl<$Res>
    extends _$ClubRatingRowModelCopyWithImpl<$Res>
    implements _$$_ClubRatingRowModelCopyWith<$Res> {
  __$$_ClubRatingRowModelCopyWithImpl(
      _$_ClubRatingRowModel _value, $Res Function(_$_ClubRatingRowModel) _then)
      : super(_value, (v) => _then(v as _$_ClubRatingRowModel));

  @override
  _$_ClubRatingRowModel get _value => super._value as _$_ClubRatingRowModel;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? score = freezed,
    Object? addScore = freezed,
    Object? wins = freezed,
    Object? roleWins = freezed,
    Object? died = freezed,
    Object? games = freezed,
  }) {
    return _then(_$_ClubRatingRowModel(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      score: score == freezed
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      addScore: addScore == freezed
          ? _value.addScore
          : addScore // ignore: cast_nullable_to_non_nullable
              as double,
      wins: wins == freezed
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      roleWins: roleWins == freezed
          ? _value.roleWins
          : roleWins // ignore: cast_nullable_to_non_nullable
              as int,
      died: died == freezed
          ? _value.died
          : died // ignore: cast_nullable_to_non_nullable
              as int,
      games: games == freezed
          ? _value._games
          : games // ignore: cast_nullable_to_non_nullable
              as List<double?>,
    ));
  }
}

/// @nodoc

class _$_ClubRatingRowModel implements _ClubRatingRowModel {
  const _$_ClubRatingRowModel(
      {required this.nickname,
      required this.score,
      required this.addScore,
      required this.wins,
      required this.roleWins,
      required this.died,
      required final List<double?> games})
      : _games = games;

  @override
  final String nickname;
  @override
  final double score;
  @override
  final double addScore;
  @override
  final int wins;
  @override
  final int roleWins;
  @override
  final int died;
  final List<double?> _games;
  @override
  List<double?> get games {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_games);
  }

  @override
  String toString() {
    return 'ClubRatingRowModel(nickname: $nickname, score: $score, addScore: $addScore, wins: $wins, roleWins: $roleWins, died: $died, games: $games)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClubRatingRowModel &&
            const DeepCollectionEquality().equals(other.nickname, nickname) &&
            const DeepCollectionEquality().equals(other.score, score) &&
            const DeepCollectionEquality().equals(other.addScore, addScore) &&
            const DeepCollectionEquality().equals(other.wins, wins) &&
            const DeepCollectionEquality().equals(other.roleWins, roleWins) &&
            const DeepCollectionEquality().equals(other.died, died) &&
            const DeepCollectionEquality().equals(other._games, _games));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nickname),
      const DeepCollectionEquality().hash(score),
      const DeepCollectionEquality().hash(addScore),
      const DeepCollectionEquality().hash(wins),
      const DeepCollectionEquality().hash(roleWins),
      const DeepCollectionEquality().hash(died),
      const DeepCollectionEquality().hash(_games));

  @JsonKey(ignore: true)
  @override
  _$$_ClubRatingRowModelCopyWith<_$_ClubRatingRowModel> get copyWith =>
      __$$_ClubRatingRowModelCopyWithImpl<_$_ClubRatingRowModel>(
          this, _$identity);
}

abstract class _ClubRatingRowModel implements ClubRatingRowModel {
  const factory _ClubRatingRowModel(
      {required final String nickname,
      required final double score,
      required final double addScore,
      required final int wins,
      required final int roleWins,
      required final int died,
      required final List<double?> games}) = _$_ClubRatingRowModel;

  @override
  String get nickname;
  @override
  double get score;
  @override
  double get addScore;
  @override
  int get wins;
  @override
  int get roleWins;
  @override
  int get died;
  @override
  List<double?> get games;
  @override
  @JsonKey(ignore: true)
  _$$_ClubRatingRowModelCopyWith<_$_ClubRatingRowModel> get copyWith =>
      throw _privateConstructorUsedError;
}
