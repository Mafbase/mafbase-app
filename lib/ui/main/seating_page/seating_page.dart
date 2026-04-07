import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_effect.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/gomafia_input_dialog.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/seating_list.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/separations_section.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage()
class SeatingPage extends StatefulWidget {
  final int tournamentId;

  const SeatingPage({super.key, @PathParam('id') required this.tournamentId});

  @override
  State<SeatingPage> createState() => _SeatingPageState();
}

class _SeatingPageState extends CustomState<SeatingPage>
    with EffectListener<SeatingPageEffect, SeatingPageState, SeatingPageBloc, SeatingPage> {
  List<({VoidCallback onTap, String title})> _actions(
    TournamentPageState tournamentState,
    SeatingPageState state,
  ) {
    final locale = context.locale;
    return [
      if (tournamentState.settings.swissGames > 0)
        if (state.games.lastOrNull?.any((element) => element.gameWin != null) == true)
          (
            onTap: () => _onSwissGameCreate(state, true),
            title: locale.seatingGenerateNext,
          )
        else
          (
            onTap: () {
              ConfirmDialog.open(context, locale.seatingReplaceWarning).then((value) {
                if (value == true) _onSwissGameCreate(state, false);
              });
            },
            title: locale.seatingRegenerateCurrent,
          ),
      if (tournamentState.finalPlayers.length == 10)
        (
          onTap: () {
            ConfirmDialog.open(context, locale.seatingReplaceWarning).then((value) {
              if (value == true && mounted) {
                context.read<SeatingPageBloc>().add(const SeatingPageEvent.createFinalSeating());
              }
            });
          },
          title: locale.seatingGenerateFinal,
        ),
      (
        onTap: () {
          ConfirmDialog.open(context, locale.seatingReplaceWarning).then((value) {
            if (value == true && mounted) {
              context.read<SeatingPageBloc>().add(const SeatingPageEvent.createSeating());
            }
          });
        },
        title: locale.seatingGenerate,
      ),
      (
        onTap: () async {
          final id = await GomafiaInputDialog.show(context, tournamentState.gomafiaUrl);
          if (id == null || !mounted) return;

          final completer = Completer();
          context.read<SeatingPageBloc>().add(
                SeatingPageEvent.autoFsmSeating(id, completer: completer),
              );
          await completer.future;
          if (!mounted) return;

          context.read<TournamentPageBloc>()
            ..add(const TournamentPageEvent.pageOpened())
            ..add(const TournamentPageEvent.playersListOpened());
        },
        title: locale.seatingUploadGomafia,
      ),
      if (state.games.isNotEmpty)
        (
          onTap: () => context.router.push(EditSeatingRoute(tournamentId: widget.tournamentId)),
          title: locale.editSeatingButton,
        ),
    ];
  }

  void _onSwissGameCreate(SeatingPageState state, bool next) {
    context.read<SeatingPageBloc>().add(
          SeatingPageEvent.createSwissGame(game: state.games.length + (next ? 1 : 0)),
        );
  }

  Widget _buildDownloadMenu() {
    final locale = context.locale;
    return PopupMenuButton<int>(
      icon: const Icon(Icons.download),
      tooltip: '',
      onSelected: (value) {
        final bloc = context.read<SeatingPageBloc>();
        switch (value) {
          case 0:
            bloc.add(const SeatingPageEvent.getPlayersSeating());
          case 1:
            bloc.add(const SeatingPageEvent.getTablesSeating());
          case 2:
            bloc.add(const SeatingPageEvent.getCrossStats());
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(value: 0, child: Text(locale.seatingByPlayers)),
        PopupMenuItem(value: 1, child: Text(locale.seatingByTables)),
        PopupMenuItem(value: 2, child: Text(locale.seatingCrossStats)),
      ],
    );
  }

  Widget _buildEmptyState(bool isOrganizer) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.grid_view_rounded, size: 64, color: theme.greyColor),
          const SizedBox(height: 16),
          Text(
            locale.seatingEmptyState,
            style: theme.defaultTextStyle.copyWith(color: theme.greyColor),
          ),
          if (isOrganizer) ...[
            const SizedBox(height: 24),
            CustomButton(
              text: locale.seatingGenerate,
              expand: false,
              onTap: () {
                ConfirmDialog.open(context, locale.seatingReplaceWarning).then((value) {
                  if (value == true && mounted) {
                    context.read<SeatingPageBloc>().add(const SeatingPageEvent.createSeating());
                  }
                });
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSeparationsSection(SeatingPageState state) {
    return SeparationsSection(
      pairs: state.cannotMeet,
      onAdd: () => context.read<SeatingPageBloc>().add(const SeatingPageEvent.addPair()),
      onDelete: (index) {
        context.read<SeatingPageBloc>().add(
              SeatingPageEvent.deletePair(
                first: state.cannotMeet[index].first,
                second: state.cannotMeet[index].second,
              ),
            );
      },
    );
  }

  void _showMobileActions(TournamentPageState tournamentState, SeatingPageState state) {
    final actionsList = _actions(tournamentState, state);
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < actionsList.length; i++)
                ListTile(
                  title: Text(
                    actionsList[i].title,
                    style: actionsList[i].title == context.locale.seatingGenerate
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : null,
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    actionsList[i].onTap();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopBottomBar(TournamentPageState tournamentState, SeatingPageState state) {
    final theme = MyTheme.of(context);
    final actionsList = _actions(tournamentState, state);

    return Container(
      decoration: BoxDecoration(
        color: theme.background2,
        border: Border(
          top: BorderSide(color: theme.borderColor),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < actionsList.length; i++) ...[
                if (actionsList[i].title == context.locale.seatingGenerate)
                  CustomButton(
                    text: actionsList[i].title,
                    expand: false,
                    onTap: actionsList[i].onTap,
                  )
                else
                  TextButton(
                    onPressed: actionsList[i].onTap,
                    child: Text(actionsList[i].title),
                  ),
                if (i < actionsList.length - 1) const SizedBox(width: 8),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget? buildMobile(BuildContext context) {
    return BlocBuilder<TournamentPageBloc, TournamentPageState>(
      builder: (context, tournamentState) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: context.backOrGoToDefault(),
          ),
          title: Text(
            tournamentState.isMyTournament ? context.locale.separateTitle : context.locale.seating,
          ),
          actions: [
            _buildDownloadMenu(),
            TournamentMenuAction(
              tournamentId: widget.tournamentId,
              openDrawer: () => Scaffold.of(context).openEndDrawer(),
            ),
          ],
        ),
        floatingActionButton: tournamentState.isMyTournament
            ? BlocBuilder<SeatingPageBloc, SeatingPageState>(
                builder: (context, state) => FloatingActionButton.extended(
                  onPressed: () => _showMobileActions(tournamentState, state),
                  icon: const Icon(Icons.tune),
                  label: Text(context.locale.seatingActions),
                ),
              )
            : null,
        body: BlocBuilder<SeatingPageBloc, SeatingPageState>(
          builder: (context, state) => Stack(
            children: [
              Column(
                children: [
                  if (tournamentState.isMyTournament) _buildSeparationsSection(state),
                  Expanded(
                    child: state.games.isEmpty
                        ? _buildEmptyState(tournamentState.isMyTournament)
                        : SeatingList(models: state.games),
                  ),
                ],
              ),
              if (state.isLoading) const Positioned.fill(child: LoadingOverlayWidget()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return BlocBuilder<TournamentPageBloc, TournamentPageState>(
      builder: (context, tournamentState) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: context.backOrGoToDefault(),
          ),
          title: Text(
            tournamentState.isMyTournament ? context.locale.separateTitle : context.locale.seating,
          ),
          actions: [
            _buildDownloadMenu(),
            TournamentMenuAction(
              tournamentId: widget.tournamentId,
              openDrawer: () => Scaffold.of(context).openEndDrawer(),
            ),
          ],
        ),
        body: BlocBuilder<SeatingPageBloc, SeatingPageState>(
          builder: (context, state) => Stack(
            children: [
              Column(
                children: [
                  if (tournamentState.isMyTournament) _buildSeparationsSection(state),
                  Expanded(
                    child: state.games.isEmpty
                        ? _buildEmptyState(tournamentState.isMyTournament)
                        : SeatingList(models: state.games),
                  ),
                  if (tournamentState.isMyTournament) _buildDesktopBottomBar(tournamentState, state),
                ],
              ),
              if (state.isLoading) const Positioned.fill(child: LoadingOverlayWidget()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {
    on<SeatingPageEffectFixPlayers>(_fixPlayersEffect);
  }

  Future<void> _fixPlayersEffect(SeatingPageEffectFixPlayers effect) async {
    final success = await SeatingPageDialog.show(
          context: context,
          players: effect.players,
        ) ??
        false;

    if (!mounted || !success) return;

    final completer = Completer();
    context.read<SeatingPageBloc>().add(
          SeatingPageEvent.autoFsmSeating(effect.gomafiaId, completer: completer),
        );

    await completer.future;
    if (!mounted) return;

    context.read<TournamentPageBloc>()
      ..add(const TournamentPageEvent.pageOpened())
      ..add(const TournamentPageEvent.playersListOpened());
  }
}
