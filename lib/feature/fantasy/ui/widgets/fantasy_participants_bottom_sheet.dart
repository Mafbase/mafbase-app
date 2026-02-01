import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_bloc.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_event.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_state.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_add_participant_dialog.dart';
import 'package:seating_generator_web/utils.dart';

class FantasyParticipantsBottomSheet {
  FantasyParticipantsBottomSheet._();

  static void show(BuildContext context, int tournamentId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollController) => BlocProvider.value(
          value: context.read<FantasyBloc>(),
          child: BlocBuilder<FantasyBloc, FantasyState>(
            builder: (context, blocState) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        context.locale.fantasyParticipants,
                        style: MyTheme.of(context).headerTextStyle,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          await FantasyAddParticipantDialog.show(context, tournamentId);
                          // Обновляем список участников после добавления
                          if (context.mounted) {
                            context.read<FantasyBloc>().add(
                                  FantasyEventLoadParticipants(tournamentId: tournamentId),
                                );
                          }
                        },
                        icon: const Icon(Icons.add),
                        tooltip: context.locale.fantasyAddParticipant,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: blocState.participants.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              context.locale.fantasyNoParticipants,
                              textAlign: TextAlign.center,
                              style: MyTheme.of(context).defaultTextStyle,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: blocState.participants.length,
                          itemBuilder: (context, index) {
                            final participant = blocState.participants[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      participant.email,
                                      style: MyTheme.of(context).defaultTextStyle,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final shouldRemove = await ConfirmDialog.open(
                                        context,
                                        context.locale.fantasyRemoveParticipant(participant.email),
                                      );
                                      if (shouldRemove == true && context.mounted) {
                                        context.read<FantasyBloc>().add(
                                              FantasyEventRemoveParticipant(
                                                tournamentId: tournamentId,
                                                userId: participant.id,
                                              ),
                                            );
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: MyTheme.of(context).redColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
