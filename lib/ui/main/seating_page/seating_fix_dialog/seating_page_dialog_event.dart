import 'package:seating_generator_web/domain/models/player_model.dart';

sealed class SeatingPageDialogEvent {
  const factory SeatingPageDialogEvent.newPlayer(String nickname) = SeatingPageDialogEventNewPlayer;

  const factory SeatingPageDialogEvent.existingPlayer(PlayerModel player) = SeatingPageDialogEventExistingPlayer;

  const factory SeatingPageDialogEvent.init() = SeatingPageDialogEventInit;
}

class SeatingPageDialogEventInit implements SeatingPageDialogEvent {
  const SeatingPageDialogEventInit();
}

class SeatingPageDialogEventNewPlayer implements SeatingPageDialogEvent {
  final String nickname;

  const SeatingPageDialogEventNewPlayer(this.nickname);
}

class SeatingPageDialogEventExistingPlayer implements SeatingPageDialogEvent {
  final PlayerModel player;

  const SeatingPageDialogEventExistingPlayer(this.player);
}
