import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class InsertSeatingInteractor {
  final TranslationRepository _repository;

  const InsertSeatingInteractor(this._repository);

  Future<bool> run(List<int> bytes, int tournamentId) async {
    final transaction = Sentry.startTransaction('InsertSeatingInteractor.run()', 'task');

    try {
      return await _repository.insertSeating(bytes, tournamentId);
    } catch (err) {
      transaction.throwable = err;
      transaction.status = const SpanStatus.internalError();
      rethrow;
    } finally {
      transaction.finish();
    }
  }
}