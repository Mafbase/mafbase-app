// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_theme_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PhotoThemeEntryModel {
  int get playerId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String? get themeImageUrl => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;

  /// Create a copy of PhotoThemeEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoThemeEntryModelCopyWith<PhotoThemeEntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoThemeEntryModelCopyWith<$Res> {
  factory $PhotoThemeEntryModelCopyWith(PhotoThemeEntryModel value,
          $Res Function(PhotoThemeEntryModel) then) =
      _$PhotoThemeEntryModelCopyWithImpl<$Res, PhotoThemeEntryModel>;
  @useResult
  $Res call(
      {int playerId,
      String nickname,
      String? themeImageUrl,
      String? profileImageUrl});
}

/// @nodoc
class _$PhotoThemeEntryModelCopyWithImpl<$Res,
        $Val extends PhotoThemeEntryModel>
    implements $PhotoThemeEntryModelCopyWith<$Res> {
  _$PhotoThemeEntryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoThemeEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? nickname = null,
    Object? themeImageUrl = freezed,
    Object? profileImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      themeImageUrl: freezed == themeImageUrl
          ? _value.themeImageUrl
          : themeImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhotoThemeEntryModelImplCopyWith<$Res>
    implements $PhotoThemeEntryModelCopyWith<$Res> {
  factory _$$PhotoThemeEntryModelImplCopyWith(_$PhotoThemeEntryModelImpl value,
          $Res Function(_$PhotoThemeEntryModelImpl) then) =
      __$$PhotoThemeEntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int playerId,
      String nickname,
      String? themeImageUrl,
      String? profileImageUrl});
}

/// @nodoc
class __$$PhotoThemeEntryModelImplCopyWithImpl<$Res>
    extends _$PhotoThemeEntryModelCopyWithImpl<$Res, _$PhotoThemeEntryModelImpl>
    implements _$$PhotoThemeEntryModelImplCopyWith<$Res> {
  __$$PhotoThemeEntryModelImplCopyWithImpl(_$PhotoThemeEntryModelImpl _value,
      $Res Function(_$PhotoThemeEntryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhotoThemeEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? nickname = null,
    Object? themeImageUrl = freezed,
    Object? profileImageUrl = freezed,
  }) {
    return _then(_$PhotoThemeEntryModelImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      themeImageUrl: freezed == themeImageUrl
          ? _value.themeImageUrl
          : themeImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PhotoThemeEntryModelImpl implements _PhotoThemeEntryModel {
  const _$PhotoThemeEntryModelImpl(
      {required this.playerId,
      required this.nickname,
      this.themeImageUrl,
      this.profileImageUrl});

  @override
  final int playerId;
  @override
  final String nickname;
  @override
  final String? themeImageUrl;
  @override
  final String? profileImageUrl;

  @override
  String toString() {
    return 'PhotoThemeEntryModel(playerId: $playerId, nickname: $nickname, themeImageUrl: $themeImageUrl, profileImageUrl: $profileImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoThemeEntryModelImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.themeImageUrl, themeImageUrl) ||
                other.themeImageUrl == themeImageUrl) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, playerId, nickname, themeImageUrl, profileImageUrl);

  /// Create a copy of PhotoThemeEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoThemeEntryModelImplCopyWith<_$PhotoThemeEntryModelImpl>
      get copyWith =>
          __$$PhotoThemeEntryModelImplCopyWithImpl<_$PhotoThemeEntryModelImpl>(
              this, _$identity);
}

abstract class _PhotoThemeEntryModel implements PhotoThemeEntryModel {
  const factory _PhotoThemeEntryModel(
      {required final int playerId,
      required final String nickname,
      final String? themeImageUrl,
      final String? profileImageUrl}) = _$PhotoThemeEntryModelImpl;

  @override
  int get playerId;
  @override
  String get nickname;
  @override
  String? get themeImageUrl;
  @override
  String? get profileImageUrl;

  /// Create a copy of PhotoThemeEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoThemeEntryModelImplCopyWith<_$PhotoThemeEntryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
