// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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

  @JsonKey(ignore: true)
  $TranslationContentStateCopyWith<TranslationContentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationContentStateCopyWith<$Res> {
  factory $TranslationContentStateCopyWith(TranslationContentState value,
          $Res Function(TranslationContentState) then) =
      _$TranslationContentStateCopyWithImpl<$Res>;
  $Res call(
      {List<PlayerRole>? roles,
      List<PlayerStatus>? statuses,
      List<String>? images,
      List<String>? nicknames});
}

/// @nodoc
class _$TranslationContentStateCopyWithImpl<$Res>
    implements $TranslationContentStateCopyWith<$Res> {
  _$TranslationContentStateCopyWithImpl(this._value, this._then);

  final TranslationContentState _value;
  // ignore: unused_field
  final $Res Function(TranslationContentState) _then;

  @override
  $Res call({
    Object? roles = freezed,
    Object? statuses = freezed,
    Object? images = freezed,
    Object? nicknames = freezed,
  }) {
    return _then(_value.copyWith(
      roles: roles == freezed
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PlayerRole>?,
      statuses: statuses == freezed
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as List<PlayerStatus>?,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nicknames: nicknames == freezed
          ? _value.nicknames
          : nicknames // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$$_TranslationContentStateCopyWith<$Res>
    implements $TranslationContentStateCopyWith<$Res> {
  factory _$$_TranslationContentStateCopyWith(_$_TranslationContentState value,
          $Res Function(_$_TranslationContentState) then) =
      __$$_TranslationContentStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<PlayerRole>? roles,
      List<PlayerStatus>? statuses,
      List<String>? images,
      List<String>? nicknames});
}

/// @nodoc
class __$$_TranslationContentStateCopyWithImpl<$Res>
    extends _$TranslationContentStateCopyWithImpl<$Res>
    implements _$$_TranslationContentStateCopyWith<$Res> {
  __$$_TranslationContentStateCopyWithImpl(_$_TranslationContentState _value,
      $Res Function(_$_TranslationContentState) _then)
      : super(_value, (v) => _then(v as _$_TranslationContentState));

  @override
  _$_TranslationContentState get _value =>
      super._value as _$_TranslationContentState;

  @override
  $Res call({
    Object? roles = freezed,
    Object? statuses = freezed,
    Object? images = freezed,
    Object? nicknames = freezed,
  }) {
    return _then(_$_TranslationContentState(
      roles: roles == freezed
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<PlayerRole>?,
      statuses: statuses == freezed
          ? _value._statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as List<PlayerStatus>?,
      images: images == freezed
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nicknames: nicknames == freezed
          ? _value._nicknames
          : nicknames // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$_TranslationContentState implements _TranslationContentState {
  const _$_TranslationContentState(
      {final List<PlayerRole>? roles,
      final List<PlayerStatus>? statuses,
      final List<String>? images,
      final List<String>? nicknames})
      : _roles = roles,
        _statuses = statuses,
        _images = images,
        _nicknames = nicknames;

  final List<PlayerRole>? _roles;
  @override
  List<PlayerRole>? get roles {
    final value = _roles;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PlayerStatus>? _statuses;
  @override
  List<PlayerStatus>? get statuses {
    final value = _statuses;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _nicknames;
  @override
  List<String>? get nicknames {
    final value = _nicknames;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TranslationContentState(roles: $roles, statuses: $statuses, images: $images, nicknames: $nicknames)';
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
                .equals(other._nicknames, _nicknames));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_roles),
      const DeepCollectionEquality().hash(_statuses),
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_nicknames));

  @JsonKey(ignore: true)
  @override
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
      final List<String>? nicknames}) = _$_TranslationContentState;

  @override
  List<PlayerRole>? get roles;
  @override
  List<PlayerStatus>? get statuses;
  @override
  List<String>? get images;
  @override
  List<String>? get nicknames;
  @override
  @JsonKey(ignore: true)
  _$$_TranslationContentStateCopyWith<_$_TranslationContentState>
      get copyWith => throw _privateConstructorUsedError;
}
