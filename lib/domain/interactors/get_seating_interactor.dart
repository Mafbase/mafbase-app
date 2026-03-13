import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';

class GetSeatingInteractor extends BaseInteractor {
  final TournamentEditRepository _repository;

  GetSeatingInteractor(this._repository);

  @override
  String get interactorName => 'GetSeatingInteractor';

  Future<List<List<GameResultModel>>> run({required int tournamentId}) =>
      wrap(() => _repository.getResultModels(tournamentId: tournamentId));
}
