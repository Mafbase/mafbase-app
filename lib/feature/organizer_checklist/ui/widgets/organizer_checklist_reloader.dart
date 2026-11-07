import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';

/// Загружает чеклист своего турнира и перезагружает его при смене дочернего маршрута и после изменений,
/// от которых зависят пункты.
class OrganizerChecklistReloader extends StatefulWidget {
  final int tournamentId;
  final Widget child;

  const OrganizerChecklistReloader({
    super.key,
    required this.tournamentId,
    required this.child,
  });

  @override
  State<OrganizerChecklistReloader> createState() => _OrganizerChecklistReloaderState();
}

class _OrganizerChecklistReloaderState extends State<OrganizerChecklistReloader> {
  late final StackRouter _router;
  late String _path;

  @override
  void initState() {
    super.initState();
    _router = context.router;
    _path = _router.currentPath;
    // История навигации общая для всех роутеров и сообщает о каждой смене адреса, в том числе вложенных маршрутов.
    _router.navigationHistory.addListener(_onUrlChanged);
  }

  @override
  void dispose() {
    _router.navigationHistory.removeListener(_onUrlChanged);
    super.dispose();
  }

  void _onUrlChanged() {
    final path = _router.currentPath;
    if (path == _path) return;
    _path = path;

    final tournamentPath = '/tournament/${widget.tournamentId}';
    if (path == tournamentPath || path.startsWith('$tournamentPath/')) _reload();
  }

  void _reload() {
    if (!mounted || !context.read<TournamentPageBloc>().state.isMyTournament) return;
    context.read<OrganizerChecklistBloc>().add(const OrganizerChecklistEventLoad());
  }

  static bool _tournamentChanged(TournamentPageState previous, TournamentPageState current) =>
      current.isMyTournament &&
      (!previous.isMyTournament ||
          previous.settings != current.settings ||
          previous.tournamentPlayers != current.tournamentPlayers ||
          previous.billedPlayers != current.billedPlayers ||
          previous.billedTranslation != current.billedTranslation ||
          previous.notificationEnabled != current.notificationEnabled ||
          previous.gomafiaUrl != current.gomafiaUrl);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TournamentPageBloc, TournamentPageState>(
          listenWhen: _tournamentChanged,
          listener: (_, __) => _reload(),
        ),
        BlocListener<SeatingPageBloc, SeatingPageState>(
          listenWhen: (previous, current) => previous.games != current.games,
          listener: (_, __) => _reload(),
        ),
      ],
      child: widget.child,
    );
  }
}
