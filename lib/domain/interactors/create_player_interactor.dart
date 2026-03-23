import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

class CreatePlayerInteractor extends BaseInteractor {
  final PlayersRepository _repository;

  CreatePlayerInteractor(this._repository);

  @override
  String get interactorName => 'CreatePlayerInteractor';

  Future<int> run({required PlayerModel playerModel}) {
    return wrap(() {
      return _repository.createPlayer(playerModel);
    });
  }
}
