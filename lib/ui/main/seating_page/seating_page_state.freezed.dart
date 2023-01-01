// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seating_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeatingPageState {
  List<Pair<PlayerModel, PlayerModel>> get cannotMeet =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeatingPageStateCopyWith<SeatingPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatingPageStateCopyWith<$Res> {
  factory $SeatingPageStateCopyWith(
          SeatingPageState value, $Res Function(SeatingPageState) then) =
      _$SeatingPageStateCopyWithImpl<$Res, SeatingPageState>;
  @useResult
  $Res call({List<Pair<PlayerModel, PlayerModel>> cannotMeet, bool isLoading});
}

/// @nodoc
class _$SeatingPageStateCopyWithImpl<$Res, $Val extends SeatingPageState>
    implements $SeatingPageStateCopyWith<$Res> {
  _$SeatingPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cannotMeet = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      cannotMeet: null == cannotMeet
          ? _value.cannotMeet
          : cannotMeet // ignore: cast_nullable_to_non_nullable
              as List<Pair<PlayerModel, PlayerModel>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SeatingPageStateCopyWith<$Res>
    implements $SeatingPageStateCopyWith<$Res> {
  factory _$$_SeatingPageStateCopyWith(
          _$_SeatingPageState value, $Res Function(_$_SeatingPageState) then) =
      __$$_SeatingPageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Pair<PlayerModel, PlayerModel>> cannotMeet, bool isLoading});
}

/// @nodoc
class __$$_SeatingPageStateCopyWithImpl<$Res>
    extends _$SeatingPageStateCopyWithImpl<$Res, _$_SeatingPageState>
    implements _$$_SeatingPageStateCopyWith<$Res> {
  __$$_SeatingPageStateCopyWithImpl(
      _$_SeatingPageState _value, $Res Function(_$_SeatingPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cannotMeet = null,
    Object? isLoading = null,
  }) {
    return _then(_$_SeatingPageState(
      cannotMeet: null == cannotMeet
          ? _value._cannotMeet
          : cannotMeet // ignore: cast_nullable_to_non_nullable
              as List<Pair<PlayerModel, PlayerModel>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SeatingPageState implements _SeatingPageState {
  const _$_SeatingPageState(
      {final List<Pair<PlayerModel, PlayerModel>> cannotMeet = const [],
      this.isLoading = true})
      : _cannotMeet = cannotMeet;

  final List<Pair<PlayerModel, PlayerModel>> _cannotMeet;
  @override
  @JsonKey()
  List<Pair<PlayerModel, PlayerModel>> get cannotMeet {
    if (_cannotMeet is EqualUnmodifiableListView) return _cannotMeet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cannotMeet);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'SeatingPageState(cannotMeet: $cannotMeet, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeatingPageState &&
            const DeepCollectionEquality()
                .equals(other._cannotMeet, _cannotMeet) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cannotMeet), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeatingPageStateCopyWith<_$_SeatingPageState> get copyWith =>
      __$$_SeatingPageStateCopyWithImpl<_$_SeatingPageState>(this, _$identity);
}

abstract class _SeatingPageState implements SeatingPageState {
  const factory _SeatingPageState(
      {final List<Pair<PlayerModel, PlayerModel>> cannotMeet,
      final bool isLoading}) = _$_SeatingPageState;

  @override
  List<Pair<PlayerModel, PlayerModel>> get cannotMeet;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_SeatingPageStateCopyWith<_$_SeatingPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
