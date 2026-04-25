import 'package:seating_generator_web/domain/models/billing_result.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/profile/domain/model/tournament_subscription_plan_model.dart';

abstract interface class ProfileRepository {
  Future<void> deleteAccount();
  Future<PlayerModel?> getUserProfile();
  Future<void> setUserProfile(PlayerModel player);
  Future<TournamentSubscriptionPlanModel> getTournamentSubscriptionCurrentPlan();
  Future<BillingResult> billTournamentSubscription({
    required TournamentSubscriptionTypeModel subscriptionType,
    required int days,
    required String redirectPath,
  });
}
