import 'package:flutter/src/material/date.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';

class TournamentsRepositoryMock implements TournamentsRepository {
  static final fakeTournaments = [
    TournamentModel(
      id: 1,
      name: "Хрустальная маска 2021",
      status: TournamentStatus.ended,
      dateStart: DateTime(2021, 9, 24),
      dateEnd: DateTime(2021, 9, 25),
      gamesCount: 10,
      billedPlayers: 10,
      billedTranslation: false,
    ),
    TournamentModel(
      id: 2,
      name: "Хрусталься маска 2022",
      status: TournamentStatus.active,
      dateStart: DateTime(2022, 9, 24),
      dateEnd: DateTime(2022, 9, 25),
      gamesCount: 16,
      billedPlayers: 70,
      billedTranslation: true,
    ),
  ];

  @override
  Future<List<TournamentModel>> getTournaments() async {
    return Future.microtask(() => fakeTournaments);
  }

  @override
  Future<int> createTournament({
    required String name,
    required DateTimeRange range,
  }) {
    return Future.value(1);
  }

  @override
  Future createSeating({required int id}) {
    return Future.value();
  }

  @override
  Future<TournamentModel> getTournament({required int tournamentId}) async {
    return fakeTournaments.firstWhere((element) => element.id == tournamentId);
  }

  @override
  Future<List<TournamentModel>> getMyTournaments() {
    return Future.microtask(() => fakeTournaments);
  }
}
