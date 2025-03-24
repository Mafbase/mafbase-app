// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'administration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdministrationState {
  List<UserModel> get owners => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of AdministrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdministrationStateCopyWith<AdministrationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdministrationStateCopyWith<$Res> {
  factory $AdministrationStateCopyWith(
          AdministrationState value, $Res Function(AdministrationState) then) =
      _$AdministrationStateCopyWithImpl<$Res, AdministrationState>;
  @useResult
  $Res call({List<UserModel> owners, bool isLoading});
}

/// @nodoc
class _$AdministrationStateCopyWithImpl<$Res, $Val extends AdministrationState>
    implements $AdministrationStateCopyWith<$Res> {
  _$AdministrationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdministrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owners = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      owners: null == owners
          ? _value.owners
          : owners // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdministrationStateImplCopyWith<$Res>
    implements $AdministrationStateCopyWith<$Res> {
  factory _$$AdministrationStateImplCopyWith(_$AdministrationStateImpl value,
          $Res Function(_$AdministrationStateImpl) then) =
      __$$AdministrationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserModel> owners, bool isLoading});
}

/// @nodoc
class __$$AdministrationStateImplCopyWithImpl<$Res>
    extends _$AdministrationStateCopyWithImpl<$Res, _$AdministrationStateImpl>
    implements _$$AdministrationStateImplCopyWith<$Res> {
  __$$AdministrationStateImplCopyWithImpl(_$AdministrationStateImpl _value,
      $Res Function(_$AdministrationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdministrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owners = null,
    Object? isLoading = null,
  }) {
    return _then(_$AdministrationStateImpl(
      owners: null == owners
          ? _value._owners
          : owners // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AdministrationStateImpl implements _AdministrationState {
  const _$AdministrationStateImpl(
      {final List<UserModel> owners = const [], this.isLoading = true})
      : _owners = owners;

  final List<UserModel> _owners;
  @override
  @JsonKey()
  List<UserModel> get owners {
    if (_owners is EqualUnmodifiableListView) return _owners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_owners);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'AdministrationState(owners: $owners, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdministrationStateImpl &&
            const DeepCollectionEquality().equals(other._owners, _owners) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_owners), isLoading);

  /// Create a copy of AdministrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdministrationStateImplCopyWith<_$AdministrationStateImpl> get copyWith =>
      __$$AdministrationStateImplCopyWithImpl<_$AdministrationStateImpl>(
          this, _$identity);
}

abstract class _AdministrationState implements AdministrationState {
  const factory _AdministrationState(
      {final List<UserModel> owners,
      final bool isLoading}) = _$AdministrationStateImpl;

  @override
  List<UserModel> get owners;
  @override
  bool get isLoading;

  /// Create a copy of AdministrationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdministrationStateImplCopyWith<_$AdministrationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
