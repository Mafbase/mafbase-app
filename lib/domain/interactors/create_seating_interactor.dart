import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';

class CreateSeatingInteractor extends BaseInteractor {
  final TournamentsRepository _tournamentsRepository;

  CreateSeatingInteractor(this._tournamentsRepository);

  Future run({required int tournamentId}) {
    return wrap(() => _tournamentsRepository.createSeating(id: tournamentId));
  }

  @override
  String get interactorName => "CreateSeatingInteractor";
}
