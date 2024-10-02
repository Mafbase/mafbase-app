import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournament_status_widget.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentItemRow extends StatelessWidget {
  final TournamentModel tournamentModel;

  const TournamentItemRow({super.key, required this.tournamentModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onTap: () {
        context.read<MainBloc>().add(
              MainEvent.tournamentSelected(
                tournamentId: tournamentModel.id,
              ),
            );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: context.theme.greyColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    tournamentModel.name,
                    style: context.theme.headerTextStyle.copyWith(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'ID: ${tournamentModel.id}',
                  style: MyTheme.of(context).hintTextStyle,
                ),
              ],
            ),
            const SizedBox(height: 24),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      DateFormat('dd.MM.yyyy').format(tournamentModel.dateStart),
                      style: context.theme.defaultTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TournamentStatusWidget(status: tournamentModel.status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
