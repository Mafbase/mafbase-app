import 'package:seating_generator_web/data/requests/change_seating_content_request.dart';
import 'package:seating_generator_web/data/requests/insert_seating_request.dart';
import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/requests/translation_key_request.dart';
import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class TranslationRepositoryImpl extends BaseRepository implements TranslationRepository {
  TranslationRepositoryImpl(super.client);

  @override
  Future<bool> insertSeating(List<int> bytes, int tournamentId) {
    return InsertSeatingRequest(tournamentId, bytes).execute(client);
  }

  @override
  Future changeRole({
    required int playerIndex,
    required PlayerRole role,
    required int table,
    required int tournamentId,
    required String key,
  }) {
    return ChangeSeatingContentRequest(
      tournamentId: tournamentId,
      table: table,
      content: ChangeSeatingContent(player: playerIndex, role: role),
      key: key,
    ).execute(client);
  }

  @override
  Future changeStatus({
    required int playerIndex,
    required PlayerStatus status,
    required int table,
    required int tournamentId,
    required String key,
  }) {
    return ChangeSeatingContentRequest(
      tournamentId: tournamentId,
      table: table,
      key: key,
      content: ChangeSeatingContent(player: playerIndex, status: status),
    ).execute(client);
  }

  @override
  Future selectGame({
    required int gameIndex,
    required int table,
    required int tournamentId,
    required String key,
  }) {
    return ChangeSeatingContentRequest(
      tournamentId: tournamentId,
      table: table,
      key: key,
      content: ChangeSeatingContent(selectedGame: gameIndex),
    ).execute(client);
  }

  @override
  Future<TranslationKeyModel> getKey({required int tournamentId}) =>
      TranslationKeyRequest(tournamentId: tournamentId).execute(client).then(TranslationKeyModel.fromProto);
}
