import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/requests/change_club_seating_content_request.dart';
import 'package:seating_generator_web/data/requests/club_translation_key_request.dart';
import 'package:seating_generator_web/domain/repositories/club_translation_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ClubTranslationRepositoryImpl extends BaseRepository implements ClubTranslationRepository {
  ClubTranslationRepositoryImpl(super.client);

  @override
  Future<void> changeRole({
    required int playerIndex,
    required PlayerRole role,
    required int clubId,
    required int table,
    required String key,
  }) {
    return ChangeClubSeatingContentRequest(
      clubId: clubId,
      table: table,
      key: key,
      content: ChangeClubSeatingContent(player: playerIndex, role: role),
    ).execute(client);
  }

  @override
  Future<void> changeStatus({
    required int playerIndex,
    required PlayerStatus status,
    required int clubId,
    required int table,
    required String key,
  }) {
    return ChangeClubSeatingContentRequest(
      clubId: clubId,
      table: table,
      key: key,
      content: ChangeClubSeatingContent(player: playerIndex, status: status),
    ).execute(client);
  }

  @override
  Future<void> changeBroadcastPhase({
    required BroadcastPhase phase,
    required int clubId,
    required int table,
    required String key,
  }) {
    return ChangeClubSeatingContentRequest(
      clubId: clubId,
      table: table,
      key: key,
      content: ChangeClubSeatingContent(broadcastPhase: phase),
    ).execute(client);
  }

  @override
  Future<void> changePlayer({
    required int playerIndex,
    required int playerId,
    required int clubId,
    required int table,
    required String key,
  }) {
    return ChangeClubSeatingContentRequest(
      clubId: clubId,
      table: table,
      key: key,
      content: ChangeClubSeatingContent(player: playerIndex, playerId: playerId),
    ).execute(client);
  }

  @override
  Future<String> getKey({required int clubId}) =>
      ClubTranslationKeyRequest(clubId: clubId).execute(client).then((event) => event.key);
}
