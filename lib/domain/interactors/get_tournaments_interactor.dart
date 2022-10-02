import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';

class GetTournamentsInteractor extends BaseInteractor {
  final TournamentsRepository _repository;

  GetTournamentsInteractor(this._repository);

  Future<List<TournamentModel>> run() async {
    return wrap(() async {
      return await _repository.getTournaments();
    });
  }
}