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
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoading, List<TournamentModel> tournaments)
        tournaments,
    required TResult Function() regulations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, List<TournamentModel> tournaments)?
        tournaments,
    TResult Function()? regulations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, List<TournamentModel> tournaments)?
        tournaments,
    TResult Function()? regulations,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainStateTournaments value) tournaments,
    required TResult Function(MainStateRegulations value) regulations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MainStateTournaments value)? tournaments,
    TResult Function(MainStateRegulations value)? regulations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainStateTournaments value)? tournaments,
    TResult Function(MainStateRegulations value)? regulations,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainStateCopyWith<$Res> {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) then) =
      _$MainStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$MainStateCopyWithImpl<$Res> implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._value, this._then);

  final MainState _value;
  // ignore: unused_field
  final $Res Function(MainState) _then;
}

/// @nodoc
abstract class _$$MainStateTournamentsCopyWith<$Res> {
  factory _$$MainStateTournamentsCopyWith(_$MainStateTournaments value,
          $Res Function(_$MainStateTournaments) then) =
      __$$MainStateTournamentsCopyWithImpl<$Res>;
  $Res call({bool isLoading, List<TournamentModel> tournaments});
}

/// @nodoc
class __$$MainStateTournamentsCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res>
    implements _$$MainStateTournamentsCopyWith<$Res> {
  __$$MainStateTournamentsCopyWithImpl(_$MainStateTournaments _value,
      $Res Function(_$MainStateTournaments) _then)
      : super(_value, (v) => _then(v as _$MainStateTournaments));

  @override
  _$MainStateTournaments get _value => super._value as _$MainStateTournaments;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? tournaments = freezed,
  }) {
    return _then(_$MainStateTournaments(
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

class _$MainStateTournaments implements MainStateTournaments {
  const _$MainStateTournaments(
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
            other is _$MainStateTournaments &&
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
  _$$MainStateTournamentsCopyWith<_$MainStateTournaments> get copyWith =>
      __$$MainStateTournamentsCopyWithImpl<_$MainStateTournaments>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoading, List<TournamentModel> tournaments)
        tournaments,
    required TResult Function() regulations,
  }) {
    return tournaments(isLoading, this.tournaments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, List<TournamentModel> tournaments)?
        tournaments,
    TResult Function()? regulations,
  }) {
    return tournaments?.call(isLoading, this.tournaments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, List<TournamentModel> tournaments)?
        tournaments,
    TResult Function()? regulations,
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
    required TResult Function(MainStateTournaments value) tournaments,
    required TResult Function(MainStateRegulations value) regulations,
  }) {
    return tournaments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MainStateTournaments value)? tournaments,
    TResult Function(MainStateRegulations value)? regulations,
  }) {
    return tournaments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainStateTournaments value)? tournaments,
    TResult Function(MainStateRegulations value)? regulations,
    required TResult orElse(),
  }) {
    if (tournaments != null) {
      return tournaments(this);
    }
    return orElse();
  }
}

abstract class MainStateTournaments implements MainState {
  const factory MainStateTournaments(
          {required final bool isLoading,
          required final List<TournamentModel> tournaments}) =
      _$MainStateTournaments;

  bool get isLoading;
  List<TournamentModel> get tournaments;
  @JsonKey(ignore: true)
  _$$MainStateTournamentsCopyWith<_$MainStateTournaments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MainStateRegulationsCopyWith<$Res> {
  factory _$$MainStateRegulationsCopyWith(_$MainStateRegulations value,
          $Res Function(_$MainStateRegulations) then) =
      __$$MainStateRegulationsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainStateRegulationsCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res>
    implements _$$MainStateRegulationsCopyWith<$Res> {
  __$$MainStateRegulationsCopyWithImpl(_$MainStateRegulations _value,
      $Res Function(_$MainStateRegulations) _then)
      : super(_value, (v) => _then(v as _$MainStateRegulations));

  @override
  _$MainStateRegulations get _value => super._value as _$MainStateRegulations;
}

/// @nodoc

class _$MainStateRegulations implements MainStateRegulations {
  const _$MainStateRegulations();

  @override
  String toString() {
    return 'MainState.regulations()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MainStateRegulations);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoading, List<TournamentModel> tournaments)
        tournaments,
    required TResult Function() regulations,
  }) {
    return regulations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, List<TournamentModel> tournaments)?
        tournaments,
    TResult Function()? regulations,
  }) {
    return regulations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, List<TournamentModel> tournaments)?
        tournaments,
    TResult Function()? regulations,
    required TResult orElse(),
  }) {
    if (regulations != null) {
      return regulations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainStateTournaments value) tournaments,
    required TResult Function(MainStateRegulations value) regulations,
  }) {
    return regulations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MainStateTournaments value)? tournaments,
    TResult Function(MainStateRegulations value)? regulations,
  }) {
    return regulations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainStateTournaments value)? tournaments,
    TResult Function(MainStateRegulations value)? regulations,
    required TResult orElse(),
  }) {
    if (regulations != null) {
      return regulations(this);
    }
    return orElse();
  }
}

abstract class MainStateRegulations implements MainState {
  const factory MainStateRegulations() = _$MainStateRegulations;
}
