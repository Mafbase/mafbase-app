import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

class GetAllPlayersInteractor extends BaseInteractor {
  final PlayersRepository _repository;

  GetAllPlayersInteractor(this._repository);

  @override
  String get interactorName => 'GetAllPlayersInteractor';

  Future<List<PlayerModel>> run() {
    return wrap(() => _repository.players);
  }
}
