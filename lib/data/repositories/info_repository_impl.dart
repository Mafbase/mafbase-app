import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/requests/custom_text_info_request.dart';
import 'package:seating_generator_web/data/requests/start_game_info_request.dart';
import 'package:seating_generator_web/domain/repositories/info_repository.dart';

class InfoRepositoryImpl extends BaseRepository implements InfoRepository {
  InfoRepositoryImpl(super.client);

  @override
  Future customTextInfo({required int tournamentId, required String text}) {
    return CustomTextInfoRequest(tournamentId: tournamentId, text: text)
        .execute(client);
  }

  @override
  Future startGameInfo({required int tournamentId, required int game}) {
    return StartGameInfoRequest(tournamentId: tournamentId, game: game)
        .execute(client);
  }
}
