import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournaments_repository.dart';

class CreateTournamentInteractor extends BaseInteractor {
  final TournamentsRepository _tournamentsRepository;

  CreateTournamentInteractor(this._tournamentsRepository);

  @override
  String get interactorName => 'CreateTournamentInteractor';

  Future<int> run({required String name, required DateTimeRange range}) {
    return wrap(
      () => _tournamentsRepository.createTournament(
        name: name,
        range: range,
      ),
    );
  }
}
