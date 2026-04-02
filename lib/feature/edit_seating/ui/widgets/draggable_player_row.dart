import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/edit_seating/domain/models/editable_table_model.dart';

class PlayerDragData {
  final int tableIndex;
  final int slotIndex;

  const PlayerDragData({
    required this.tableIndex,
    required this.slotIndex,
  });
}

class DraggablePlayerRow extends StatelessWidget {
  final EditablePlayerSlot player;
  final int place;
  final int tableIndex;
  final int slotIndex;
  final bool isChanged;
  final void Function(PlayerDragData source) onSwap;

  const DraggablePlayerRow({
    super.key,
    required this.player,
    required this.place,
    required this.tableIndex,
    required this.slotIndex,
    required this.isChanged,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final side = BorderSide(
      color: theme.textColor.withValues(alpha: .26),
      width: 1,
    );

    final dragData = PlayerDragData(
      tableIndex: tableIndex,
      slotIndex: slotIndex,
    );

    return DragTarget<PlayerDragData>(
      onWillAcceptWithDetails: (details) {
        final data = details.data;
        return data.tableIndex != tableIndex || data.slotIndex != slotIndex;
      },
      onAcceptWithDetails: (details) => onSwap(details.data),
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;

        return Draggable<PlayerDragData>(
          data: dragData,
          feedback: Material(
            elevation: 4,
            child: Container(
              width: 250,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: theme.background2,
              child: Text(
                player.nickname,
                style: theme.defaultTextStyle,
              ),
            ),
          ),
          childWhenDragging: Container(
            decoration: BoxDecoration(
              border: Border(top: side),
              color: theme.hintColor.withValues(alpha: .1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                SizedBox(width: 24, child: Text('$place', style: theme.hintTextStyle)),
                Text(player.nickname, style: theme.hintTextStyle),
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border(top: side),
              color: isHovered
                  ? theme.dragTargetHoverColor
                  : isChanged
                      ? theme.changedPlayerColor
                      : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                SizedBox(width: 24, child: Text('$place', style: theme.defaultTextStyle)),
                Expanded(
                  child: Text(
                    player.nickname,
                    style: theme.defaultTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
