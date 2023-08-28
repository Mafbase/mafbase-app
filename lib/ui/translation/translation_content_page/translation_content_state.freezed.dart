// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_content_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TranslationContentState {
  List<PlayerRole>? get roles => throw _privateConstructorUsedError;
  List<PlayerStatus>? get statuses => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  List<String>? get nicknames => throw _privateConstructorUsedError;
  int get game => throw _privateConstructorUsedError;
  int get totalGames => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TranslationContentStateCopyWith<TranslationContentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationContentStateCopyWith<$Res> {
  factory $TranslationContentStateCopyWith(TranslationContentState value,
          $Res Function(TranslationContentState) then) =
      _$TranslationContentStateCopyWithImpl<$Res, TranslationContentState>;
  @useResult
  $Res call(
      {List<PlayerRole>? roles,
      List<PlayerStatus>? statuses,
      List<String>? images,
      List<String>? nicknames,
      int game,
      int totalGames});
}

/// @nodoc
class _$TranslationContentStateCopyWithImpl<$Res,
        $Val extends TranslationContentState>
    implements $TranslationContentStateCopyWith<$Res> {
  _$TranslationContentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roles = freezed,
    Object? statuses = freezed,
    Object? images = freezed,
    Object? nicknames = freezed,
    Object? game = null,
    Object? totalGames = null,
  }) {
    return _then(_value.copyWith(
      roles: freezed == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PlayerRole>?,
      statuses: freezed == statuses
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as List<PlayerStatus>?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nicknames: freezed == nicknames
          ? _value.nicknames
          : nicknames // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as int,
      totalGames: null == totalGames
          ? _value.totalGames
          : totalGames // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TranslationContentStateCopyWith<$Res>
    implements $TranslationContentStateCopyWith<$Res> {
  factory _$$_TranslationContentStateCopyWith(_$_TranslationContentState value,
          $Res Function(_$_TranslationContentState) then) =
      __$$_TranslationContentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PlayerRole>? roles,
      List<PlayerStatus>? statuses,
      List<String>? images,
      List<String>? nicknames,
      int game,
      int totalGames});
}

/// @nodoc
class __$$_TranslationContentStateCopyWithImpl<$Res>
    extends _$TranslationContentStateCopyWithImpl<$Res,
        _$_TranslationContentState>
    implements _$$_TranslationContentStateCopyWith<$Res> {
  __$$_TranslationContentStateCopyWithImpl(_$_TranslationContentState _value,
      $Res Function(_$_TranslationContentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roles = freezed,
    Object? statuses = freezed,
    Object? images = freezed,
    Object? nicknames = freezed,
    Object? game = null,
    Object? totalGames = null,
  }) {
    return _then(_$_TranslationContentState(
      roles: freezed == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PlayerRole>?,
      statuses: freezed == statuses
          ? _value._statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as List<PlayerStatus>?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nicknames: freezed == nicknames
          ? _value._nicknames
          : nicknames // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as int,
      totalGames: null == totalGames
          ? _value.totalGames
          : totalGames // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TranslationContentState implements _TranslationContentState {
  const _$_TranslationContentState(
      {final List<PlayerRole>? roles,
      final List<PlayerStatus>? statuses,
      final List<String>? images,
      final List<String>? nicknames,
      this.game = 0,
      this.totalGames = 0})
      : _roles = roles,
        _statuses = statuses,
        _images = images,
        _nicknames = nicknames;

  final List<PlayerRole>? _roles;
  @override
  List<PlayerRole>? get roles {
    final value = _roles;
    if (value == null) return null;
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PlayerStatus>? _statuses;
  @override
  List<PlayerStatus>? get statuses {
    final value = _statuses;
    if (value == null) return null;
    if (_statuses is EqualUnmodifiableListView) return _statuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _nicknames;
  @override
  List<String>? get nicknames {
    final value = _nicknames;
    if (value == null) return null;
    if (_nicknames is EqualUnmodifiableListView) return _nicknames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int game;
  @override
  @JsonKey()
  final int totalGames;

  @override
  String toString() {
    return 'TranslationContentState(roles: $roles, statuses: $statuses, images: $images, nicknames: $nicknames, game: $game, totalGames: $totalGames)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TranslationContentState &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            const DeepCollectionEquality().equals(other._statuses, _statuses) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality()
                .equals(other._nicknames, _nicknames) &&
            (identical(other.game, game) || other.game == game) &&
            (identical(other.totalGames, totalGames) ||
                other.totalGames == totalGames));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_roles),
      const DeepCollectionEquality().hash(_statuses),
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_nicknames),
      game,
      totalGames);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TranslationContentStateCopyWith<_$_TranslationContentState>
      get copyWith =>
          __$$_TranslationContentStateCopyWithImpl<_$_TranslationContentState>(
              this, _$identity);
}

abstract class _TranslationContentState implements TranslationContentState {
  const factory _TranslationContentState(
      {final List<PlayerRole>? roles,
      final List<PlayerStatus>? statuses,
      final List<String>? images,
      final List<String>? nicknames,
      final int game,
      final int totalGames}) = _$_TranslationContentState;

  @override
  List<PlayerRole>? get roles;
  @override
  List<PlayerStatus>? get statuses;
  @override
  List<String>? get images;
  @override
  List<String>? get nicknames;
  @override
  int get game;
  @override
  int get totalGames;
  @override
  @JsonKey(ignore: true)
  _$$_TranslationContentStateCopyWith<_$_TranslationContentState>
      get copyWith => throw _privateConstructorUsedError;
}
