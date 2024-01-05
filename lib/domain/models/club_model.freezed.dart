// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClubModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime? get billedFor => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get groupLink => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClubModelCopyWith<ClubModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubModelCopyWith<$Res> {
  factory $ClubModelCopyWith(ClubModel value, $Res Function(ClubModel) then) =
      _$ClubModelCopyWithImpl<$Res, ClubModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      DateTime? billedFor,
      String? description,
      String? imageUrl,
      String? groupLink,
      String? city});
}

/// @nodoc
class _$ClubModelCopyWithImpl<$Res, $Val extends ClubModel>
    implements $ClubModelCopyWith<$Res> {
  _$ClubModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? billedFor = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? groupLink = freezed,
    Object? city = freezed,
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
      billedFor: freezed == billedFor
          ? _value.billedFor
          : billedFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      groupLink: freezed == groupLink
          ? _value.groupLink
          : groupLink // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubModelImplCopyWith<$Res>
    implements $ClubModelCopyWith<$Res> {
  factory _$$ClubModelImplCopyWith(
          _$ClubModelImpl value, $Res Function(_$ClubModelImpl) then) =
      __$$ClubModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      DateTime? billedFor,
      String? description,
      String? imageUrl,
      String? groupLink,
      String? city});
}

/// @nodoc
class __$$ClubModelImplCopyWithImpl<$Res>
    extends _$ClubModelCopyWithImpl<$Res, _$ClubModelImpl>
    implements _$$ClubModelImplCopyWith<$Res> {
  __$$ClubModelImplCopyWithImpl(
      _$ClubModelImpl _value, $Res Function(_$ClubModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? billedFor = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? groupLink = freezed,
    Object? city = freezed,
  }) {
    return _then(_$ClubModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      billedFor: freezed == billedFor
          ? _value.billedFor
          : billedFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      groupLink: freezed == groupLink
          ? _value.groupLink
          : groupLink // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ClubModelImpl implements _ClubModel {
  const _$ClubModelImpl(
      {required this.id,
      required this.name,
      this.billedFor,
      this.description,
      this.imageUrl,
      this.groupLink,
      this.city});

  @override
  final int id;
  @override
  final String name;
  @override
  final DateTime? billedFor;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final String? groupLink;
  @override
  final String? city;

  @override
  String toString() {
    return 'ClubModel(id: $id, name: $name, billedFor: $billedFor, description: $description, imageUrl: $imageUrl, groupLink: $groupLink, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.billedFor, billedFor) ||
                other.billedFor == billedFor) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.groupLink, groupLink) ||
                other.groupLink == groupLink) &&
            (identical(other.city, city) || other.city == city));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, billedFor, description, imageUrl, groupLink, city);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubModelImplCopyWith<_$ClubModelImpl> get copyWith =>
      __$$ClubModelImplCopyWithImpl<_$ClubModelImpl>(this, _$identity);
}

abstract class _ClubModel implements ClubModel {
  const factory _ClubModel(
      {required final int id,
      required final String name,
      final DateTime? billedFor,
      final String? description,
      final String? imageUrl,
      final String? groupLink,
      final String? city}) = _$ClubModelImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  DateTime? get billedFor;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  String? get groupLink;
  @override
  String? get city;
  @override
  @JsonKey(ignore: true)
  _$$ClubModelImplCopyWith<_$ClubModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
