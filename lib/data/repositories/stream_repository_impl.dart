import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/domain/models/game_stream_admin_model.dart';
import 'package:seating_generator_web/domain/models/game_stream_model.dart';
import 'package:seating_generator_web/domain/repositories/stream_repository.dart';

class StreamRepositoryImpl extends BaseRepository implements StreamRepository {
  StreamRepositoryImpl(super.client);

  @override
  Future<List<GameStreamModel>> getStreams({required int tournamentId}) async {
    final json = await client.getJson('/api/tournament/$tournamentId/streams');
    final list = json['streams'] as List<dynamic>;
    return list.map((e) => GameStreamModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<GameStreamAdminModel>> getStreamsAdmin({required int tournamentId}) async {
    final json = await client.getJson('/api/admin/tournament/$tournamentId/streams');
    final list = json['streams'] as List<dynamic>;
    return list.map((e) => GameStreamAdminModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<GameStreamAdminModel> setStream({
    required int tournamentId,
    required int tableNumber,
    String? viewerUrl,
    String? rtmpServerUrl,
    String? rtmpKey,
  }) async {
    final body = <String, dynamic>{
      'tableNumber': tableNumber,
      if (viewerUrl != null) 'viewerUrl': viewerUrl,
      if (rtmpServerUrl != null) 'rtmpServerUrl': rtmpServerUrl,
      if (rtmpKey != null) 'rtmpKey': rtmpKey,
    };
    final json = await client.putJson('/api/admin/tournament/$tournamentId/streams', body);
    return GameStreamAdminModel.fromJson(json);
  }

  @override
  Future<GameStreamAdminModel> generateStream({
    required int tournamentId,
    required int tableNumber,
  }) async {
    final json = await client.postJson(
      '/api/admin/tournament/$tournamentId/streams/generate',
      {'tableNumber': tableNumber},
    );
    return GameStreamAdminModel.fromJson(json);
  }

  @override
  Future<void> stopStream({
    required int tournamentId,
    required int streamId,
  }) async {
    await client.deleteJson('/api/admin/tournament/$tournamentId/streams/$streamId');
  }
}
