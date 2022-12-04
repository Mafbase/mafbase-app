import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

class EditPlayerInteractor extends BaseInteractor {
  final PlayersRepository _playersRepository;

  EditPlayerInteractor(this._playersRepository);

  Future run(PlayerModel player) {
    return wrap(() => _playersRepository.editPlayer(player));
  }

  @override
  String get interactorName => "EditPlayerInteractor";
}
