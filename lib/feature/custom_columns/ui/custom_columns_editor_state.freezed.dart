// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_columns_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomColumnsEditorState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<CustomColumnModel> get columns => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of CustomColumnsEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomColumnsEditorStateCopyWith<CustomColumnsEditorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomColumnsEditorStateCopyWith<$Res> {
  factory $CustomColumnsEditorStateCopyWith(CustomColumnsEditorState value,
          $Res Function(CustomColumnsEditorState) then) =
      _$CustomColumnsEditorStateCopyWithImpl<$Res, CustomColumnsEditorState>;
  @useResult
  $Res call({bool isLoading, List<CustomColumnModel> columns, String? error});
}

/// @nodoc
class _$CustomColumnsEditorStateCopyWithImpl<$Res,
        $Val extends CustomColumnsEditorState>
    implements $CustomColumnsEditorStateCopyWith<$Res> {
  _$CustomColumnsEditorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomColumnsEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? columns = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      columns: null == columns
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<CustomColumnModel>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomColumnsEditorStateImplCopyWith<$Res>
    implements $CustomColumnsEditorStateCopyWith<$Res> {
  factory _$$CustomColumnsEditorStateImplCopyWith(
          _$CustomColumnsEditorStateImpl value,
          $Res Function(_$CustomColumnsEditorStateImpl) then) =
      __$$CustomColumnsEditorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<CustomColumnModel> columns, String? error});
}

/// @nodoc
class __$$CustomColumnsEditorStateImplCopyWithImpl<$Res>
    extends _$CustomColumnsEditorStateCopyWithImpl<$Res,
        _$CustomColumnsEditorStateImpl>
    implements _$$CustomColumnsEditorStateImplCopyWith<$Res> {
  __$$CustomColumnsEditorStateImplCopyWithImpl(
      _$CustomColumnsEditorStateImpl _value,
      $Res Function(_$CustomColumnsEditorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomColumnsEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? columns = null,
    Object? error = freezed,
  }) {
    return _then(_$CustomColumnsEditorStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      columns: null == columns
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<CustomColumnModel>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CustomColumnsEditorStateImpl implements _CustomColumnsEditorState {
  const _$CustomColumnsEditorStateImpl(
      {this.isLoading = true,
      final List<CustomColumnModel> columns = const [],
      this.error})
      : _columns = columns;

  @override
  @JsonKey()
  final bool isLoading;
  final List<CustomColumnModel> _columns;
  @override
  @JsonKey()
  List<CustomColumnModel> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'CustomColumnsEditorState(isLoading: $isLoading, columns: $columns, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomColumnsEditorStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._columns, _columns) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_columns), error);

  /// Create a copy of CustomColumnsEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomColumnsEditorStateImplCopyWith<_$CustomColumnsEditorStateImpl>
      get copyWith => __$$CustomColumnsEditorStateImplCopyWithImpl<
          _$CustomColumnsEditorStateImpl>(this, _$identity);
}

abstract class _CustomColumnsEditorState implements CustomColumnsEditorState {
  const factory _CustomColumnsEditorState(
      {final bool isLoading,
      final List<CustomColumnModel> columns,
      final String? error}) = _$CustomColumnsEditorStateImpl;

  @override
  bool get isLoading;
  @override
  List<CustomColumnModel> get columns;
  @override
  String? get error;

  /// Create a copy of CustomColumnsEditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomColumnsEditorStateImplCopyWith<_$CustomColumnsEditorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
