import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/tournament/domain/models/tournament_model.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournaments_repository.dart';

class GetTournamentInteractor extends BaseInteractor {
  final TournamentsRepository _tournamentsRepository;

  GetTournamentInteractor(this._tournamentsRepository);

  @override
  String get interactorName => 'GetTournamentInteractor';

  Future<TournamentModel> call({required int tournamentId}) => wrap(
        () => _tournamentsRepository.getTournament(tournamentId: tournamentId),
      );
}
