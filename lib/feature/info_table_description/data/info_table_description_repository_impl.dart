import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/feature/info_table_description/data/requests/get_table_description_request.dart';
import 'package:seating_generator_web/feature/info_table_description/data/requests/set_table_description_request.dart';
import 'package:seating_generator_web/feature/info_table_description/domain/info_table_description_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class InfoTableDescriptionRepositoryImpl extends BaseRepository implements InfoTableDescriptionRepository {
  InfoTableDescriptionRepositoryImpl(super.client);

  @override
  Future<InfoTableDescription> getDescriptions(String tournamentId) =>
      GetTableDescriptionRequest(tournamentId: tournamentId)
          .execute(client)
          .then((value) => value.items.map((e) => MapEntry(e.table, e.info)).toList());

  @override
  Future<void> setDescriptions({
    required String tournamentId,
    required InfoTableDescription description,
  }) =>
      SetTableDescriptionRequest(
        tournamentId: tournamentId,
        body: TableInfoEvent(
          items: description.map(
            (e) => TableInfoItem(table: e.key, info: e.value),
          ),
        ),
      ).execute(client);
}
