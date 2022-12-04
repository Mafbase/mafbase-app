// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile_dialog_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
    TResult Function(
            String nickname, String mafbankNickname, String fsmNickname)?
        onSubmit,
    TResult Function(Uint8List bytes, String fileName)? editImage,
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
    TResult Function(ProfileDialogEventSubmit value)? onSubmit,
    TResult Function(ProfileDialogEventEditImage value)? editImage,
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
      _$ProfileDialogEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProfileDialogEventCopyWithImpl<$Res>
    implements $ProfileDialogEventCopyWith<$Res> {
  _$ProfileDialogEventCopyWithImpl(this._value, this._then);

  final ProfileDialogEvent _value;
  // ignore: unused_field
  final $Res Function(ProfileDialogEvent) _then;
}

/// @nodoc
abstract class _$$ProfileDialogEventSubmitCopyWith<$Res> {
  factory _$$ProfileDialogEventSubmitCopyWith(_$ProfileDialogEventSubmit value,
          $Res Function(_$ProfileDialogEventSubmit) then) =
      __$$ProfileDialogEventSubmitCopyWithImpl<$Res>;
  $Res call({String nickname, String mafbankNickname, String fsmNickname});
}

/// @nodoc
class __$$ProfileDialogEventSubmitCopyWithImpl<$Res>
    extends _$ProfileDialogEventCopyWithImpl<$Res>
    implements _$$ProfileDialogEventSubmitCopyWith<$Res> {
  __$$ProfileDialogEventSubmitCopyWithImpl(_$ProfileDialogEventSubmit _value,
      $Res Function(_$ProfileDialogEventSubmit) _then)
      : super(_value, (v) => _then(v as _$ProfileDialogEventSubmit));

  @override
  _$ProfileDialogEventSubmit get _value =>
      super._value as _$ProfileDialogEventSubmit;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? mafbankNickname = freezed,
    Object? fsmNickname = freezed,
  }) {
    return _then(_$ProfileDialogEventSubmit(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      mafbankNickname: mafbankNickname == freezed
          ? _value.mafbankNickname
          : mafbankNickname // ignore: cast_nullable_to_non_nullable
              as String,
      fsmNickname: fsmNickname == freezed
          ? _value.fsmNickname
          : fsmNickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProfileDialogEventSubmit implements ProfileDialogEventSubmit {
  const _$ProfileDialogEventSubmit(
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileDialogEventSubmit &&
            const DeepCollectionEquality().equals(other.nickname, nickname) &&
            const DeepCollectionEquality()
                .equals(other.mafbankNickname, mafbankNickname) &&
            const DeepCollectionEquality()
                .equals(other.fsmNickname, fsmNickname));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nickname),
      const DeepCollectionEquality().hash(mafbankNickname),
      const DeepCollectionEquality().hash(fsmNickname));

  @JsonKey(ignore: true)
  @override
  _$$ProfileDialogEventSubmitCopyWith<_$ProfileDialogEventSubmit>
      get copyWith =>
          __$$ProfileDialogEventSubmitCopyWithImpl<_$ProfileDialogEventSubmit>(
              this, _$identity);

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
    TResult Function(
            String nickname, String mafbankNickname, String fsmNickname)?
        onSubmit,
    TResult Function(Uint8List bytes, String fileName)? editImage,
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
    TResult Function(ProfileDialogEventSubmit value)? onSubmit,
    TResult Function(ProfileDialogEventEditImage value)? editImage,
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
      required final String fsmNickname}) = _$ProfileDialogEventSubmit;

  String get nickname;
  String get mafbankNickname;
  String get fsmNickname;
  @JsonKey(ignore: true)
  _$$ProfileDialogEventSubmitCopyWith<_$ProfileDialogEventSubmit>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProfileDialogEventEditImageCopyWith<$Res> {
  factory _$$ProfileDialogEventEditImageCopyWith(
          _$ProfileDialogEventEditImage value,
          $Res Function(_$ProfileDialogEventEditImage) then) =
      __$$ProfileDialogEventEditImageCopyWithImpl<$Res>;
  $Res call({Uint8List bytes, String fileName});
}

/// @nodoc
class __$$ProfileDialogEventEditImageCopyWithImpl<$Res>
    extends _$ProfileDialogEventCopyWithImpl<$Res>
    implements _$$ProfileDialogEventEditImageCopyWith<$Res> {
  __$$ProfileDialogEventEditImageCopyWithImpl(
      _$ProfileDialogEventEditImage _value,
      $Res Function(_$ProfileDialogEventEditImage) _then)
      : super(_value, (v) => _then(v as _$ProfileDialogEventEditImage));

  @override
  _$ProfileDialogEventEditImage get _value =>
      super._value as _$ProfileDialogEventEditImage;

  @override
  $Res call({
    Object? bytes = freezed,
    Object? fileName = freezed,
  }) {
    return _then(_$ProfileDialogEventEditImage(
      bytes: bytes == freezed
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      fileName: fileName == freezed
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProfileDialogEventEditImage implements ProfileDialogEventEditImage {
  const _$ProfileDialogEventEditImage(
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileDialogEventEditImage &&
            const DeepCollectionEquality().equals(other.bytes, bytes) &&
            const DeepCollectionEquality().equals(other.fileName, fileName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(bytes),
      const DeepCollectionEquality().hash(fileName));

  @JsonKey(ignore: true)
  @override
  _$$ProfileDialogEventEditImageCopyWith<_$ProfileDialogEventEditImage>
      get copyWith => __$$ProfileDialogEventEditImageCopyWithImpl<
          _$ProfileDialogEventEditImage>(this, _$identity);

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
    TResult Function(
            String nickname, String mafbankNickname, String fsmNickname)?
        onSubmit,
    TResult Function(Uint8List bytes, String fileName)? editImage,
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
    TResult Function(ProfileDialogEventSubmit value)? onSubmit,
    TResult Function(ProfileDialogEventEditImage value)? editImage,
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
      required final String fileName}) = _$ProfileDialogEventEditImage;

  Uint8List get bytes;
  String get fileName;
  @JsonKey(ignore: true)
  _$$ProfileDialogEventEditImageCopyWith<_$ProfileDialogEventEditImage>
      get copyWith => throw _privateConstructorUsedError;
}
