// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile_dialog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProfileDialogState {
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileDialogStateCopyWith<ProfileDialogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileDialogStateCopyWith<$Res> {
  factory $ProfileDialogStateCopyWith(
          ProfileDialogState value, $Res Function(ProfileDialogState) then) =
      _$ProfileDialogStateCopyWithImpl<$Res>;
  $Res call({String? imageUrl, bool isLoading});
}

/// @nodoc
class _$ProfileDialogStateCopyWithImpl<$Res>
    implements $ProfileDialogStateCopyWith<$Res> {
  _$ProfileDialogStateCopyWithImpl(this._value, this._then);

  final ProfileDialogState _value;
  // ignore: unused_field
  final $Res Function(ProfileDialogState) _then;

  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_ProfileDialogStateCopyWith<$Res>
    implements $ProfileDialogStateCopyWith<$Res> {
  factory _$$_ProfileDialogStateCopyWith(_$_ProfileDialogState value,
          $Res Function(_$_ProfileDialogState) then) =
      __$$_ProfileDialogStateCopyWithImpl<$Res>;
  @override
  $Res call({String? imageUrl, bool isLoading});
}

/// @nodoc
class __$$_ProfileDialogStateCopyWithImpl<$Res>
    extends _$ProfileDialogStateCopyWithImpl<$Res>
    implements _$$_ProfileDialogStateCopyWith<$Res> {
  __$$_ProfileDialogStateCopyWithImpl(
      _$_ProfileDialogState _value, $Res Function(_$_ProfileDialogState) _then)
      : super(_value, (v) => _then(v as _$_ProfileDialogState));

  @override
  _$_ProfileDialogState get _value => super._value as _$_ProfileDialogState;

  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_$_ProfileDialogState(
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ProfileDialogState implements _ProfileDialogState {
  const _$_ProfileDialogState({this.imageUrl, this.isLoading = true});

  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ProfileDialogState(imageUrl: $imageUrl, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfileDialogState &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(imageUrl),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$$_ProfileDialogStateCopyWith<_$_ProfileDialogState> get copyWith =>
      __$$_ProfileDialogStateCopyWithImpl<_$_ProfileDialogState>(
          this, _$identity);
}

abstract class _ProfileDialogState implements ProfileDialogState {
  const factory _ProfileDialogState(
      {final String? imageUrl, final bool isLoading}) = _$_ProfileDialogState;

  @override
  String? get imageUrl;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_ProfileDialogStateCopyWith<_$_ProfileDialogState> get copyWith =>
      throw _privateConstructorUsedError;
}
