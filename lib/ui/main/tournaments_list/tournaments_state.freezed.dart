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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TournamentsState {
  List<TournamentModel> get tournaments => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of TournamentsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of TournamentsState
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$TournamentsStateImplCopyWith<$Res>
    implements $TournamentsStateCopyWith<$Res> {
  factory _$$TournamentsStateImplCopyWith(_$TournamentsStateImpl value,
          $Res Function(_$TournamentsStateImpl) then) =
      __$$TournamentsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TournamentModel> tournaments, bool isLoading});
}

/// @nodoc
class __$$TournamentsStateImplCopyWithImpl<$Res>
    extends _$TournamentsStateCopyWithImpl<$Res, _$TournamentsStateImpl>
    implements _$$TournamentsStateImplCopyWith<$Res> {
  __$$TournamentsStateImplCopyWithImpl(_$TournamentsStateImpl _value,
      $Res Function(_$TournamentsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournaments = null,
    Object? isLoading = null,
  }) {
    return _then(_$TournamentsStateImpl(
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

class _$TournamentsStateImpl implements _TournamentsState {
  const _$TournamentsStateImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentsStateImpl &&
            const DeepCollectionEquality()
                .equals(other._tournaments, _tournaments) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_tournaments), isLoading);

  /// Create a copy of TournamentsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentsStateImplCopyWith<_$TournamentsStateImpl> get copyWith =>
      __$$TournamentsStateImplCopyWithImpl<_$TournamentsStateImpl>(
          this, _$identity);
}

abstract class _TournamentsState implements TournamentsState {
  const factory _TournamentsState(
      {required final List<TournamentModel> tournaments,
      required final bool isLoading}) = _$TournamentsStateImpl;

  @override
  List<TournamentModel> get tournaments;
  @override
  bool get isLoading;

  /// Create a copy of TournamentsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentsStateImplCopyWith<_$TournamentsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
