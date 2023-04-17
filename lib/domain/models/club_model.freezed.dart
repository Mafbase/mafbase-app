// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
abstract class _$$_ClubModelCopyWith<$Res> implements $ClubModelCopyWith<$Res> {
  factory _$$_ClubModelCopyWith(
          _$_ClubModel value, $Res Function(_$_ClubModel) then) =
      __$$_ClubModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      String? imageUrl,
      String? groupLink,
      String? city});
}

/// @nodoc
class __$$_ClubModelCopyWithImpl<$Res>
    extends _$ClubModelCopyWithImpl<$Res, _$_ClubModel>
    implements _$$_ClubModelCopyWith<$Res> {
  __$$_ClubModelCopyWithImpl(
      _$_ClubModel _value, $Res Function(_$_ClubModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? groupLink = freezed,
    Object? city = freezed,
  }) {
    return _then(_$_ClubModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$_ClubModel implements _ClubModel {
  const _$_ClubModel(
      {required this.id,
      required this.name,
      this.description,
      this.imageUrl,
      this.groupLink,
      this.city});

  @override
  final int id;
  @override
  final String name;
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
    return 'ClubModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, groupLink: $groupLink, city: $city)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClubModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
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
      runtimeType, id, name, description, imageUrl, groupLink, city);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClubModelCopyWith<_$_ClubModel> get copyWith =>
      __$$_ClubModelCopyWithImpl<_$_ClubModel>(this, _$identity);
}

abstract class _ClubModel implements ClubModel {
  const factory _ClubModel(
      {required final int id,
      required final String name,
      final String? description,
      final String? imageUrl,
      final String? groupLink,
      final String? city}) = _$_ClubModel;

  @override
  int get id;
  @override
  String get name;
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
  _$$_ClubModelCopyWith<_$_ClubModel> get copyWith =>
      throw _privateConstructorUsedError;
}
