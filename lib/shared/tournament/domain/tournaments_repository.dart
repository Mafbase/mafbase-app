import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/shared/tournament/domain/models/tournament_model.dart';

abstract class TournamentsRepository {
  Future<List<TournamentModel>> getTournaments({
    required int limit,
    required int offset,
    String? search,
  });

  Future<int> createTournament({
    required String name,
    required DateTimeRange range,
  });

  Future createSeating({required int id});

  Future<TournamentModel> getTournament({required int tournamentId});

  Future<bool> isOwner(int tournamentId);

  Future<bool> canDelete(int tournamentId);

  Future<void> deleteTournament(int tournamentId);

  /// Id турниров, удалённых через [deleteTournament].
  Stream<int> get deletedTournamentIds;
}
