import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';

class GetTournamentsInteractor extends BaseInteractor {
  final TournamentsRepository _tournamentsRepository;

  GetTournamentsInteractor(this._tournamentsRepository);

  Future<List<TournamentModel>> call({
    required int limit,
    required int offset,
    String? search,
  }) {
    return wrap(
      () => _tournamentsRepository.getTournaments(
        limit: limit,
        offset: offset,
        search: search,
      ),
    );
  }

  @override
  String get interactorName => 'GetTournamentsInteractor';
}
