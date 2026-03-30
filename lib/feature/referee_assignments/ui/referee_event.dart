import 'package:seating_generator_web/domain/models/player_model.dart';

sealed class RefereeEvent {}

class RefereeEventInit implements RefereeEvent {
  final int tournamentId;

  const RefereeEventInit(this.tournamentId);
}

class RefereeEventSetReferee implements RefereeEvent {
  final int table;
  final PlayerModel referee;

  const RefereeEventSetReferee({required this.table, required this.referee});
}

class RefereeEventDeleteReferee implements RefereeEvent {
  final int table;

  const RefereeEventDeleteReferee(this.table);
}
