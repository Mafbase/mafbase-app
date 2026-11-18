import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/shared/club/domain/models/rating_model.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournament_result_repository.dart';

class GetTournamentRatingInteractor extends BaseInteractor {
  final TournamentResultRepository _repository;

  GetTournamentRatingInteractor(this._repository);

  Future<RatingModel> call({required int tournamentId}) => wrap(
        () => _repository.getRatingEvent(tournamentId: tournamentId),
      );

  @override
  String get interactorName => 'GetTournamentRatingInteractor';
}
