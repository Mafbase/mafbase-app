import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/player/domain/models/player_model.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournament_edit_repository.dart';

class SetFinalPlayersInteractor extends BaseInteractor {
  final TournamentEditRepository _repository;

  SetFinalPlayersInteractor(this._repository);

  Future call({
    required int tournamentId,
    required List<PlayerModel> players,
  }) =>
      wrap(
        () => _repository.setFinalPlayers(
          players: players,
          tournamentId: tournamentId,
        ),
      );

  @override
  String get interactorName => 'SetFinalPlayersInteractor.run()';
}
