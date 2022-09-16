// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'main_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MainState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<TournamentModel> get tournaments => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoading, List<TournamentModel> tournaments)
        tournaments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, List<TournamentModel> tournaments)?
        tournaments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, List<TournamentModel> tournaments)?
        tournaments,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Tournaments value) tournaments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Tournaments value)? tournaments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Tournaments value)? tournaments,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainStateCopyWith<MainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainStateCopyWith<$Res> {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) then) =
      _$MainStateCopyWithImpl<$Res>;
  $Res call({bool isLoading, List<TournamentModel> tournaments});
}

/// @nodoc
class _$MainStateCopyWithImpl<$Res> implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._value, this._then);

  final MainState _value;
  // ignore: unused_field
  final $Res Function(MainState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? tournaments = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      tournaments: tournaments == freezed
          ? _value.tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<TournamentModel>,
    ));
  }
}

/// @nodoc
abstract class _$$TournamentsCopyWith<$Res>
    implements $MainStateCopyWith<$Res> {
  factory _$$TournamentsCopyWith(
          _$Tournaments value, $Res Function(_$Tournaments) then) =
      __$$TournamentsCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoading, List<TournamentModel> tournaments});
}

/// @nodoc
class __$$TournamentsCopyWithImpl<$Res> extends _$MainStateCopyWithImpl<$Res>
    implements _$$TournamentsCopyWith<$Res> {
  __$$TournamentsCopyWithImpl(
      _$Tournaments _value, $Res Function(_$Tournaments) _then)
      : super(_value, (v) => _then(v as _$Tournaments));

  @override
  _$Tournaments get _value => super._value as _$Tournaments;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? tournaments = freezed,
  }) {
    return _then(_$Tournaments(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      tournaments: tournaments == freezed
          ? _value._tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<TournamentModel>,
    ));
  }
}

/// @nodoc

class _$Tournaments implements Tournaments {
  const _$Tournaments(
      {required this.isLoading,
      required final List<TournamentModel> tournaments})
      : _tournaments = tournaments;

  @override
  final bool isLoading;
  final List<TournamentModel> _tournaments;
  @override
  List<TournamentModel> get tournaments {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tournaments);
  }

  @override
  String toString() {
    return 'MainState.tournaments(isLoading: $isLoading, tournaments: $tournaments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Tournaments &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other._tournaments, _tournaments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(_tournaments));

  @JsonKey(ignore: true)
  @override
  _$$TournamentsCopyWith<_$Tournaments> get copyWith =>
      __$$TournamentsCopyWithImpl<_$Tournaments>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoading, List<TournamentModel> tournaments)
        tournaments,
  }) {
    return tournaments(isLoading, this.tournaments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, List<TournamentModel> tournaments)?
        tournaments,
  }) {
    return tournaments?.call(isLoading, this.tournaments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, List<TournamentModel> tournaments)?
        tournaments,
    required TResult orElse(),
  }) {
    if (tournaments != null) {
      return tournaments(isLoading, this.tournaments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Tournaments value) tournaments,
  }) {
    return tournaments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Tournaments value)? tournaments,
  }) {
    return tournaments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Tournaments value)? tournaments,
    required TResult orElse(),
  }) {
    if (tournaments != null) {
      return tournaments(this);
    }
    return orElse();
  }
}

abstract class Tournaments implements MainState {
  const factory Tournaments(
      {required final bool isLoading,
      required final List<TournamentModel> tournaments}) = _$Tournaments;

  @override
  bool get isLoading;
  @override
  List<TournamentModel> get tournaments;
  @override
  @JsonKey(ignore: true)
  _$$TournamentsCopyWith<_$Tournaments> get copyWith =>
      throw _privateConstructorUsedError;
}
