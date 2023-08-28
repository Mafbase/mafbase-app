// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournaments_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TournamentsState {
  List<TournamentModel> get tournaments => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TournamentsStateCopyWith<TournamentsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentsStateCopyWith<$Res> {
  factory $TournamentsStateCopyWith(
          TournamentsState value, $Res Function(TournamentsState) then) =
      _$TournamentsStateCopyWithImpl<$Res, TournamentsState>;
  @useResult
  $Res call({List<TournamentModel> tournaments, bool isLoading});
}

/// @nodoc
class _$TournamentsStateCopyWithImpl<$Res, $Val extends TournamentsState>
    implements $TournamentsStateCopyWith<$Res> {
  _$TournamentsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournaments = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      tournaments: null == tournaments
          ? _value.tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<TournamentModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TournamentsStateCopyWith<$Res>
    implements $TournamentsStateCopyWith<$Res> {
  factory _$$_TournamentsStateCopyWith(
          _$_TournamentsState value, $Res Function(_$_TournamentsState) then) =
      __$$_TournamentsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TournamentModel> tournaments, bool isLoading});
}

/// @nodoc
class __$$_TournamentsStateCopyWithImpl<$Res>
    extends _$TournamentsStateCopyWithImpl<$Res, _$_TournamentsState>
    implements _$$_TournamentsStateCopyWith<$Res> {
  __$$_TournamentsStateCopyWithImpl(
      _$_TournamentsState _value, $Res Function(_$_TournamentsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournaments = null,
    Object? isLoading = null,
  }) {
    return _then(_$_TournamentsState(
      tournaments: null == tournaments
          ? _value._tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<TournamentModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TournamentsState implements _TournamentsState {
  const _$_TournamentsState(
      {required final List<TournamentModel> tournaments,
      required this.isLoading})
      : _tournaments = tournaments;

  final List<TournamentModel> _tournaments;
  @override
  List<TournamentModel> get tournaments {
    if (_tournaments is EqualUnmodifiableListView) return _tournaments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tournaments);
  }

  @override
  final bool isLoading;

  @override
  String toString() {
    return 'TournamentsState(tournaments: $tournaments, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TournamentsState &&
            const DeepCollectionEquality()
                .equals(other._tournaments, _tournaments) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_tournaments), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TournamentsStateCopyWith<_$_TournamentsState> get copyWith =>
      __$$_TournamentsStateCopyWithImpl<_$_TournamentsState>(this, _$identity);
}

abstract class _TournamentsState implements TournamentsState {
  const factory _TournamentsState(
      {required final List<TournamentModel> tournaments,
      required final bool isLoading}) = _$_TournamentsState;

  @override
  List<TournamentModel> get tournaments;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_TournamentsStateCopyWith<_$_TournamentsState> get copyWith =>
      throw _privateConstructorUsedError;
}
