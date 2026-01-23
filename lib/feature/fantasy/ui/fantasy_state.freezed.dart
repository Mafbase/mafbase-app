// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fantasy_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FantasyState {
  bool get isLoading => throw _privateConstructorUsedError;
  FantasyRatingModel? get rating => throw _privateConstructorUsedError;
  FantasyCurrentGameInfoModel? get currentGameInfo =>
      throw _privateConstructorUsedError;
  List<UserModel> get participants => throw _privateConstructorUsedError;
  GameWin? get selectedPrediction => throw _privateConstructorUsedError;
  bool get isOwner => throw _privateConstructorUsedError;

  /// Create a copy of FantasyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FantasyStateCopyWith<FantasyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FantasyStateCopyWith<$Res> {
  factory $FantasyStateCopyWith(
          FantasyState value, $Res Function(FantasyState) then) =
      _$FantasyStateCopyWithImpl<$Res, FantasyState>;
  @useResult
  $Res call(
      {bool isLoading,
      FantasyRatingModel? rating,
      FantasyCurrentGameInfoModel? currentGameInfo,
      List<UserModel> participants,
      GameWin? selectedPrediction,
      bool isOwner});

  $FantasyRatingModelCopyWith<$Res>? get rating;
  $FantasyCurrentGameInfoModelCopyWith<$Res>? get currentGameInfo;
}

/// @nodoc
class _$FantasyStateCopyWithImpl<$Res, $Val extends FantasyState>
    implements $FantasyStateCopyWith<$Res> {
  _$FantasyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FantasyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? rating = freezed,
    Object? currentGameInfo = freezed,
    Object? participants = null,
    Object? selectedPrediction = freezed,
    Object? isOwner = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as FantasyRatingModel?,
      currentGameInfo: freezed == currentGameInfo
          ? _value.currentGameInfo
          : currentGameInfo // ignore: cast_nullable_to_non_nullable
              as FantasyCurrentGameInfoModel?,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      selectedPrediction: freezed == selectedPrediction
          ? _value.selectedPrediction
          : selectedPrediction // ignore: cast_nullable_to_non_nullable
              as GameWin?,
      isOwner: null == isOwner
          ? _value.isOwner
          : isOwner // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of FantasyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FantasyRatingModelCopyWith<$Res>? get rating {
    if (_value.rating == null) {
      return null;
    }

    return $FantasyRatingModelCopyWith<$Res>(_value.rating!, (value) {
      return _then(_value.copyWith(rating: value) as $Val);
    });
  }

  /// Create a copy of FantasyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FantasyCurrentGameInfoModelCopyWith<$Res>? get currentGameInfo {
    if (_value.currentGameInfo == null) {
      return null;
    }

    return $FantasyCurrentGameInfoModelCopyWith<$Res>(_value.currentGameInfo!,
        (value) {
      return _then(_value.copyWith(currentGameInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FantasyStateImplCopyWith<$Res>
    implements $FantasyStateCopyWith<$Res> {
  factory _$$FantasyStateImplCopyWith(
          _$FantasyStateImpl value, $Res Function(_$FantasyStateImpl) then) =
      __$$FantasyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      FantasyRatingModel? rating,
      FantasyCurrentGameInfoModel? currentGameInfo,
      List<UserModel> participants,
      GameWin? selectedPrediction,
      bool isOwner});

  @override
  $FantasyRatingModelCopyWith<$Res>? get rating;
  @override
  $FantasyCurrentGameInfoModelCopyWith<$Res>? get currentGameInfo;
}

/// @nodoc
class __$$FantasyStateImplCopyWithImpl<$Res>
    extends _$FantasyStateCopyWithImpl<$Res, _$FantasyStateImpl>
    implements _$$FantasyStateImplCopyWith<$Res> {
  __$$FantasyStateImplCopyWithImpl(
      _$FantasyStateImpl _value, $Res Function(_$FantasyStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FantasyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? rating = freezed,
    Object? currentGameInfo = freezed,
    Object? participants = null,
    Object? selectedPrediction = freezed,
    Object? isOwner = null,
  }) {
    return _then(_$FantasyStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as FantasyRatingModel?,
      currentGameInfo: freezed == currentGameInfo
          ? _value.currentGameInfo
          : currentGameInfo // ignore: cast_nullable_to_non_nullable
              as FantasyCurrentGameInfoModel?,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      selectedPrediction: freezed == selectedPrediction
          ? _value.selectedPrediction
          : selectedPrediction // ignore: cast_nullable_to_non_nullable
              as GameWin?,
      isOwner: null == isOwner
          ? _value.isOwner
          : isOwner // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FantasyStateImpl implements _FantasyState {
  const _$FantasyStateImpl(
      {this.isLoading = true,
      this.rating,
      this.currentGameInfo,
      final List<UserModel> participants = const [],
      this.selectedPrediction,
      this.isOwner = false})
      : _participants = participants;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final FantasyRatingModel? rating;
  @override
  final FantasyCurrentGameInfoModel? currentGameInfo;
  final List<UserModel> _participants;
  @override
  @JsonKey()
  List<UserModel> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  final GameWin? selectedPrediction;
  @override
  @JsonKey()
  final bool isOwner;

  @override
  String toString() {
    return 'FantasyState(isLoading: $isLoading, rating: $rating, currentGameInfo: $currentGameInfo, participants: $participants, selectedPrediction: $selectedPrediction, isOwner: $isOwner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FantasyStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.currentGameInfo, currentGameInfo) ||
                other.currentGameInfo == currentGameInfo) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.selectedPrediction, selectedPrediction) ||
                other.selectedPrediction == selectedPrediction) &&
            (identical(other.isOwner, isOwner) || other.isOwner == isOwner));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      rating,
      currentGameInfo,
      const DeepCollectionEquality().hash(_participants),
      selectedPrediction,
      isOwner);

  /// Create a copy of FantasyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FantasyStateImplCopyWith<_$FantasyStateImpl> get copyWith =>
      __$$FantasyStateImplCopyWithImpl<_$FantasyStateImpl>(this, _$identity);
}

abstract class _FantasyState implements FantasyState {
  const factory _FantasyState(
      {final bool isLoading,
      final FantasyRatingModel? rating,
      final FantasyCurrentGameInfoModel? currentGameInfo,
      final List<UserModel> participants,
      final GameWin? selectedPrediction,
      final bool isOwner}) = _$FantasyStateImpl;

  @override
  bool get isLoading;
  @override
  FantasyRatingModel? get rating;
  @override
  FantasyCurrentGameInfoModel? get currentGameInfo;
  @override
  List<UserModel> get participants;
  @override
  GameWin? get selectedPrediction;
  @override
  bool get isOwner;

  /// Create a copy of FantasyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FantasyStateImplCopyWith<_$FantasyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
