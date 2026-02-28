// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_column_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomColumnModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get formula => throw _privateConstructorUsedError;

  /// Create a copy of CustomColumnModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomColumnModelCopyWith<CustomColumnModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomColumnModelCopyWith<$Res> {
  factory $CustomColumnModelCopyWith(
          CustomColumnModel value, $Res Function(CustomColumnModel) then) =
      _$CustomColumnModelCopyWithImpl<$Res, CustomColumnModel>;
  @useResult
  $Res call({int id, String title, String formula});
}

/// @nodoc
class _$CustomColumnModelCopyWithImpl<$Res, $Val extends CustomColumnModel>
    implements $CustomColumnModelCopyWith<$Res> {
  _$CustomColumnModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomColumnModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? formula = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      formula: null == formula
          ? _value.formula
          : formula // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomColumnModelImplCopyWith<$Res>
    implements $CustomColumnModelCopyWith<$Res> {
  factory _$$CustomColumnModelImplCopyWith(_$CustomColumnModelImpl value,
          $Res Function(_$CustomColumnModelImpl) then) =
      __$$CustomColumnModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title, String formula});
}

/// @nodoc
class __$$CustomColumnModelImplCopyWithImpl<$Res>
    extends _$CustomColumnModelCopyWithImpl<$Res, _$CustomColumnModelImpl>
    implements _$$CustomColumnModelImplCopyWith<$Res> {
  __$$CustomColumnModelImplCopyWithImpl(_$CustomColumnModelImpl _value,
      $Res Function(_$CustomColumnModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomColumnModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? formula = null,
  }) {
    return _then(_$CustomColumnModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      formula: null == formula
          ? _value.formula
          : formula // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CustomColumnModelImpl implements _CustomColumnModel {
  const _$CustomColumnModelImpl(
      {required this.id, required this.title, required this.formula});

  @override
  final int id;
  @override
  final String title;
  @override
  final String formula;

  @override
  String toString() {
    return 'CustomColumnModel(id: $id, title: $title, formula: $formula)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomColumnModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.formula, formula) || other.formula == formula));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, formula);

  /// Create a copy of CustomColumnModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomColumnModelImplCopyWith<_$CustomColumnModelImpl> get copyWith =>
      __$$CustomColumnModelImplCopyWithImpl<_$CustomColumnModelImpl>(
          this, _$identity);
}

abstract class _CustomColumnModel implements CustomColumnModel {
  const factory _CustomColumnModel(
      {required final int id,
      required final String title,
      required final String formula}) = _$CustomColumnModelImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  String get formula;

  /// Create a copy of CustomColumnModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomColumnModelImplCopyWith<_$CustomColumnModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
