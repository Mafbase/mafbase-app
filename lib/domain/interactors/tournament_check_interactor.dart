import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';

class TournamentCheckInteractor extends BaseInteractor {
  final TournamentsRepository _repository;

  TournamentCheckInteractor(this._repository);

  @override
  String get interactorName => 'TournamentCheckInteractor.run()';

  Future<bool> call({
    required int tournamentId,
  }) {
    return _repository.isOwner(tournamentId);
  }
}
