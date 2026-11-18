import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournaments_repository.dart';

class CreateSeatingInteractor extends BaseInteractor {
  final TournamentsRepository _tournamentsRepository;

  CreateSeatingInteractor(this._tournamentsRepository);

  Future run({required int tournamentId}) {
    return wrap(() => _tournamentsRepository.createSeating(id: tournamentId));
  }

  @override
  String get interactorName => 'CreateSeatingInteractor';
}
