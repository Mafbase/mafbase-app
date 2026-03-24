import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/profile/domain/model/tournament_subscription_plan_model.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    @Default(false) bool isLogoutLoading,
    String? login,
    PlayerModel? playerProfile,
    @Default(true) bool isLoadingSubscription,
    TournamentSubscriptionPlanModel? subscriptionPlan,
    String? subscriptionError,
    @Default(false) bool isBilling,
  }) = _ProfileState;
}
