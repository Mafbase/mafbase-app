import 'package:seating_generator_web/domain/models/player_model.dart';

class RefereeAssignmentModel {
  final int table;
  final PlayerModel referee;

  const RefereeAssignmentModel({
    required this.table,
    required this.referee,
  });
}
