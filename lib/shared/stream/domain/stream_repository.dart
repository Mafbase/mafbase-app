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

  /// Перевыпустить токен оператора трансляции турнира (инвалидирует старую ссылку).
  Future<GameStreamAdmin> rotateStreamToken({
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

  /// Публичный список активных трансляций клуба (без RTMP-секретов).
  Future<List<GameStream>> getClubStreams({required int clubId});

  /// Список трансляций клуба для владельца/админа (со столами, RTMP-данными, токенами).
  Future<List<GameStreamAdmin>> getClubStreamsAdmin({required int clubId});

  /// Добавить/обновить трансляцию стола клуба.
  Future<GameStreamAdmin> setClubStream({
    required int clubId,
    required int tableNumber,
    String? viewerUrl,
    String? rtmpServerUrl,
    String? rtmpKey,
  });

  /// Остановить и удалить трансляцию клуба.
  Future<void> stopClubStream({
    required int clubId,
    required int streamId,
  });

  /// Перевыпустить токен оператора трансляции клуба (инвалидирует старую ссылку).
  Future<GameStreamAdmin> rotateClubStreamToken({
    required int clubId,
    required int streamId,
  });

  /// Текущие overlay-настройки трансляций клуба (заглушки на перерыве/брендирование).
  Future<StreamSettingsOut> getClubStreamSettings({required int clubId});

  /// Установить overlay-настройки трансляций клуба.
  Future<StreamSettingsOut> setClubStreamSettings({
    required int clubId,
    String? breakPlaceholderImageUrl,
    String? brandImageUrl,
  });
}
