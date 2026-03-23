import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';

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
