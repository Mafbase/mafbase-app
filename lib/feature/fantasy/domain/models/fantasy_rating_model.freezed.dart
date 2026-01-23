// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fantasy_rating_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FantasyRatingModel {
  List<FantasyRatingRowModel> get rows => throw _privateConstructorUsedError;

  /// Create a copy of FantasyRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FantasyRatingModelCopyWith<FantasyRatingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FantasyRatingModelCopyWith<$Res> {
  factory $FantasyRatingModelCopyWith(
          FantasyRatingModel value, $Res Function(FantasyRatingModel) then) =
      _$FantasyRatingModelCopyWithImpl<$Res, FantasyRatingModel>;
  @useResult
  $Res call({List<FantasyRatingRowModel> rows});
}

/// @nodoc
class _$FantasyRatingModelCopyWithImpl<$Res, $Val extends FantasyRatingModel>
    implements $FantasyRatingModelCopyWith<$Res> {
  _$FantasyRatingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FantasyRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
  }) {
    return _then(_value.copyWith(
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<FantasyRatingRowModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FantasyRatingModelImplCopyWith<$Res>
    implements $FantasyRatingModelCopyWith<$Res> {
  factory _$$FantasyRatingModelImplCopyWith(_$FantasyRatingModelImpl value,
          $Res Function(_$FantasyRatingModelImpl) then) =
      __$$FantasyRatingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FantasyRatingRowModel> rows});
}

/// @nodoc
class __$$FantasyRatingModelImplCopyWithImpl<$Res>
    extends _$FantasyRatingModelCopyWithImpl<$Res, _$FantasyRatingModelImpl>
    implements _$$FantasyRatingModelImplCopyWith<$Res> {
  __$$FantasyRatingModelImplCopyWithImpl(_$FantasyRatingModelImpl _value,
      $Res Function(_$FantasyRatingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FantasyRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
  }) {
    return _then(_$FantasyRatingModelImpl(
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<FantasyRatingRowModel>,
    ));
  }
}

/// @nodoc

class _$FantasyRatingModelImpl implements _FantasyRatingModel {
  const _$FantasyRatingModelImpl(
      {required final List<FantasyRatingRowModel> rows})
      : _rows = rows;

  final List<FantasyRatingRowModel> _rows;
  @override
  List<FantasyRatingRowModel> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  String toString() {
    return 'FantasyRatingModel(rows: $rows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FantasyRatingModelImpl &&
            const DeepCollectionEquality().equals(other._rows, _rows));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_rows));

  /// Create a copy of FantasyRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FantasyRatingModelImplCopyWith<_$FantasyRatingModelImpl> get copyWith =>
      __$$FantasyRatingModelImplCopyWithImpl<_$FantasyRatingModelImpl>(
          this, _$identity);
}

abstract class _FantasyRatingModel implements FantasyRatingModel {
  const factory _FantasyRatingModel(
          {required final List<FantasyRatingRowModel> rows}) =
      _$FantasyRatingModelImpl;

  @override
  List<FantasyRatingRowModel> get rows;

  /// Create a copy of FantasyRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FantasyRatingModelImplCopyWith<_$FantasyRatingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
