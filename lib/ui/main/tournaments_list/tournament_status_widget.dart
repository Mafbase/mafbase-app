import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentStatusWidget extends StatelessWidget {
  final TournamentStatus status;

  const TournamentStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            color: getColor(
              status,
              context,
            ),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          getText(
            status,
            context,
          ),
          style: context.theme.defaultTextStyle,
        ),
      ],
    );
  }

  String getText(TournamentStatus status, BuildContext context) {
    switch (status) {
      case TournamentStatus.active:
        return context.locale.tournamentStatusActive;
      case TournamentStatus.waitForBilling:
        return context.locale.tournamentStatusWaitForBilling;
      case TournamentStatus.ended:
        return context.locale.tournamentStatusEnded;
    }
  }

  Color getColor(TournamentStatus status, BuildContext context) {
    switch (status) {
      case TournamentStatus.active:
        return const Color(0xFF66CCA7);
      case TournamentStatus.waitForBilling:
        return const Color(0xFFFFE600);
      case TournamentStatus.ended:
        return const Color(0xFFDE5462);
    }
  }
}
