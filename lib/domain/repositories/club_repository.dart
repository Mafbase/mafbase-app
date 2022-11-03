import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

abstract class ClubRepository {
  Future addGame(ClubGameResult result, int clubId);
}
