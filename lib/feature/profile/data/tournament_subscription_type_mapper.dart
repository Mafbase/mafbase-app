import 'package:seating_generator_web/feature/profile/domain/model/tournament_subscription_plan_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

extension TournamentSubscriptionTypeToProto on TournamentSubscriptionTypeModel {
  TournamentSubscriptionType toProto() {
    switch (this) {
      case TournamentSubscriptionTypeModel.unknownTournamentSubscriptionType:
        return TournamentSubscriptionType.unknownTournamentSubscriptionType;
      case TournamentSubscriptionTypeModel.tournamentWithAllAddons10Players:
        return TournamentSubscriptionType.tournamentWithAllAddons10Players;
    }
  }
}

extension TournamentSubscriptionTypeToDomain on TournamentSubscriptionType {
  TournamentSubscriptionTypeModel toDomain() {
    switch (this) {
      case TournamentSubscriptionType.unknownTournamentSubscriptionType:
        return TournamentSubscriptionTypeModel
            .unknownTournamentSubscriptionType;
      case TournamentSubscriptionType.tournamentWithAllAddons10Players:
        return TournamentSubscriptionTypeModel.tournamentWithAllAddons10Players;
      default:
        return TournamentSubscriptionTypeModel
            .unknownTournamentSubscriptionType;
    }
  }
}
