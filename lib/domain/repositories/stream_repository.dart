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
}
