import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';

class UpdateSettingsInteractor extends BaseInteractor {
  final TournamentEditRepository _tournamentEditRepository;

  UpdateSettingsInteractor(this._tournamentEditRepository);

  @override
  String get interactorName => "UpdateSettingsInteractor.run()";

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
