// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_dialog_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileDialogEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String nickname, String mafbankNickname, String fsmNickname)
        onSubmit,
    required TResult Function(Uint8List bytes, String fileName) editImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String nickname, String mafbankNickname, String fsmNickname)?
        onSubmit,
    TResult? Function(Uint8List bytes, String fileName)? editImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String nickname, String mafbankNickname, String fsmNickname)?
        onSubmit,
    TResult Function(Uint8List bytes, String fileName)? editImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileDialogEventSubmit value) onSubmit,
    required TResult Function(ProfileDialogEventEditImage value) editImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileDialogEventSubmit value)? onSubmit,
    TResult? Function(ProfileDialogEventEditImage value)? editImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileDialogEventSubmit value)? onSubmit,
    TResult Function(ProfileDialogEventEditImage value)? editImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileDialogEventCopyWith<$Res> {
  factory $ProfileDialogEventCopyWith(
          ProfileDialogEvent value, $Res Function(ProfileDialogEvent) then) =
      _$ProfileDialogEventCopyWithImpl<$Res, ProfileDialogEvent>;
}

/// @nodoc
class _$ProfileDialogEventCopyWithImpl<$Res, $Val extends ProfileDialogEvent>
    implements $ProfileDialogEventCopyWith<$Res> {
  _$ProfileDialogEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileDialogEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProfileDialogEventSubmitImplCopyWith<$Res> {
  factory _$$ProfileDialogEventSubmitImplCopyWith(
          _$ProfileDialogEventSubmitImpl value,
          $Res Function(_$ProfileDialogEventSubmitImpl) then) =
      __$$ProfileDialogEventSubmitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String nickname, String mafbankNickname, String fsmNickname});
}

/// @nodoc
class __$$ProfileDialogEventSubmitImplCopyWithImpl<$Res>
    extends _$ProfileDialogEventCopyWithImpl<$Res,
        _$ProfileDialogEventSubmitImpl>
    implements _$$ProfileDialogEventSubmitImplCopyWith<$Res> {
  __$$ProfileDialogEventSubmitImplCopyWithImpl(
      _$ProfileDialogEventSubmitImpl _value,
      $Res Function(_$ProfileDialogEventSubmitImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileDialogEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? mafbankNickname = null,
    Object? fsmNickname = null,
  }) {
    return _then(_$ProfileDialogEventSubmitImpl(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      mafbankNickname: null == mafbankNickname
          ? _value.mafbankNickname
          : mafbankNickname // ignore: cast_nullable_to_non_nullable
              as String,
      fsmNickname: null == fsmNickname
          ? _value.fsmNickname
          : fsmNickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProfileDialogEventSubmitImpl implements ProfileDialogEventSubmit {
  const _$ProfileDialogEventSubmitImpl(
      {required this.nickname,
      required this.mafbankNickname,
      required this.fsmNickname});

  @override
  final String nickname;
  @override
  final String mafbankNickname;
  @override
  final String fsmNickname;

  @override
  String toString() {
    return 'ProfileDialogEvent.onSubmit(nickname: $nickname, mafbankNickname: $mafbankNickname, fsmNickname: $fsmNickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileDialogEventSubmitImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.mafbankNickname, mafbankNickname) ||
                other.mafbankNickname == mafbankNickname) &&
            (identical(other.fsmNickname, fsmNickname) ||
                other.fsmNickname == fsmNickname));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nickname, mafbankNickname, fsmNickname);

  /// Create a copy of ProfileDialogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileDialogEventSubmitImplCopyWith<_$ProfileDialogEventSubmitImpl>
      get copyWith => __$$ProfileDialogEventSubmitImplCopyWithImpl<
          _$ProfileDialogEventSubmitImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String nickname, String mafbankNickname, String fsmNickname)
        onSubmit,
    required TResult Function(Uint8List bytes, String fileName) editImage,
  }) {
    return onSubmit(nickname, mafbankNickname, fsmNickname);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String nickname, String mafbankNickname, String fsmNickname)?
        onSubmit,
    TResult? Function(Uint8List bytes, String fileName)? editImage,
  }) {
    return onSubmit?.call(nickname, mafbankNickname, fsmNickname);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String nickname, String mafbankNickname, String fsmNickname)?
        onSubmit,
    TResult Function(Uint8List bytes, String fileName)? editImage,
    required TResult orElse(),
  }) {
    if (onSubmit != null) {
      return onSubmit(nickname, mafbankNickname, fsmNickname);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileDialogEventSubmit value) onSubmit,
    required TResult Function(ProfileDialogEventEditImage value) editImage,
  }) {
    return onSubmit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileDialogEventSubmit value)? onSubmit,
    TResult? Function(ProfileDialogEventEditImage value)? editImage,
  }) {
    return onSubmit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileDialogEventSubmit value)? onSubmit,
    TResult Function(ProfileDialogEventEditImage value)? editImage,
    required TResult orElse(),
  }) {
    if (onSubmit != null) {
      return onSubmit(this);
    }
    return orElse();
  }
}

abstract class ProfileDialogEventSubmit implements ProfileDialogEvent {
  const factory ProfileDialogEventSubmit(
      {required final String nickname,
      required final String mafbankNickname,
      required final String fsmNickname}) = _$ProfileDialogEventSubmitImpl;

  String get nickname;
  String get mafbankNickname;
  String get fsmNickname;

  /// Create a copy of ProfileDialogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileDialogEventSubmitImplCopyWith<_$ProfileDialogEventSubmitImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProfileDialogEventEditImageImplCopyWith<$Res> {
  factory _$$ProfileDialogEventEditImageImplCopyWith(
          _$ProfileDialogEventEditImageImpl value,
          $Res Function(_$ProfileDialogEventEditImageImpl) then) =
      __$$ProfileDialogEventEditImageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uint8List bytes, String fileName});
}

/// @nodoc
class __$$ProfileDialogEventEditImageImplCopyWithImpl<$Res>
    extends _$ProfileDialogEventCopyWithImpl<$Res,
        _$ProfileDialogEventEditImageImpl>
    implements _$$ProfileDialogEventEditImageImplCopyWith<$Res> {
  __$$ProfileDialogEventEditImageImplCopyWithImpl(
      _$ProfileDialogEventEditImageImpl _value,
      $Res Function(_$ProfileDialogEventEditImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileDialogEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bytes = null,
    Object? fileName = null,
  }) {
    return _then(_$ProfileDialogEventEditImageImpl(
      bytes: null == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProfileDialogEventEditImageImpl implements ProfileDialogEventEditImage {
  const _$ProfileDialogEventEditImageImpl(
      {required this.bytes, required this.fileName});

  @override
  final Uint8List bytes;
  @override
  final String fileName;

  @override
  String toString() {
    return 'ProfileDialogEvent.editImage(bytes: $bytes, fileName: $fileName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileDialogEventEditImageImpl &&
            const DeepCollectionEquality().equals(other.bytes, bytes) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(bytes), fileName);

  /// Create a copy of ProfileDialogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileDialogEventEditImageImplCopyWith<_$ProfileDialogEventEditImageImpl>
      get copyWith => __$$ProfileDialogEventEditImageImplCopyWithImpl<
          _$ProfileDialogEventEditImageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String nickname, String mafbankNickname, String fsmNickname)
        onSubmit,
    required TResult Function(Uint8List bytes, String fileName) editImage,
  }) {
    return editImage(bytes, fileName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String nickname, String mafbankNickname, String fsmNickname)?
        onSubmit,
    TResult? Function(Uint8List bytes, String fileName)? editImage,
  }) {
    return editImage?.call(bytes, fileName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String nickname, String mafbankNickname, String fsmNickname)?
        onSubmit,
    TResult Function(Uint8List bytes, String fileName)? editImage,
    required TResult orElse(),
  }) {
    if (editImage != null) {
      return editImage(bytes, fileName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileDialogEventSubmit value) onSubmit,
    required TResult Function(ProfileDialogEventEditImage value) editImage,
  }) {
    return editImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileDialogEventSubmit value)? onSubmit,
    TResult? Function(ProfileDialogEventEditImage value)? editImage,
  }) {
    return editImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileDialogEventSubmit value)? onSubmit,
    TResult Function(ProfileDialogEventEditImage value)? editImage,
    required TResult orElse(),
  }) {
    if (editImage != null) {
      return editImage(this);
    }
    return orElse();
  }
}

abstract class ProfileDialogEventEditImage implements ProfileDialogEvent {
  const factory ProfileDialogEventEditImage(
      {required final Uint8List bytes,
      required final String fileName}) = _$ProfileDialogEventEditImageImpl;

  Uint8List get bytes;
  String get fileName;

  /// Create a copy of ProfileDialogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileDialogEventEditImageImplCopyWith<_$ProfileDialogEventEditImageImpl>
      get copyWith => throw _privateConstructorUsedError;
}
