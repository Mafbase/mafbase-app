// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  int get participantsCount => throw _privateConstructorUsedError;
  TournamentStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TournamentModelCopyWith<TournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentModelCopyWith<$Res> {
  factory $TournamentModelCopyWith(
          TournamentModel value, $Res Function(TournamentModel) then) =
      _$TournamentModelCopyWithImpl<$Res>;
  $Res call(
      {int id, String name, int participantsCount, TournamentStatus status});
}

/// @nodoc
class _$TournamentModelCopyWithImpl<$Res>
    implements $TournamentModelCopyWith<$Res> {
  _$TournamentModelCopyWithImpl(this._value, this._then);

  final TournamentModel _value;
  // ignore: unused_field
  final $Res Function(TournamentModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? participantsCount = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      participantsCount: participantsCount == freezed
          ? _value.participantsCount
          : participantsCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TournamentStatus,
    ));
  }
}

/// @nodoc
abstract class _$$_TournamentModelCopyWith<$Res>
    implements $TournamentModelCopyWith<$Res> {
  factory _$$_TournamentModelCopyWith(
          _$_TournamentModel value, $Res Function(_$_TournamentModel) then) =
      __$$_TournamentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id, String name, int participantsCount, TournamentStatus status});
}

/// @nodoc
class __$$_TournamentModelCopyWithImpl<$Res>
    extends _$TournamentModelCopyWithImpl<$Res>
    implements _$$_TournamentModelCopyWith<$Res> {
  __$$_TournamentModelCopyWithImpl(
      _$_TournamentModel _value, $Res Function(_$_TournamentModel) _then)
      : super(_value, (v) => _then(v as _$_TournamentModel));

  @override
  _$_TournamentModel get _value => super._value as _$_TournamentModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? participantsCount = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_TournamentModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      participantsCount: participantsCount == freezed
          ? _value.participantsCount
          : participantsCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TournamentStatus,
    ));
  }
}

/// @nodoc

class _$_TournamentModel implements _TournamentModel {
  const _$_TournamentModel(
      {required this.id,
      required this.name,
      required this.participantsCount,
      required this.status});

  @override
  final int id;
  @override
  final String name;
  @override
  final int participantsCount;
  @override
  final TournamentStatus status;

  @override
  String toString() {
    return 'TournamentModel(id: $id, name: $name, participantsCount: $participantsCount, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TournamentModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.participantsCount, participantsCount) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(participantsCount),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_TournamentModelCopyWith<_$_TournamentModel> get copyWith =>
      __$$_TournamentModelCopyWithImpl<_$_TournamentModel>(this, _$identity);
}

abstract class _TournamentModel implements TournamentModel {
  const factory _TournamentModel(
      {required final int id,
      required final String name,
      required final int participantsCount,
      required final TournamentStatus status}) = _$_TournamentModel;

  @override
  int get id;
  @override
  String get name;
  @override
  int get participantsCount;
  @override
  TournamentStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_TournamentModelCopyWith<_$_TournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
