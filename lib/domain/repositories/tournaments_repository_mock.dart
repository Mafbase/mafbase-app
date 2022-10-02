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
    ),
    TournamentModel(
      id: 2,
      name: "Хрусталься маска 2022",
      status: TournamentStatus.active,
      dateStart: DateTime(2022, 9, 24),
      dateEnd: DateTime(2022, 9, 25),
      gamesCount: 16,
    ),
  ];

  @override
  Future<List<TournamentModel>> getTournaments() async {
    return fakeTournaments;
  }
}
