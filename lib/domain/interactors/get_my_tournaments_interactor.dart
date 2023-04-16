import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';

class GetMyTournamentsInteractor extends BaseInteractor {
  final TournamentsRepository _tournamentsRepository;

  GetMyTournamentsInteractor(this._tournamentsRepository);

  Future<List<TournamentModel>> call() {
    return wrap(() => _tournamentsRepository.getMyTournaments());
  }

  @override
  String get interactorName => "GetMyTournamentsInteractor";
}
