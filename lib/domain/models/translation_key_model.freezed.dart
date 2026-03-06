// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_key_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TranslationKeyModel {
  String get key => throw _privateConstructorUsedError;
  List<DesignModel> get designs => throw _privateConstructorUsedError;

  /// Create a copy of TranslationKeyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranslationKeyModelCopyWith<TranslationKeyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationKeyModelCopyWith<$Res> {
  factory $TranslationKeyModelCopyWith(
          TranslationKeyModel value, $Res Function(TranslationKeyModel) then) =
      _$TranslationKeyModelCopyWithImpl<$Res, TranslationKeyModel>;
  @useResult
  $Res call({String key, List<DesignModel> designs});
}

/// @nodoc
class _$TranslationKeyModelCopyWithImpl<$Res, $Val extends TranslationKeyModel>
    implements $TranslationKeyModelCopyWith<$Res> {
  _$TranslationKeyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslationKeyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? designs = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      designs: null == designs
          ? _value.designs
          : designs // ignore: cast_nullable_to_non_nullable
              as List<DesignModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TranslationKeyModelImplCopyWith<$Res>
    implements $TranslationKeyModelCopyWith<$Res> {
  factory _$$TranslationKeyModelImplCopyWith(_$TranslationKeyModelImpl value,
          $Res Function(_$TranslationKeyModelImpl) then) =
      __$$TranslationKeyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, List<DesignModel> designs});
}

/// @nodoc
class __$$TranslationKeyModelImplCopyWithImpl<$Res>
    extends _$TranslationKeyModelCopyWithImpl<$Res, _$TranslationKeyModelImpl>
    implements _$$TranslationKeyModelImplCopyWith<$Res> {
  __$$TranslationKeyModelImplCopyWithImpl(_$TranslationKeyModelImpl _value,
      $Res Function(_$TranslationKeyModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationKeyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? designs = null,
  }) {
    return _then(_$TranslationKeyModelImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      designs: null == designs
          ? _value._designs
          : designs // ignore: cast_nullable_to_non_nullable
              as List<DesignModel>,
    ));
  }
}

/// @nodoc

class _$TranslationKeyModelImpl implements _TranslationKeyModel {
  const _$TranslationKeyModelImpl(
      {required this.key, required final List<DesignModel> designs})
      : _designs = designs;

  @override
  final String key;
  final List<DesignModel> _designs;
  @override
  List<DesignModel> get designs {
    if (_designs is EqualUnmodifiableListView) return _designs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_designs);
  }

  @override
  String toString() {
    return 'TranslationKeyModel(key: $key, designs: $designs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationKeyModelImpl &&
            (identical(other.key, key) || other.key == key) &&
            const DeepCollectionEquality().equals(other._designs, _designs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, key, const DeepCollectionEquality().hash(_designs));

  /// Create a copy of TranslationKeyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationKeyModelImplCopyWith<_$TranslationKeyModelImpl> get copyWith =>
      __$$TranslationKeyModelImplCopyWithImpl<_$TranslationKeyModelImpl>(
          this, _$identity);
}

abstract class _TranslationKeyModel implements TranslationKeyModel {
  const factory _TranslationKeyModel(
      {required final String key,
      required final List<DesignModel> designs}) = _$TranslationKeyModelImpl;

  @override
  String get key;
  @override
  List<DesignModel> get designs;

  /// Create a copy of TranslationKeyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslationKeyModelImplCopyWith<_$TranslationKeyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DesignModel {
  String get designKey => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get preview => throw _privateConstructorUsedError;

  /// Create a copy of DesignModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DesignModelCopyWith<DesignModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DesignModelCopyWith<$Res> {
  factory $DesignModelCopyWith(
          DesignModel value, $Res Function(DesignModel) then) =
      _$DesignModelCopyWithImpl<$Res, DesignModel>;
  @useResult
  $Res call({String designKey, String title, String preview});
}

/// @nodoc
class _$DesignModelCopyWithImpl<$Res, $Val extends DesignModel>
    implements $DesignModelCopyWith<$Res> {
  _$DesignModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DesignModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? designKey = null,
    Object? title = null,
    Object? preview = null,
  }) {
    return _then(_value.copyWith(
      designKey: null == designKey
          ? _value.designKey
          : designKey // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      preview: null == preview
          ? _value.preview
          : preview // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DesignModelImplCopyWith<$Res>
    implements $DesignModelCopyWith<$Res> {
  factory _$$DesignModelImplCopyWith(
          _$DesignModelImpl value, $Res Function(_$DesignModelImpl) then) =
      __$$DesignModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String designKey, String title, String preview});
}

/// @nodoc
class __$$DesignModelImplCopyWithImpl<$Res>
    extends _$DesignModelCopyWithImpl<$Res, _$DesignModelImpl>
    implements _$$DesignModelImplCopyWith<$Res> {
  __$$DesignModelImplCopyWithImpl(
      _$DesignModelImpl _value, $Res Function(_$DesignModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DesignModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? designKey = null,
    Object? title = null,
    Object? preview = null,
  }) {
    return _then(_$DesignModelImpl(
      designKey: null == designKey
          ? _value.designKey
          : designKey // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      preview: null == preview
          ? _value.preview
          : preview // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DesignModelImpl implements _DesignModel {
  const _$DesignModelImpl(
      {required this.designKey, required this.title, required this.preview});

  @override
  final String designKey;
  @override
  final String title;
  @override
  final String preview;

  @override
  String toString() {
    return 'DesignModel(designKey: $designKey, title: $title, preview: $preview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DesignModelImpl &&
            (identical(other.designKey, designKey) ||
                other.designKey == designKey) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.preview, preview) || other.preview == preview));
  }

  @override
  int get hashCode => Object.hash(runtimeType, designKey, title, preview);

  /// Create a copy of DesignModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DesignModelImplCopyWith<_$DesignModelImpl> get copyWith =>
      __$$DesignModelImplCopyWithImpl<_$DesignModelImpl>(this, _$identity);
}

abstract class _DesignModel implements DesignModel {
  const factory _DesignModel(
      {required final String designKey,
      required final String title,
      required final String preview}) = _$DesignModelImpl;

  @override
  String get designKey;
  @override
  String get title;
  @override
  String get preview;

  /// Create a copy of DesignModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DesignModelImplCopyWith<_$DesignModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
