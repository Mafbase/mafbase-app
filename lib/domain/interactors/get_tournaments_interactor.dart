import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';

class GetTournamentsInteractor {
  final TournamentsRepository _repository;

  GetTournamentsInteractor(this._repository);

  Future<List<TournamentModel>> run() {
    return _repository.getTournaments();
  }
}