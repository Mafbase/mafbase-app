import 'package:seating_generator_web/domain/models/tournament_model.dart';

abstract class TournamentsRepository {
  Future<List<TournamentModel>> getTournaments();
}