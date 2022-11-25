import 'dart:typed_data';

import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

class PlayersRepositoryMock implements PlayersRepository {
  var _fakePlayers = const [
    PlayerModel(id: 1, nickname: "Strelas"),
    PlayerModel(id: 2, nickname: "Sam"),
  ];

  late var _tournamentPlayers = _fakePlayers.take(1).toList();

  @override
  Future addPlayer(int tournamentId, PlayerModel player) async {
    if (_fakePlayers.any((element) => element.id == player.id)) {
      _fakePlayers.add(player);
    }
    _tournamentPlayers.add(player);
  }

  @override
  Future deletePlayer(int tournamentId, PlayerModel player) async {
    _tournamentPlayers =
        _tournamentPlayers.where((element) => element.id != player.id).toList();
  }

  @override
  Future<List<PlayerModel>> get players async => _fakePlayers;

  @override
  Future<List<PlayerModel>> tournamentsPlayer(int tournamentId) async {
    return _tournamentPlayers;
  }

  @override
  Future addPhoto(int playerId, Uint8List bytes, String nickname) async {}
}
