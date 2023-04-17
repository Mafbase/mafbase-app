// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'clubs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ClubsState {
  List<ClubModel> get clubs => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClubsStateCopyWith<ClubsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubsStateCopyWith<$Res> {
  factory $ClubsStateCopyWith(
          ClubsState value, $Res Function(ClubsState) then) =
      _$ClubsStateCopyWithImpl<$Res, ClubsState>;
  @useResult
  $Res call({List<ClubModel> clubs, bool isLoading});
}

/// @nodoc
class _$ClubsStateCopyWithImpl<$Res, $Val extends ClubsState>
    implements $ClubsStateCopyWith<$Res> {
  _$ClubsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubs = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      clubs: null == clubs
          ? _value.clubs
          : clubs // ignore: cast_nullable_to_non_nullable
              as List<ClubModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClubsStateCopyWith<$Res>
    implements $ClubsStateCopyWith<$Res> {
  factory _$$_ClubsStateCopyWith(
          _$_ClubsState value, $Res Function(_$_ClubsState) then) =
      __$$_ClubsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ClubModel> clubs, bool isLoading});
}

/// @nodoc
class __$$_ClubsStateCopyWithImpl<$Res>
    extends _$ClubsStateCopyWithImpl<$Res, _$_ClubsState>
    implements _$$_ClubsStateCopyWith<$Res> {
  __$$_ClubsStateCopyWithImpl(
      _$_ClubsState _value, $Res Function(_$_ClubsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubs = null,
    Object? isLoading = null,
  }) {
    return _then(_$_ClubsState(
      clubs: null == clubs
          ? _value._clubs
          : clubs // ignore: cast_nullable_to_non_nullable
              as List<ClubModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ClubsState implements _ClubsState {
  const _$_ClubsState(
      {final List<ClubModel> clubs = const [], this.isLoading = true})
      : _clubs = clubs;

  final List<ClubModel> _clubs;
  @override
  @JsonKey()
  List<ClubModel> get clubs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clubs);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ClubsState(clubs: $clubs, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClubsState &&
            const DeepCollectionEquality().equals(other._clubs, _clubs) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_clubs), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClubsStateCopyWith<_$_ClubsState> get copyWith =>
      __$$_ClubsStateCopyWithImpl<_$_ClubsState>(this, _$identity);
}

abstract class _ClubsState implements ClubsState {
  const factory _ClubsState(
      {final List<ClubModel> clubs, final bool isLoading}) = _$_ClubsState;

  @override
  List<ClubModel> get clubs;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_ClubsStateCopyWith<_$_ClubsState> get copyWith =>
      throw _privateConstructorUsedError;
}
