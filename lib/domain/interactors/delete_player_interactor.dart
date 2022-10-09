import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

class DeletePlayerInteractor extends BaseInteractor {
  final PlayersRepository _repository;

  DeletePlayerInteractor(this._repository);

  @override
  String get interactorName => "DeletePlayerInteractor";

  Future run({
    required int tournamentId,
    required PlayerModel playerModel,
  }) {
    return wrap(() => _repository.deletePlayer(tournamentId, playerModel));
  }
}
