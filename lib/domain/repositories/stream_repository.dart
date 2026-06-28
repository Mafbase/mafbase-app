import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

abstract class StreamRepository {
  Future<List<GameStream>> getStreams({required int tournamentId});

  Future<List<GameStreamAdmin>> getStreamsAdmin({required int tournamentId});

  Future<GameStreamAdmin> setStream({
    required int tournamentId,
    required int tableNumber,
    String? viewerUrl,
    String? rtmpServerUrl,
    String? rtmpKey,
  });

  Future<GameStreamAdmin> generateStream({
    required int tournamentId,
    required int tableNumber,
  });

  Future<void> stopStream({
    required int tournamentId,
    required int streamId,
  });

  /// Публичный запрос креденшелов оператора по одноразовому ключу из диплинка.
  ///
  /// Передавать заполненный идентификатор контекста: либо [tournamentId], либо
  /// [clubId] (второй оставить null/0). Бросает [BroadcastCredentialsException]
  /// со статус-кодом при не-2xx ответе (403 — ключ устарел, 404 — стол без RTMP).
  Future<BroadcastCredentialsOut> getBroadcastCredentials({
    int? tournamentId,
    int? clubId,
    required int table,
    required String key,
  });
}
