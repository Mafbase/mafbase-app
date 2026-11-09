import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_result.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_sheet.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/utils/browser_url.dart';

/// Один раз показывает мастер настройки только что созданного турнира — когда стало известно, что турнир свой.
class OrganizerSetupLauncher extends StatefulWidget {
  final int tournamentId;
  final bool enabled;
  final Widget child;

  const OrganizerSetupLauncher({
    super.key,
    required this.tournamentId,
    required this.enabled,
    required this.child,
  });

  @override
  State<OrganizerSetupLauncher> createState() => _OrganizerSetupLauncherState();
}

class _OrganizerSetupLauncherState extends State<OrganizerSetupLauncher> {
  StreamSubscription<TournamentPageState>? _subscription;

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showWhenOwnTournament());
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _showWhenOwnTournament() {
    if (!mounted) return;
    final tournamentBloc = context.read<TournamentPageBloc>();

    if (tournamentBloc.state.isMyTournament) {
      _show();
    } else {
      _subscription = tournamentBloc.stream.where((state) => state.isMyTournament).take(1).listen((_) => _show());
    }
  }

  Future<void> _show() async {
    if (!mounted) return;
    final shown = OrganizerSetupSheet.show(context, tournamentId: widget.tournamentId);
    removeQueryParameterFromBrowserUrl(context, 'setup');

    final result = await shown;
    if (result == null || !mounted) return;

    final router = context.router;
    switch (result) {
      case OrganizerSetupResult.importFromGomafia:
        router.push(SeatingRoute(tournamentId: widget.tournamentId, gomafia: 1));
      case OrganizerSetupResult.openChecklist:
        router.push(OrganizerChecklistRoute(tournamentId: widget.tournamentId));
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
