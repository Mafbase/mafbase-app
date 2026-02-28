// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_column_value_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomColumnValueModel {
  String get title => throw _privateConstructorUsedError;
  double? get value => throw _privateConstructorUsedError;

  /// Create a copy of CustomColumnValueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomColumnValueModelCopyWith<CustomColumnValueModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomColumnValueModelCopyWith<$Res> {
  factory $CustomColumnValueModelCopyWith(CustomColumnValueModel value,
          $Res Function(CustomColumnValueModel) then) =
      _$CustomColumnValueModelCopyWithImpl<$Res, CustomColumnValueModel>;
  @useResult
  $Res call({String title, double? value});
}

/// @nodoc
class _$CustomColumnValueModelCopyWithImpl<$Res,
        $Val extends CustomColumnValueModel>
    implements $CustomColumnValueModelCopyWith<$Res> {
  _$CustomColumnValueModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomColumnValueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomColumnValueModelImplCopyWith<$Res>
    implements $CustomColumnValueModelCopyWith<$Res> {
  factory _$$CustomColumnValueModelImplCopyWith(
          _$CustomColumnValueModelImpl value,
          $Res Function(_$CustomColumnValueModelImpl) then) =
      __$$CustomColumnValueModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, double? value});
}

/// @nodoc
class __$$CustomColumnValueModelImplCopyWithImpl<$Res>
    extends _$CustomColumnValueModelCopyWithImpl<$Res,
        _$CustomColumnValueModelImpl>
    implements _$$CustomColumnValueModelImplCopyWith<$Res> {
  __$$CustomColumnValueModelImplCopyWithImpl(
      _$CustomColumnValueModelImpl _value,
      $Res Function(_$CustomColumnValueModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomColumnValueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? value = freezed,
  }) {
    return _then(_$CustomColumnValueModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$CustomColumnValueModelImpl implements _CustomColumnValueModel {
  const _$CustomColumnValueModelImpl({required this.title, this.value});

  @override
  final String title;
  @override
  final double? value;

  @override
  String toString() {
    return 'CustomColumnValueModel(title: $title, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomColumnValueModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, value);

  /// Create a copy of CustomColumnValueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomColumnValueModelImplCopyWith<_$CustomColumnValueModelImpl>
      get copyWith => __$$CustomColumnValueModelImplCopyWithImpl<
          _$CustomColumnValueModelImpl>(this, _$identity);
}

abstract class _CustomColumnValueModel implements CustomColumnValueModel {
  const factory _CustomColumnValueModel(
      {required final String title,
      final double? value}) = _$CustomColumnValueModelImpl;

  @override
  String get title;
  @override
  double? get value;

  /// Create a copy of CustomColumnValueModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomColumnValueModelImplCopyWith<_$CustomColumnValueModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
