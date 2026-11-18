import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/player/domain/models/player_model.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournament_edit_repository.dart';
import 'package:seating_generator_web/utils.dart';

class GetSeparationInteractor extends BaseInteractor {
  final TournamentEditRepository _tournamentEditRepository;

  GetSeparationInteractor(this._tournamentEditRepository);

  Future<List<Pair<PlayerModel, PlayerModel>>> run({
    required int tournamentId,
  }) {
    return wrap(
      () => _tournamentEditRepository.getSeparations(
        tournamentId: tournamentId,
      ),
    );
  }

  @override
  String get interactorName => 'GetSeparationInteractor';
}
