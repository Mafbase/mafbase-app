import 'package:seating_generator_web/data/requests/add_club_game_request.dart';
import 'package:seating_generator_web/domain/base_repository.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ClubRepositoryImpl extends BaseRepository implements ClubRepository {
  ClubRepositoryImpl(super.client);

  @override
  Future addGame(ClubGameResult result, int clubId) {
    return AddClubGameRequest(clubId: clubId, result: result).execute(client);
  }
}
