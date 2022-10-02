import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetTournamentsInteractor {
  final TournamentsRepository _repository;

  GetTournamentsInteractor(this._repository);

  Future<List<TournamentModel>> run() async {
    final transaction = Sentry.startTransaction('GetTournamentsInteractor.run()', 'task');
    try {
      return await _repository.getTournaments();
    } catch (err) {
      transaction.throwable = err;
      transaction.status = const SpanStatus.internalError();
      rethrow;
    } finally {
      transaction.finish();
    }
  }
}