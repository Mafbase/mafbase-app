import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/player/domain/models/player_model.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournament_edit_repository.dart';

class GetFinalPlayersInteractor extends BaseInteractor {
  final TournamentEditRepository _repository;

  GetFinalPlayersInteractor(this._repository);

  Future<List<PlayerModel>> call({required int tournamentId}) => wrap(
        () => _repository.getFinalPlayers(tournamentId: tournamentId),
      );

  @override
  String get interactorName => 'GetFinalPlayersInteractor';
}
