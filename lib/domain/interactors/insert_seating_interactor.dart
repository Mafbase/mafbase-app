import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';

class InsertSeatingInteractor extends BaseInteractor {
  final TranslationRepository _repository;

  InsertSeatingInteractor(this._repository);

  Future<bool> run(List<int> bytes, int tournamentId) async {

    return wrap(() async {
      return await _repository.insertSeating(bytes, tournamentId);
    });
  }
}
