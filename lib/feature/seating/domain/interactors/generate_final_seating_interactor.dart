import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournament_edit_repository.dart';

class GenerateFinalSeatingInteractor extends BaseInteractor {
  final TournamentEditRepository _tournamentEditRepository;

  GenerateFinalSeatingInteractor(this._tournamentEditRepository);

  Future call({required int tournamentId}) => wrap(
        () => _tournamentEditRepository.generateFinalGames(
          tournamentId: tournamentId,
        ),
      );

  @override
  String get interactorName => 'GenerateFinalSeatingInteractor';
}
