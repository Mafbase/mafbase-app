import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

sealed class FantasyEvent {}

class FantasyEventInit implements FantasyEvent {
  final int tournamentId;
  final bool isOwner;
  final int? userId;

  const FantasyEventInit({
    required this.tournamentId,
    required this.isOwner,
    this.userId,
  });
}

class FantasyEventRefresh implements FantasyEvent {
  final int tournamentId;

  const FantasyEventRefresh({required this.tournamentId});
}

class FantasyEventSetPrediction implements FantasyEvent {
  final int tournamentId;
  final GameWin prediction;

  const FantasyEventSetPrediction({
    required this.tournamentId,
    required this.prediction,
  });
}

class FantasyEventAddParticipant implements FantasyEvent {
  final int tournamentId;
  final String email;

  const FantasyEventAddParticipant({
    required this.tournamentId,
    required this.email,
  });
}

class FantasyEventRemoveParticipant implements FantasyEvent {
  final int tournamentId;
  final int userId;

  const FantasyEventRemoveParticipant({
    required this.tournamentId,
    required this.userId,
  });
}

class FantasyEventLoadParticipants implements FantasyEvent {
  final int tournamentId;

  const FantasyEventLoadParticipants({required this.tournamentId});
}
