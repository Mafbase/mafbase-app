import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'editable_table_model.freezed.dart';

@freezed
abstract class EditablePlayerSlot with _$EditablePlayerSlot {
  const factory EditablePlayerSlot({
    required int playerId,
    required String nickname,
  }) = _EditablePlayerSlot;

  factory EditablePlayerSlot.fromProto(Player player) => EditablePlayerSlot(
        playerId: player.id,
        nickname: player.nickname,
      );
}

@freezed
abstract class EditableTableModel with _$EditableTableModel {
  const factory EditableTableModel({
    required int gameId,
    required int game,
    required int table,
    required List<EditablePlayerSlot> players,
    required int refereeId,
    required String refereeNickname,
  }) = _EditableTableModel;

  factory EditableTableModel.fromGameResult(GameResultModel model) {
    final playerIds = model.playerIds ?? [];
    return EditableTableModel(
      gameId: model.gameId,
      game: model.game,
      table: model.table,
      players: List.generate(
        model.nicknames.length,
        (i) => EditablePlayerSlot(
          playerId: i < playerIds.length ? playerIds[i] : 0,
          nickname: model.nicknames[i],
        ),
      ),
      refereeId: model.refereeId ?? 0,
      refereeNickname: model.referee,
    );
  }

  factory EditableTableModel.fromSeatingItem(TableSeatingItem item) {
    final seating = item.seating;
    return EditableTableModel(
      gameId: item.gameId,
      game: item.game,
      table: seating.table,
      players: seating.players.map((p) => EditablePlayerSlot.fromProto(p)).toList(),
      refereeId: seating.hasRefereeModel() ? seating.refereeModel.id : 0,
      refereeNickname: seating.hasRefereeModel() ? seating.refereeModel.nickname : seating.referee,
    );
  }
}
