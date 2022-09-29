import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/data/requests/get_tournaments_request.dart';
import 'package:seating_generator_web/domain/base_repository.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';

class TournamentsRepositoryImpl extends BaseRepository
    implements TournamentsRepository {
  TournamentsRepositoryImpl(super.client);

  @override
  Future<List<TournamentModel>> getTournaments() {
    return GetTournamentsRequest().execute(client).then((value) {
      return value.tournaments.map((tournament) {
        return TournamentModel(
          id: tournament.id,
          name: tournament.name,
          status: TournamentStatus.from(tournament.status),
          dateStart: DateFormat("dd-MM-yyyy").parse(tournament.dateStart),
          dateEnd: DateFormat("dd-MM-yyyy").parse(tournament.dateEnd),
          gamesCount: tournament.gamesCount,
        );
      }).toList();
    });
  }
}
