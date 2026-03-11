// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLogoutLoading => throw _privateConstructorUsedError;
  String? get login => throw _privateConstructorUsedError;
  PlayerModel? get playerProfile => throw _privateConstructorUsedError;
  bool get isLoadingSubscription => throw _privateConstructorUsedError;
  TournamentSubscriptionPlanModel? get subscriptionPlan =>
      throw _privateConstructorUsedError;
  String? get subscriptionError => throw _privateConstructorUsedError;
  bool get isBilling => throw _privateConstructorUsedError;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isLogoutLoading,
      String? login,
      PlayerModel? playerProfile,
      bool isLoadingSubscription,
      TournamentSubscriptionPlanModel? subscriptionPlan,
      String? subscriptionError,
      bool isBilling});

  $PlayerModelCopyWith<$Res>? get playerProfile;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLogoutLoading = null,
    Object? login = freezed,
    Object? playerProfile = freezed,
    Object? isLoadingSubscription = null,
    Object? subscriptionPlan = freezed,
    Object? subscriptionError = freezed,
    Object? isBilling = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLogoutLoading: null == isLogoutLoading
          ? _value.isLogoutLoading
          : isLogoutLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String?,
      playerProfile: freezed == playerProfile
          ? _value.playerProfile
          : playerProfile // ignore: cast_nullable_to_non_nullable
              as PlayerModel?,
      isLoadingSubscription: null == isLoadingSubscription
          ? _value.isLoadingSubscription
          : isLoadingSubscription // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptionPlan: freezed == subscriptionPlan
          ? _value.subscriptionPlan
          : subscriptionPlan // ignore: cast_nullable_to_non_nullable
              as TournamentSubscriptionPlanModel?,
      subscriptionError: freezed == subscriptionError
          ? _value.subscriptionError
          : subscriptionError // ignore: cast_nullable_to_non_nullable
              as String?,
      isBilling: null == isBilling
          ? _value.isBilling
          : isBilling // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerModelCopyWith<$Res>? get playerProfile {
    if (_value.playerProfile == null) {
      return null;
    }

    return $PlayerModelCopyWith<$Res>(_value.playerProfile!, (value) {
      return _then(_value.copyWith(playerProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileStateImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ProfileStateImplCopyWith(
          _$ProfileStateImpl value, $Res Function(_$ProfileStateImpl) then) =
      __$$ProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isLogoutLoading,
      String? login,
      PlayerModel? playerProfile,
      bool isLoadingSubscription,
      TournamentSubscriptionPlanModel? subscriptionPlan,
      String? subscriptionError,
      bool isBilling});

  @override
  $PlayerModelCopyWith<$Res>? get playerProfile;
}

/// @nodoc
class __$$ProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileStateImpl>
    implements _$$ProfileStateImplCopyWith<$Res> {
  __$$ProfileStateImplCopyWithImpl(
      _$ProfileStateImpl _value, $Res Function(_$ProfileStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLogoutLoading = null,
    Object? login = freezed,
    Object? playerProfile = freezed,
    Object? isLoadingSubscription = null,
    Object? subscriptionPlan = freezed,
    Object? subscriptionError = freezed,
    Object? isBilling = null,
  }) {
    return _then(_$ProfileStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLogoutLoading: null == isLogoutLoading
          ? _value.isLogoutLoading
          : isLogoutLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String?,
      playerProfile: freezed == playerProfile
          ? _value.playerProfile
          : playerProfile // ignore: cast_nullable_to_non_nullable
              as PlayerModel?,
      isLoadingSubscription: null == isLoadingSubscription
          ? _value.isLoadingSubscription
          : isLoadingSubscription // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptionPlan: freezed == subscriptionPlan
          ? _value.subscriptionPlan
          : subscriptionPlan // ignore: cast_nullable_to_non_nullable
              as TournamentSubscriptionPlanModel?,
      subscriptionError: freezed == subscriptionError
          ? _value.subscriptionError
          : subscriptionError // ignore: cast_nullable_to_non_nullable
              as String?,
      isBilling: null == isBilling
          ? _value.isBilling
          : isBilling // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ProfileStateImpl implements _ProfileState {
  const _$ProfileStateImpl(
      {this.isLoading = false,
      this.isLogoutLoading = false,
      this.login,
      this.playerProfile,
      this.isLoadingSubscription = true,
      this.subscriptionPlan,
      this.subscriptionError,
      this.isBilling = false});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLogoutLoading;
  @override
  final String? login;
  @override
  final PlayerModel? playerProfile;
  @override
  @JsonKey()
  final bool isLoadingSubscription;
  @override
  final TournamentSubscriptionPlanModel? subscriptionPlan;
  @override
  final String? subscriptionError;
  @override
  @JsonKey()
  final bool isBilling;

  @override
  String toString() {
    return 'ProfileState(isLoading: $isLoading, isLogoutLoading: $isLogoutLoading, login: $login, playerProfile: $playerProfile, isLoadingSubscription: $isLoadingSubscription, subscriptionPlan: $subscriptionPlan, subscriptionError: $subscriptionError, isBilling: $isBilling)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLogoutLoading, isLogoutLoading) ||
                other.isLogoutLoading == isLogoutLoading) &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.playerProfile, playerProfile) ||
                other.playerProfile == playerProfile) &&
            (identical(other.isLoadingSubscription, isLoadingSubscription) ||
                other.isLoadingSubscription == isLoadingSubscription) &&
            (identical(other.subscriptionPlan, subscriptionPlan) ||
                other.subscriptionPlan == subscriptionPlan) &&
            (identical(other.subscriptionError, subscriptionError) ||
                other.subscriptionError == subscriptionError) &&
            (identical(other.isBilling, isBilling) ||
                other.isBilling == isBilling));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isLogoutLoading,
      login,
      playerProfile,
      isLoadingSubscription,
      subscriptionPlan,
      subscriptionError,
      isBilling);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      __$$ProfileStateImplCopyWithImpl<_$ProfileStateImpl>(this, _$identity);
}

abstract class _ProfileState implements ProfileState {
  const factory _ProfileState(
      {final bool isLoading,
      final bool isLogoutLoading,
      final String? login,
      final PlayerModel? playerProfile,
      final bool isLoadingSubscription,
      final TournamentSubscriptionPlanModel? subscriptionPlan,
      final String? subscriptionError,
      final bool isBilling}) = _$ProfileStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLogoutLoading;
  @override
  String? get login;
  @override
  PlayerModel? get playerProfile;
  @override
  bool get isLoadingSubscription;
  @override
  TournamentSubscriptionPlanModel? get subscriptionPlan;
  @override
  String? get subscriptionError;
  @override
  bool get isBilling;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
