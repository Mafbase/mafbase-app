import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';

class GetSettingsInteractor extends BaseInteractor {
  final TournamentEditRepository _tournamentEditRepository;

  GetSettingsInteractor(this._tournamentEditRepository);

  @override
  String get interactorName => 'GetSettingsInteractor.run()';

  Future<TournamentSettingsModel> run({required int tournamentId}) => wrap(
        () => _tournamentEditRepository.getSettings(tournamentId: tournamentId),
      );
}
