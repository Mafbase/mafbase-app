import 'package:seating_generator_web/domain/models/game_stream_admin_model.dart';
import 'package:seating_generator_web/domain/models/game_stream_model.dart';

abstract class StreamRepository {
  Future<List<GameStreamModel>> getStreams({required int tournamentId});

  Future<List<GameStreamAdminModel>> getStreamsAdmin({required int tournamentId});

  Future<GameStreamAdminModel> setStream({
    required int tournamentId,
    required int tableNumber,
    String? viewerUrl,
    String? rtmpServerUrl,
    String? rtmpKey,
  });

  Future<GameStreamAdminModel> generateStream({
    required int tournamentId,
    required int tableNumber,
  });

  Future<void> stopStream({
    required int tournamentId,
    required int streamId,
  });
}
