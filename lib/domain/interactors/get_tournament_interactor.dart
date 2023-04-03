import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';

class GetTournamentInteractor extends BaseInteractor {
  final TournamentsRepository _tournamentsRepository;

  GetTournamentInteractor(this._tournamentsRepository);

  @override
  String get interactorName => "GetTournamentInteractor";

  Future<TournamentModel> call({required int tournamentId}) => wrap(
        () => _tournamentsRepository.getTournament(tournamentId: tournamentId),
      );
}
