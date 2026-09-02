import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/domain/repositories/stream_repository.dart';
import 'package:seating_generator_web/feature/streams/data/requests/generate_stream_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/get_broadcast_credentials_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/get_club_stream_settings_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/get_club_streams_admin_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/get_club_streams_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/get_streams_admin_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/get_streams_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/rotate_club_stream_token_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/set_club_stream_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/set_club_stream_settings_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/set_stream_request.dart';
import 'package:seating_generator_web/feature/streams/data/requests/stop_club_stream_request.dart';
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

  @override
  Future<BroadcastCredentialsOut> getBroadcastCredentials({
    int? tournamentId,
    int? clubId,
    required int table,
    required String key,
  }) =>
      GetBroadcastCredentialsRequest(
        tournamentId: tournamentId,
        clubId: clubId,
        table: table,
        key: key,
      ).execute(client);

  @override
  Future<List<GameStream>> getClubStreams({required int clubId}) =>
      GetClubStreamsRequest(clubId: clubId).execute(client).then((out) => out.streams);

  @override
  Future<List<GameStreamAdmin>> getClubStreamsAdmin({required int clubId}) =>
      GetClubStreamsAdminRequest(clubId: clubId).execute(client).then((out) => out.streams);

  @override
  Future<GameStreamAdmin> setClubStream({
    required int clubId,
    required int tableNumber,
    String? viewerUrl,
    String? rtmpServerUrl,
    String? rtmpKey,
  }) {
    final body = SetStreamEvent(tableNumber: tableNumber);
    if (viewerUrl != null) body.viewerUrl = viewerUrl;
    if (rtmpServerUrl != null) body.rtmpServerUrl = rtmpServerUrl;
    if (rtmpKey != null) body.rtmpKey = rtmpKey;
    return SetClubStreamRequest(clubId: clubId, body: body).execute(client);
  }

  @override
  Future<void> stopClubStream({
    required int clubId,
    required int streamId,
  }) =>
      StopClubStreamRequest(clubId: clubId, streamId: streamId).execute(client);

  @override
  Future<GameStreamAdmin> rotateClubStreamToken({
    required int clubId,
    required int streamId,
  }) =>
      RotateClubStreamTokenRequest(clubId: clubId, streamId: streamId).execute(client);

  @override
  Future<StreamSettingsOut> getClubStreamSettings({required int clubId}) =>
      GetClubStreamSettingsRequest(clubId: clubId).execute(client);

  @override
  Future<StreamSettingsOut> setClubStreamSettings({
    required int clubId,
    String? breakPlaceholderImageUrl,
    String? brandImageUrl,
  }) {
    final body = SetStreamSettingsEvent();
    if (breakPlaceholderImageUrl != null) body.breakPlaceholderImageUrl = breakPlaceholderImageUrl;
    if (brandImageUrl != null) body.brandImageUrl = brandImageUrl;
    return SetClubStreamSettingsRequest(clubId: clubId, body: body).execute(client);
  }
}
