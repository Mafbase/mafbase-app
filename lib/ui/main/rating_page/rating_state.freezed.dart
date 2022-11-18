// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'rating_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RatingState {
  List<ClubRatingRowModel> get rows => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RatingStateCopyWith<RatingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingStateCopyWith<$Res> {
  factory $RatingStateCopyWith(
          RatingState value, $Res Function(RatingState) then) =
      _$RatingStateCopyWithImpl<$Res>;
  $Res call({List<ClubRatingRowModel> rows, bool isLoading});
}

/// @nodoc
class _$RatingStateCopyWithImpl<$Res> implements $RatingStateCopyWith<$Res> {
  _$RatingStateCopyWithImpl(this._value, this._then);

  final RatingState _value;
  // ignore: unused_field
  final $Res Function(RatingState) _then;

  @override
  $Res call({
    Object? rows = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      rows: rows == freezed
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<ClubRatingRowModel>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_RatingStateCopyWith<$Res>
    implements $RatingStateCopyWith<$Res> {
  factory _$$_RatingStateCopyWith(
          _$_RatingState value, $Res Function(_$_RatingState) then) =
      __$$_RatingStateCopyWithImpl<$Res>;
  @override
  $Res call({List<ClubRatingRowModel> rows, bool isLoading});
}

/// @nodoc
class __$$_RatingStateCopyWithImpl<$Res> extends _$RatingStateCopyWithImpl<$Res>
    implements _$$_RatingStateCopyWith<$Res> {
  __$$_RatingStateCopyWithImpl(
      _$_RatingState _value, $Res Function(_$_RatingState) _then)
      : super(_value, (v) => _then(v as _$_RatingState));

  @override
  _$_RatingState get _value => super._value as _$_RatingState;

  @override
  $Res call({
    Object? rows = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_$_RatingState(
      rows: rows == freezed
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<ClubRatingRowModel>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_RatingState implements _RatingState {
  const _$_RatingState(
      {final List<ClubRatingRowModel> rows = const [], this.isLoading = true})
      : _rows = rows;

  final List<ClubRatingRowModel> _rows;
  @override
  @JsonKey()
  List<ClubRatingRowModel> get rows {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'RatingState(rows: $rows, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RatingState &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_rows),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$$_RatingStateCopyWith<_$_RatingState> get copyWith =>
      __$$_RatingStateCopyWithImpl<_$_RatingState>(this, _$identity);
}

abstract class _RatingState implements RatingState {
  const factory _RatingState(
      {final List<ClubRatingRowModel> rows,
      final bool isLoading}) = _$_RatingState;

  @override
  List<ClubRatingRowModel> get rows;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_RatingStateCopyWith<_$_RatingState> get copyWith =>
      throw _privateConstructorUsedError;
}
