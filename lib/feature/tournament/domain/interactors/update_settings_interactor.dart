import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/tournament/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournament_edit_repository.dart';

class UpdateSettingsInteractor extends BaseInteractor {
  final TournamentEditRepository _tournamentEditRepository;

  UpdateSettingsInteractor(this._tournamentEditRepository);

  @override
  String get interactorName => 'UpdateSettingsInteractor.run()';

  Future run({
    required int tournamentId,
    required TournamentSettingsModel model,
  }) =>
      wrap(
        () {
          return _tournamentEditRepository.updateSetting(
            tournamentId: tournamentId,
            settings: model,
          );
        },
      );
}
