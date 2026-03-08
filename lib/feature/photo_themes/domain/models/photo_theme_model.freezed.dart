// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_theme_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PhotoThemeModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get ownerId => throw _privateConstructorUsedError;
  int get photosCount => throw _privateConstructorUsedError;

  /// Create a copy of PhotoThemeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoThemeModelCopyWith<PhotoThemeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoThemeModelCopyWith<$Res> {
  factory $PhotoThemeModelCopyWith(
          PhotoThemeModel value, $Res Function(PhotoThemeModel) then) =
      _$PhotoThemeModelCopyWithImpl<$Res, PhotoThemeModel>;
  @useResult
  $Res call({int id, String name, int ownerId, int photosCount});
}

/// @nodoc
class _$PhotoThemeModelCopyWithImpl<$Res, $Val extends PhotoThemeModel>
    implements $PhotoThemeModelCopyWith<$Res> {
  _$PhotoThemeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoThemeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ownerId = null,
    Object? photosCount = null,
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
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
      photosCount: null == photosCount
          ? _value.photosCount
          : photosCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhotoThemeModelImplCopyWith<$Res>
    implements $PhotoThemeModelCopyWith<$Res> {
  factory _$$PhotoThemeModelImplCopyWith(_$PhotoThemeModelImpl value,
          $Res Function(_$PhotoThemeModelImpl) then) =
      __$$PhotoThemeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, int ownerId, int photosCount});
}

/// @nodoc
class __$$PhotoThemeModelImplCopyWithImpl<$Res>
    extends _$PhotoThemeModelCopyWithImpl<$Res, _$PhotoThemeModelImpl>
    implements _$$PhotoThemeModelImplCopyWith<$Res> {
  __$$PhotoThemeModelImplCopyWithImpl(
      _$PhotoThemeModelImpl _value, $Res Function(_$PhotoThemeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhotoThemeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ownerId = null,
    Object? photosCount = null,
  }) {
    return _then(_$PhotoThemeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
      photosCount: null == photosCount
          ? _value.photosCount
          : photosCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PhotoThemeModelImpl implements _PhotoThemeModel {
  const _$PhotoThemeModelImpl(
      {required this.id,
      required this.name,
      required this.ownerId,
      required this.photosCount});

  @override
  final int id;
  @override
  final String name;
  @override
  final int ownerId;
  @override
  final int photosCount;

  @override
  String toString() {
    return 'PhotoThemeModel(id: $id, name: $name, ownerId: $ownerId, photosCount: $photosCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoThemeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.photosCount, photosCount) ||
                other.photosCount == photosCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, ownerId, photosCount);

  /// Create a copy of PhotoThemeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoThemeModelImplCopyWith<_$PhotoThemeModelImpl> get copyWith =>
      __$$PhotoThemeModelImplCopyWithImpl<_$PhotoThemeModelImpl>(
          this, _$identity);
}

abstract class _PhotoThemeModel implements PhotoThemeModel {
  const factory _PhotoThemeModel(
      {required final int id,
      required final String name,
      required final int ownerId,
      required final int photosCount}) = _$PhotoThemeModelImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  int get ownerId;
  @override
  int get photosCount;

  /// Create a copy of PhotoThemeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoThemeModelImplCopyWith<_$PhotoThemeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
