import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/info_repository.dart';

class StartGameInfoInteractor extends BaseInteractor {
  final InfoRepository _repository;

  StartGameInfoInteractor(this._repository);

  @override
  String get interactorName => "StartGameInfoInteractor.run()";

  Future call({
    required int tournamentId,
    required int game,
  }) =>
      wrap(
        () => _repository.startGameInfo(
          tournamentId: tournamentId,
          game: game,
        ),
      );
}
