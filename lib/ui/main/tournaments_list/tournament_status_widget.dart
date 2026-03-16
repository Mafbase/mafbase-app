import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentStatusWidget extends StatelessWidget {
  final TournamentStatus status;

  const TournamentStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: _backgroundColor(status, theme),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        _text(status, context),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _textColor(status, theme),
        ),
      ),
    );
  }

  String _text(TournamentStatus status, BuildContext context) {
    switch (status) {
      case TournamentStatus.active:
        return context.locale.tournamentStatusActive;
      case TournamentStatus.waitForBilling:
        return context.locale.tournamentStatusWaitForBilling;
      case TournamentStatus.ended:
        return context.locale.tournamentStatusEnded;
    }
  }

  Color _backgroundColor(TournamentStatus status, MyTheme theme) {
    switch (status) {
      case TournamentStatus.active:
        return const Color(0xFF66CCA7).withValues(alpha: 0.15);
      case TournamentStatus.waitForBilling:
        return const Color(0xFFFFE600).withValues(alpha: 0.15);
      case TournamentStatus.ended:
        return theme.greyColor.withValues(alpha: 0.15);
    }
  }

  Color _textColor(TournamentStatus status, MyTheme theme) {
    switch (status) {
      case TournamentStatus.active:
        return const Color(0xFF3D9E76);
      case TournamentStatus.waitForBilling:
        return const Color(0xFFC4A600);
      case TournamentStatus.ended:
        return const Color(0xFF8E9199);
    }
  }
}
