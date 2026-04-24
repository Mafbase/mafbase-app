import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/edit_seating/domain/models/editable_table_model.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/widgets/draggable_player_row.dart';

class EditSeatingTableCard extends StatelessWidget {
  final EditableTableModel table;
  final EditableTableModel originalTable;
  final int tableIndex;
  final void Function(PlayerDragData source, int targetSlot) onSwap;

  const EditSeatingTableCard({
    super.key,
    required this.table,
    required this.originalTable,
    required this.tableIndex,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final side = BorderSide(
      color: theme.textColor.withValues(alpha: .26),
      width: 1,
    );

    return Container(
      width: 280,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.textColor.withValues(alpha: .26),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              border: Border(bottom: side),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Стол ${table.table}',
                  style: theme.defaultTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (table.refereeNickname.isNotEmpty)
                  Text(
                    table.refereeNickname,
                    style: theme.hintTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          for (int i = 0; i < table.players.length; i++)
            DraggablePlayerRow(
              player: table.players[i],
              place: i + 1,
              tableIndex: tableIndex,
              slotIndex: i,
              isChanged:
                  i < originalTable.players.length && table.players[i].playerId != originalTable.players[i].playerId,
              onSwap: (source) => onSwap(source, i),
            ),
        ],
      ),
    );
  }
}
