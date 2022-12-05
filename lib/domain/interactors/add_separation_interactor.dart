import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';

class AddSeparationInteractor extends BaseInteractor {
  final TournamentEditRepository _tournamentEditRepository;

  AddSeparationInteractor(this._tournamentEditRepository);

  Future run({
    required PlayerModel first,
    required PlayerModel second,
    required int tournamentId,
  }) {
    return wrap(
      () => _tournamentEditRepository.insertSeparation(
        tournamentId: tournamentId,
        player1: first,
        player2: second,
      ),
    );
  }

  @override
  String get interactorName => "AddSeparationInteractor";
}
