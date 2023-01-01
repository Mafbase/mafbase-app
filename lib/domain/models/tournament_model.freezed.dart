// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TournamentModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  TournamentStatus get status => throw _privateConstructorUsedError;
  DateTime get dateStart => throw _privateConstructorUsedError;
  DateTime get dateEnd => throw _privateConstructorUsedError;
  int get gamesCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TournamentModelCopyWith<TournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentModelCopyWith<$Res> {
  factory $TournamentModelCopyWith(
          TournamentModel value, $Res Function(TournamentModel) then) =
      _$TournamentModelCopyWithImpl<$Res, TournamentModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      TournamentStatus status,
      DateTime dateStart,
      DateTime dateEnd,
      int gamesCount});
}

/// @nodoc
class _$TournamentModelCopyWithImpl<$Res, $Val extends TournamentModel>
    implements $TournamentModelCopyWith<$Res> {
  _$TournamentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? dateStart = null,
    Object? dateEnd = null,
    Object? gamesCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TournamentStatus,
      dateStart: null == dateStart
          ? _value.dateStart
          : dateStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateEnd: null == dateEnd
          ? _value.dateEnd
          : dateEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gamesCount: null == gamesCount
          ? _value.gamesCount
          : gamesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TournamentModelCopyWith<$Res>
    implements $TournamentModelCopyWith<$Res> {
  factory _$$_TournamentModelCopyWith(
          _$_TournamentModel value, $Res Function(_$_TournamentModel) then) =
      __$$_TournamentModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      TournamentStatus status,
      DateTime dateStart,
      DateTime dateEnd,
      int gamesCount});
}

/// @nodoc
class __$$_TournamentModelCopyWithImpl<$Res>
    extends _$TournamentModelCopyWithImpl<$Res, _$_TournamentModel>
    implements _$$_TournamentModelCopyWith<$Res> {
  __$$_TournamentModelCopyWithImpl(
      _$_TournamentModel _value, $Res Function(_$_TournamentModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? dateStart = null,
    Object? dateEnd = null,
    Object? gamesCount = null,
  }) {
    return _then(_$_TournamentModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TournamentStatus,
      dateStart: null == dateStart
          ? _value.dateStart
          : dateStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateEnd: null == dateEnd
          ? _value.dateEnd
          : dateEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gamesCount: null == gamesCount
          ? _value.gamesCount
          : gamesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TournamentModel implements _TournamentModel {
  const _$_TournamentModel(
      {required this.id,
      required this.name,
      required this.status,
      required this.dateStart,
      required this.dateEnd,
      required this.gamesCount});

  @override
  final int id;
  @override
  final String name;
  @override
  final TournamentStatus status;
  @override
  final DateTime dateStart;
  @override
  final DateTime dateEnd;
  @override
  final int gamesCount;

  @override
  String toString() {
    return 'TournamentModel(id: $id, name: $name, status: $status, dateStart: $dateStart, dateEnd: $dateEnd, gamesCount: $gamesCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TournamentModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.dateStart, dateStart) ||
                other.dateStart == dateStart) &&
            (identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd) &&
            (identical(other.gamesCount, gamesCount) ||
                other.gamesCount == gamesCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, status, dateStart, dateEnd, gamesCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TournamentModelCopyWith<_$_TournamentModel> get copyWith =>
      __$$_TournamentModelCopyWithImpl<_$_TournamentModel>(this, _$identity);
}

abstract class _TournamentModel implements TournamentModel {
  const factory _TournamentModel(
      {required final int id,
      required final String name,
      required final TournamentStatus status,
      required final DateTime dateStart,
      required final DateTime dateEnd,
      required final int gamesCount}) = _$_TournamentModel;

  @override
  int get id;
  @override
  String get name;
  @override
  TournamentStatus get status;
  @override
  DateTime get dateStart;
  @override
  DateTime get dateEnd;
  @override
  int get gamesCount;
  @override
  @JsonKey(ignore: true)
  _$$_TournamentModelCopyWith<_$_TournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
