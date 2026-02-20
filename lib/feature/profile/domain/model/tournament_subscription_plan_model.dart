enum TournamentSubscriptionTypeModel {
  unknownTournamentSubscriptionType,
  tournamentWithAllAddons10Players,
}

class TournamentSubscriptionPlanModel {
  final bool isActive;
  final TournamentSubscriptionTypeModel? subscriptionType;
  final DateTime? billedFor;

  const TournamentSubscriptionPlanModel({
    required this.isActive,
    required this.subscriptionType,
    required this.billedFor,
  });
}
