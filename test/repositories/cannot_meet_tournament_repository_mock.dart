import 'package:seating_generator_web/domain/models/player_model.dart';

import 'package:seating_generator_web/domain/repositories/cannot_meet_tournament_repository.dart';

class CannotMeetTournamentRepositoryMock
    implements CannotMeetTournamentRepository {
  var _fakePairs = [
    [
      const PlayerModel(id: 1, nickname: "Strelas"),
      const PlayerModel(id: 2, nickname: "Sam"),
    ]
  ];

  @override
  Future deletePair(int tournamentId,PlayerModel first, PlayerModel second) async {
    _fakePairs = _fakePairs
        .where(
          (element) => element.first == first && element.last == second,
        )
        .toList();
  }

  @override
  Future insertPair(int tournamentId, PlayerModel first, PlayerModel second) async {
    _fakePairs.add([first, second]);
  }

  @override
  Future<List<List<PlayerModel>>> pairs(int tournamentId) async => _fakePairs;
}
