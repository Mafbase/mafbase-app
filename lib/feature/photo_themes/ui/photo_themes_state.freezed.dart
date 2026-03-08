// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_themes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PhotoThemesState {
  List<PhotoThemeModel> get themes => throw _privateConstructorUsedError;
  int? get selectedThemeId => throw _privateConstructorUsedError;
  List<PhotoThemeEntryModel> get players => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  List<PlayerModel> get availablePlayers => throw _privateConstructorUsedError;

  /// Create a copy of PhotoThemesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoThemesStateCopyWith<PhotoThemesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoThemesStateCopyWith<$Res> {
  factory $PhotoThemesStateCopyWith(
          PhotoThemesState value, $Res Function(PhotoThemesState) then) =
      _$PhotoThemesStateCopyWithImpl<$Res, PhotoThemesState>;
  @useResult
  $Res call(
      {List<PhotoThemeModel> themes,
      int? selectedThemeId,
      List<PhotoThemeEntryModel> players,
      bool isLoading,
      String? error,
      List<PlayerModel> availablePlayers});
}

/// @nodoc
class _$PhotoThemesStateCopyWithImpl<$Res, $Val extends PhotoThemesState>
    implements $PhotoThemesStateCopyWith<$Res> {
  _$PhotoThemesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoThemesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themes = null,
    Object? selectedThemeId = freezed,
    Object? players = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? availablePlayers = null,
  }) {
    return _then(_value.copyWith(
      themes: null == themes
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<PhotoThemeModel>,
      selectedThemeId: freezed == selectedThemeId
          ? _value.selectedThemeId
          : selectedThemeId // ignore: cast_nullable_to_non_nullable
              as int?,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PhotoThemeEntryModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      availablePlayers: null == availablePlayers
          ? _value.availablePlayers
          : availablePlayers // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhotoThemesStateImplCopyWith<$Res>
    implements $PhotoThemesStateCopyWith<$Res> {
  factory _$$PhotoThemesStateImplCopyWith(_$PhotoThemesStateImpl value,
          $Res Function(_$PhotoThemesStateImpl) then) =
      __$$PhotoThemesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PhotoThemeModel> themes,
      int? selectedThemeId,
      List<PhotoThemeEntryModel> players,
      bool isLoading,
      String? error,
      List<PlayerModel> availablePlayers});
}

/// @nodoc
class __$$PhotoThemesStateImplCopyWithImpl<$Res>
    extends _$PhotoThemesStateCopyWithImpl<$Res, _$PhotoThemesStateImpl>
    implements _$$PhotoThemesStateImplCopyWith<$Res> {
  __$$PhotoThemesStateImplCopyWithImpl(_$PhotoThemesStateImpl _value,
      $Res Function(_$PhotoThemesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhotoThemesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themes = null,
    Object? selectedThemeId = freezed,
    Object? players = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? availablePlayers = null,
  }) {
    return _then(_$PhotoThemesStateImpl(
      themes: null == themes
          ? _value._themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<PhotoThemeModel>,
      selectedThemeId: freezed == selectedThemeId
          ? _value.selectedThemeId
          : selectedThemeId // ignore: cast_nullable_to_non_nullable
              as int?,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PhotoThemeEntryModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      availablePlayers: null == availablePlayers
          ? _value._availablePlayers
          : availablePlayers // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
    ));
  }
}

/// @nodoc

class _$PhotoThemesStateImpl implements _PhotoThemesState {
  const _$PhotoThemesStateImpl(
      {final List<PhotoThemeModel> themes = const [],
      this.selectedThemeId,
      final List<PhotoThemeEntryModel> players = const [],
      this.isLoading = true,
      this.error,
      final List<PlayerModel> availablePlayers = const []})
      : _themes = themes,
        _players = players,
        _availablePlayers = availablePlayers;

  final List<PhotoThemeModel> _themes;
  @override
  @JsonKey()
  List<PhotoThemeModel> get themes {
    if (_themes is EqualUnmodifiableListView) return _themes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_themes);
  }

  @override
  final int? selectedThemeId;
  final List<PhotoThemeEntryModel> _players;
  @override
  @JsonKey()
  List<PhotoThemeEntryModel> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  final List<PlayerModel> _availablePlayers;
  @override
  @JsonKey()
  List<PlayerModel> get availablePlayers {
    if (_availablePlayers is EqualUnmodifiableListView)
      return _availablePlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availablePlayers);
  }

  @override
  String toString() {
    return 'PhotoThemesState(themes: $themes, selectedThemeId: $selectedThemeId, players: $players, isLoading: $isLoading, error: $error, availablePlayers: $availablePlayers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoThemesStateImpl &&
            const DeepCollectionEquality().equals(other._themes, _themes) &&
            (identical(other.selectedThemeId, selectedThemeId) ||
                other.selectedThemeId == selectedThemeId) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other._availablePlayers, _availablePlayers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_themes),
      selectedThemeId,
      const DeepCollectionEquality().hash(_players),
      isLoading,
      error,
      const DeepCollectionEquality().hash(_availablePlayers));

  /// Create a copy of PhotoThemesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoThemesStateImplCopyWith<_$PhotoThemesStateImpl> get copyWith =>
      __$$PhotoThemesStateImplCopyWithImpl<_$PhotoThemesStateImpl>(
          this, _$identity);
}

abstract class _PhotoThemesState implements PhotoThemesState {
  const factory _PhotoThemesState(
      {final List<PhotoThemeModel> themes,
      final int? selectedThemeId,
      final List<PhotoThemeEntryModel> players,
      final bool isLoading,
      final String? error,
      final List<PlayerModel> availablePlayers}) = _$PhotoThemesStateImpl;

  @override
  List<PhotoThemeModel> get themes;
  @override
  int? get selectedThemeId;
  @override
  List<PhotoThemeEntryModel> get players;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  List<PlayerModel> get availablePlayers;

  /// Create a copy of PhotoThemesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoThemesStateImplCopyWith<_$PhotoThemesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
