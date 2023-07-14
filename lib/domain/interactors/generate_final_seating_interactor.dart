import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';

class GenerateFinalSeatingInteractor extends BaseInteractor {
  final TournamentEditRepository _tournamentEditRepository;

  GenerateFinalSeatingInteractor(this._tournamentEditRepository);

  Future call({required int tournamentId}) => wrap(
        () => _tournamentEditRepository.generateFinalGames(
          tournamentId: tournamentId,
        ),
      );

  @override
  String get interactorName => "GenerateFinalSeatingInteractor";
}
