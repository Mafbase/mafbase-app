import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/tournament_result_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetTournamentGameInteractor extends BaseInteractor {
  final TournamentResultRepository _repository;

  GetTournamentGameInteractor(this._repository);

  Future<ClubGameResult> call({
    required int tournamentId,
    required int gameId,
  }) =>
      wrap(
        () => _repository.getGame(
          tournamentId: tournamentId,
          gameId: gameId,
        ),
      );

  @override
  String get interactorName => "GetTournamentGameInteractor";
}
