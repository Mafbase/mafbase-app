// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'verification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VerificationState {
  bool get hasError => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VerificationStateCopyWith<VerificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationStateCopyWith<$Res> {
  factory $VerificationStateCopyWith(
          VerificationState value, $Res Function(VerificationState) then) =
      _$VerificationStateCopyWithImpl<$Res>;
  $Res call({bool hasError, bool isLoading});
}

/// @nodoc
class _$VerificationStateCopyWithImpl<$Res>
    implements $VerificationStateCopyWith<$Res> {
  _$VerificationStateCopyWithImpl(this._value, this._then);

  final VerificationState _value;
  // ignore: unused_field
  final $Res Function(VerificationState) _then;

  @override
  $Res call({
    Object? hasError = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_VerificationStateCopyWith<$Res>
    implements $VerificationStateCopyWith<$Res> {
  factory _$$_VerificationStateCopyWith(_$_VerificationState value,
          $Res Function(_$_VerificationState) then) =
      __$$_VerificationStateCopyWithImpl<$Res>;
  @override
  $Res call({bool hasError, bool isLoading});
}

/// @nodoc
class __$$_VerificationStateCopyWithImpl<$Res>
    extends _$VerificationStateCopyWithImpl<$Res>
    implements _$$_VerificationStateCopyWith<$Res> {
  __$$_VerificationStateCopyWithImpl(
      _$_VerificationState _value, $Res Function(_$_VerificationState) _then)
      : super(_value, (v) => _then(v as _$_VerificationState));

  @override
  _$_VerificationState get _value => super._value as _$_VerificationState;

  @override
  $Res call({
    Object? hasError = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_$_VerificationState(
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_VerificationState implements _VerificationState {
  const _$_VerificationState({this.hasError = false, required this.isLoading});

  @override
  @JsonKey()
  final bool hasError;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'VerificationState(hasError: $hasError, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VerificationState &&
            const DeepCollectionEquality().equals(other.hasError, hasError) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(hasError),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$$_VerificationStateCopyWith<_$_VerificationState> get copyWith =>
      __$$_VerificationStateCopyWithImpl<_$_VerificationState>(
          this, _$identity);
}

abstract class _VerificationState implements VerificationState {
  const factory _VerificationState(
      {final bool hasError,
      required final bool isLoading}) = _$_VerificationState;

  @override
  bool get hasError;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_VerificationStateCopyWith<_$_VerificationState> get copyWith =>
      throw _privateConstructorUsedError;
}
