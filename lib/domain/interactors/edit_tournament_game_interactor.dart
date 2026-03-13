import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/tournament_result_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class EditTournamentGameInteractor extends BaseInteractor {
  final TournamentResultRepository _repository;

  EditTournamentGameInteractor(this._repository);

  Future call({
    required int tournamentId,
    required int gameId,
    required ClubGameResult result,
  }) =>
      wrap(
        () => _repository.editGame(
          tournamentId: tournamentId,
          gameId: gameId,
          result: result,
        ),
      );

  @override
  String get interactorName => 'EditTournamentGameInteractor';
}
