import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/ci_scheme_model.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';

class GetCiSchemesInteractor extends BaseInteractor {
  final TournamentEditRepository _tournamentEditRepository;

  GetCiSchemesInteractor(this._tournamentEditRepository);

  Future<List<CiSchemeModel>> run() {
    return wrap(() => _tournamentEditRepository.getCiSchemeModels());
  }

  @override
  String get interactorName => "GetCiSchemesInteractor";
}
