import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

class AddTournamentPlayerInteractor extends BaseInteractor {
  final PlayersRepository _repository;

  AddTournamentPlayerInteractor(this._repository);

  @override
  String get interactorName => "AddPlayerInteractor";

  Future run({
    required int tournamentId,
    required PlayerModel playerModel,
  }) =>
      wrap(() => _repository.addPlayer(tournamentId, playerModel));
}
