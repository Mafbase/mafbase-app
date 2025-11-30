// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_table_description_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InfoTableState {
  bool get loading => throw _privateConstructorUsedError;
  List<MapEntry<int, String>> get tableDescriptions =>
      throw _privateConstructorUsedError;

  /// Create a copy of InfoTableState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InfoTableStateCopyWith<InfoTableState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoTableStateCopyWith<$Res> {
  factory $InfoTableStateCopyWith(
          InfoTableState value, $Res Function(InfoTableState) then) =
      _$InfoTableStateCopyWithImpl<$Res, InfoTableState>;
  @useResult
  $Res call({bool loading, List<MapEntry<int, String>> tableDescriptions});
}

/// @nodoc
class _$InfoTableStateCopyWithImpl<$Res, $Val extends InfoTableState>
    implements $InfoTableStateCopyWith<$Res> {
  _$InfoTableStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InfoTableState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? tableDescriptions = null,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      tableDescriptions: null == tableDescriptions
          ? _value.tableDescriptions
          : tableDescriptions // ignore: cast_nullable_to_non_nullable
              as List<MapEntry<int, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InfoTableStateImplCopyWith<$Res>
    implements $InfoTableStateCopyWith<$Res> {
  factory _$$InfoTableStateImplCopyWith(_$InfoTableStateImpl value,
          $Res Function(_$InfoTableStateImpl) then) =
      __$$InfoTableStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading, List<MapEntry<int, String>> tableDescriptions});
}

/// @nodoc
class __$$InfoTableStateImplCopyWithImpl<$Res>
    extends _$InfoTableStateCopyWithImpl<$Res, _$InfoTableStateImpl>
    implements _$$InfoTableStateImplCopyWith<$Res> {
  __$$InfoTableStateImplCopyWithImpl(
      _$InfoTableStateImpl _value, $Res Function(_$InfoTableStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of InfoTableState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? tableDescriptions = null,
  }) {
    return _then(_$InfoTableStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      tableDescriptions: null == tableDescriptions
          ? _value._tableDescriptions
          : tableDescriptions // ignore: cast_nullable_to_non_nullable
              as List<MapEntry<int, String>>,
    ));
  }
}

/// @nodoc

class _$InfoTableStateImpl implements _InfoTableState {
  const _$InfoTableStateImpl(
      {this.loading = true,
      final List<MapEntry<int, String>> tableDescriptions = const []})
      : _tableDescriptions = tableDescriptions;

  @override
  @JsonKey()
  final bool loading;
  final List<MapEntry<int, String>> _tableDescriptions;
  @override
  @JsonKey()
  List<MapEntry<int, String>> get tableDescriptions {
    if (_tableDescriptions is EqualUnmodifiableListView)
      return _tableDescriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tableDescriptions);
  }

  @override
  String toString() {
    return 'InfoTableState(loading: $loading, tableDescriptions: $tableDescriptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfoTableStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality()
                .equals(other._tableDescriptions, _tableDescriptions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading,
      const DeepCollectionEquality().hash(_tableDescriptions));

  /// Create a copy of InfoTableState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InfoTableStateImplCopyWith<_$InfoTableStateImpl> get copyWith =>
      __$$InfoTableStateImplCopyWithImpl<_$InfoTableStateImpl>(
          this, _$identity);
}

abstract class _InfoTableState implements InfoTableState {
  const factory _InfoTableState(
          {final bool loading,
          final List<MapEntry<int, String>> tableDescriptions}) =
      _$InfoTableStateImpl;

  @override
  bool get loading;
  @override
  List<MapEntry<int, String>> get tableDescriptions;

  /// Create a copy of InfoTableState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InfoTableStateImplCopyWith<_$InfoTableStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
