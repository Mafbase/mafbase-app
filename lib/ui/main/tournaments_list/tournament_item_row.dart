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
    final theme = MyTheme.of(context);

    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
          color: theme.background2,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.cardShadowColor,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIcon(theme),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tournamentModel.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: theme.darkBlueColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            'ID: ${tournamentModel.id}',
                            style: TextStyle(
                              fontSize: 11,
                              color: theme.hintColor,
                            ),
                          ),
                          const Spacer(),
                          TournamentStatusWidget(status: tournamentModel.status),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildMetadata(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(MyTheme theme) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: _iconColor(theme),
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Icon(
        Icons.emoji_events,
        size: 18,
        color: Colors.white,
      ),
    );
  }

  Widget _buildMetadata(BuildContext context, MyTheme theme) {
    final locale = context.locale;
    final dateRange = _formatDateRange(context, tournamentModel.dateStart, tournamentModel.dateEnd);
    final metaStyle = TextStyle(fontSize: 12, color: theme.greyColor);
    final iconColor = theme.greyColor;

    return Row(
      children: [
        Icon(Icons.calendar_today, size: 12, color: iconColor),
        const SizedBox(width: 4),
        Text(dateRange, style: metaStyle),
        const SizedBox(width: 6),
        _dot(theme),
        const SizedBox(width: 6),
        Icon(Icons.sports_esports, size: 12, color: iconColor),
        const SizedBox(width: 4),
        Text(locale.tournamentCardGames(tournamentModel.gamesCount), style: metaStyle),
        const SizedBox(width: 6),
        _dot(theme),
        const SizedBox(width: 6),
        Text(locale.tournamentCardPlayers(tournamentModel.billedPlayers), style: metaStyle),
      ],
    );
  }

  Widget _dot(MyTheme theme) {
    return Container(
      width: 3,
      height: 3,
      decoration: BoxDecoration(
        color: theme.greyColor,
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }

  Color _iconColor(MyTheme theme) {
    switch (tournamentModel.status) {
      case TournamentStatus.active:
        return theme.darkBlueColor;
      case TournamentStatus.waitForBilling:
        return theme.positiveColor;
      case TournamentStatus.ended:
        return theme.darkGreyColor;
    }
  }

  String _formatDateRange(BuildContext context, DateTime start, DateTime end) {
    final fmt = DateFormat('d MMM', Localizations.localeOf(context).languageCode);
    if (start.year == end.year && start.month == end.month && start.day == end.day) {
      return fmt.format(start);
    }
    return '${fmt.format(start)} – ${fmt.format(end)}';
  }
}
