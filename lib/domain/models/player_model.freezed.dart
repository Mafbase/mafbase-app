// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlayerModel {
  int get id => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String? get fsmNickaname => throw _privateConstructorUsedError;
  String? get mafbankNickname => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerModelCopyWith<PlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerModelCopyWith<$Res> {
  factory $PlayerModelCopyWith(
          PlayerModel value, $Res Function(PlayerModel) then) =
      _$PlayerModelCopyWithImpl<$Res, PlayerModel>;
  @useResult
  $Res call(
      {int id,
      String nickname,
      String? fsmNickaname,
      String? mafbankNickname,
      String? imageUrl});
}

/// @nodoc
class _$PlayerModelCopyWithImpl<$Res, $Val extends PlayerModel>
    implements $PlayerModelCopyWith<$Res> {
  _$PlayerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? fsmNickaname = freezed,
    Object? mafbankNickname = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      fsmNickaname: freezed == fsmNickaname
          ? _value.fsmNickaname
          : fsmNickaname // ignore: cast_nullable_to_non_nullable
              as String?,
      mafbankNickname: freezed == mafbankNickname
          ? _value.mafbankNickname
          : mafbankNickname // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerModelImplCopyWith<$Res>
    implements $PlayerModelCopyWith<$Res> {
  factory _$$PlayerModelImplCopyWith(
          _$PlayerModelImpl value, $Res Function(_$PlayerModelImpl) then) =
      __$$PlayerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String nickname,
      String? fsmNickaname,
      String? mafbankNickname,
      String? imageUrl});
}

/// @nodoc
class __$$PlayerModelImplCopyWithImpl<$Res>
    extends _$PlayerModelCopyWithImpl<$Res, _$PlayerModelImpl>
    implements _$$PlayerModelImplCopyWith<$Res> {
  __$$PlayerModelImplCopyWithImpl(
      _$PlayerModelImpl _value, $Res Function(_$PlayerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? fsmNickaname = freezed,
    Object? mafbankNickname = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$PlayerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      fsmNickaname: freezed == fsmNickaname
          ? _value.fsmNickaname
          : fsmNickaname // ignore: cast_nullable_to_non_nullable
              as String?,
      mafbankNickname: freezed == mafbankNickname
          ? _value.mafbankNickname
          : mafbankNickname // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PlayerModelImpl implements _PlayerModel {
  const _$PlayerModelImpl(
      {required this.id,
      required this.nickname,
      this.fsmNickaname,
      this.mafbankNickname,
      this.imageUrl});

  @override
  final int id;
  @override
  final String nickname;
  @override
  final String? fsmNickaname;
  @override
  final String? mafbankNickname;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'PlayerModel(id: $id, nickname: $nickname, fsmNickaname: $fsmNickaname, mafbankNickname: $mafbankNickname, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.fsmNickaname, fsmNickaname) ||
                other.fsmNickaname == fsmNickaname) &&
            (identical(other.mafbankNickname, mafbankNickname) ||
                other.mafbankNickname == mafbankNickname) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, nickname, fsmNickaname, mafbankNickname, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerModelImplCopyWith<_$PlayerModelImpl> get copyWith =>
      __$$PlayerModelImplCopyWithImpl<_$PlayerModelImpl>(this, _$identity);
}

abstract class _PlayerModel implements PlayerModel {
  const factory _PlayerModel(
      {required final int id,
      required final String nickname,
      final String? fsmNickaname,
      final String? mafbankNickname,
      final String? imageUrl}) = _$PlayerModelImpl;

  @override
  int get id;
  @override
  String get nickname;
  @override
  String? get fsmNickaname;
  @override
  String? get mafbankNickname;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$PlayerModelImplCopyWith<_$PlayerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
