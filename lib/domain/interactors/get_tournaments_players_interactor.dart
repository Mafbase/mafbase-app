import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

class GetTournamentsPlayersInteractor extends BaseInteractor {
  final PlayersRepository _repository;

  GetTournamentsPlayersInteractor(this._repository);

  @override
  String get interactorName => "GetTournamentsPlayersInteractor";

  Future<List<PlayerModel>> run({required int tournamentId}) =>
      wrap(() => _repository.tournamentsPlayer(tournamentId));
}
