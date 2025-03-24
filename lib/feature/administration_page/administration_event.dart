sealed class AdministrationEvent {}

class AdministrationEventPageOpened extends AdministrationEvent {
  final int tournamentId;

  AdministrationEventPageOpened({
    required this.tournamentId,
  });
}

class AdministrationEventAddOwner extends AdministrationEvent {
  final int tournamentId;
  final String email;

  AdministrationEventAddOwner({
    required this.tournamentId,
    required this.email,
  });
}

class AdministrationEventDeleteOwner extends AdministrationEvent {
  final int tournamentId;
  final int ownerId;

  AdministrationEventDeleteOwner({
    required this.tournamentId,
    required this.ownerId,
  });
}
