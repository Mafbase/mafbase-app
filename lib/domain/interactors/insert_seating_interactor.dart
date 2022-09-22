import 'package:seating_generator_web/domain/repositories/translation_repository.dart';

class InsertSeatingInteractor {
  final TranslationRepository _repository;

  const InsertSeatingInteractor(this._repository);

  Future<bool> run(List<int> bytes, int tournamentId) {
    return _repository.insertSeating(bytes, tournamentId);
  }
}