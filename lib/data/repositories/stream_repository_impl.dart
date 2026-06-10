import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/domain/repositories/stream_repository.dart';
import 'package:seating_generator_web/feature/streams/data/requests/generate_stream_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/get_streams_admin_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/get_streams_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/set_stream_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/stop_stream_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class StreamRepositoryImpl extends BaseRepository implements StreamRepository {
  StreamRepositoryImpl(super.client);

  @override
  Future<List<GameStream>> getStreams({required int tournamentId}) =>
      GetStreamsRequest(tournamentId: tournamentId).execute(client).then((out) => out.streams);

  @override
  Future<List<GameStreamAdmin>> getStreamsAdmin({required int tournamentId}) =>
      GetStreamsAdminRequest(tournamentId: tournamentId).execute(client).then((out) => out.streams);

  @override
  Future<GameStreamAdmin> setStream({
    required int tournamentId,
    required int tableNumber,
    String? viewerUrl,
    String? rtmpServerUrl,
    String? rtmpKey,
  }) {
    final body = SetStreamEvent(tableNumber: tableNumber);
    if (viewerUrl != null) body.viewerUrl = viewerUrl;
    if (rtmpServerUrl != null) body.rtmpServerUrl = rtmpServerUrl;
    if (rtmpKey != null) body.rtmpKey = rtmpKey;
    return SetStreamRequest(tournamentId: tournamentId, body: body).execute(client);
  }

  @override
  Future<GameStreamAdmin> generateStream({
    required int tournamentId,
    required int tableNumber,
  }) =>
      GenerateStreamRequest(
        tournamentId: tournamentId,
        body: StartVkStreamEvent(tableNumber: tableNumber),
      ).execute(client);

  @override
  Future<void> stopStream({
    required int tournamentId,
    required int streamId,
  }) =>
      StopStreamRequest(tournamentId: tournamentId, streamId: streamId).execute(client);
}
