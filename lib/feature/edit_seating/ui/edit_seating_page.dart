import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/feature/edit_seating/domain/models/editable_table_model.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/edit_seating_bloc.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/edit_seating_effect.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/edit_seating_event.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/edit_seating_state.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/widgets/auto_scroll_drag_region.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/widgets/draggable_player_row.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/widgets/edit_seating_round_selector.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/widgets/edit_seating_table_card.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/utils.dart';

class EditSeatingPage extends StatefulWidget {
  final int tournamentId;

  const EditSeatingPage({
    super.key,
    required this.tournamentId,
  });

  @override
  State<EditSeatingPage> createState() => _EditSeatingPageState();

  static String createLocation({
    required int tournamentId,
    required BuildContext context,
  }) {
    return context.namedLocation(
      _routeName,
      pathParameters: {'id': tournamentId.toString()},
    );
  }

  static const _routeName = 'tournament_edit_seating_dnd';

  static final GoRoute tournamentRoute = GoRoute(
    path: 'manual',
    name: _routeName,
    builder: (context, state) {
      final tournamentId = int.parse(state.pathParameters['id']!);
      return BlocProvider(
        create: (context) => EditSeatingBloc(
          repos: RepositoryFactory.of(context),
        ),
        child: EditSeatingPage(tournamentId: tournamentId),
      );
    },
  );
}

class _EditSeatingPageState extends State<EditSeatingPage>
    with EffectListener<EditSeatingPageEffect, EditSeatingPageState, EditSeatingBloc, EditSeatingPage> {
  final _scrollController = ScrollController();
  bool _initialized = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void registerEffectHandlers(
    void Function<T>(EffectHandler<T> handler) on,
  ) {
    on<EditSeatingPageEffectSaveSuccess>(_onSaveSuccess);
  }

  void _onSaveSuccess(EditSeatingPageEffectSaveSuccess effect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.locale.editSeatingSaveSuccess)),
    );
    context.read<SeatingPageBloc>().add(
          SeatingPageEvent.pageOpened(tournamentId: widget.tournamentId),
        );
  }

  void _initFromSeatingState(SeatingPageState seatingState) {
    if (_initialized) return;
    if (seatingState.games.isEmpty) return;

    _initialized = true;
    final seating = seatingState.games
        .map(
          (round) => round.map((g) => EditableTableModel.fromGameResult(g)).toList(),
        )
        .toList();

    context.read<EditSeatingBloc>().add(
          EditSeatingPageEvent.init(
            tournamentId: widget.tournamentId,
            seating: seating,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SeatingPageBloc, SeatingPageState>(
      listener: (context, seatingState) => _initFromSeatingState(seatingState),
      child: Builder(
        builder: (context) {
          if (!_initialized) {
            _initFromSeatingState(context.read<SeatingPageBloc>().state);
          }

          return BlocBuilder<EditSeatingBloc, EditSeatingPageState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              final hasChanges = _hasChanges(state);

              return Scaffold(
                appBar: AppBar(
                  title: Text(context.locale.editSeatingTitle),
                ),
                body: Column(
                  children: [
                    EditSeatingRoundSelector(
                      roundCount: state.editedSeating.length,
                      selectedRound: state.selectedRound,
                      onSelected: (index) {
                        context.read<EditSeatingBloc>().add(EditSeatingPageEvent.selectRound(index));
                      },
                    ),
                    Expanded(
                      child: _buildTablesGrid(context, state),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                        disabled: hasChanges && !state.isSaving,
                        onTap: () => context.read<EditSeatingBloc>().add(const EditSeatingPageEvent.save()),
                        text: context.locale.editSeatingSave,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTablesGrid(BuildContext context, EditSeatingPageState state) {
    if (state.editedSeating.isEmpty) {
      return const SizedBox.shrink();
    }

    final round = state.selectedRound;
    if (round >= state.editedSeating.length) {
      return const SizedBox.shrink();
    }

    final tables = state.editedSeating[round];
    final originalTables = state.originalSeating[round];

    return AutoScrollDragRegion(
      scrollController: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(tables.length, (tableIndex) {
            return EditSeatingTableCard(
              table: tables[tableIndex],
              originalTable: originalTables[tableIndex],
              tableIndex: tableIndex,
              onSwap: (PlayerDragData source, int targetSlot) {
                context.read<EditSeatingBloc>().add(
                      EditSeatingPageEvent.swapPlayers(
                        sourceTable: source.tableIndex,
                        sourceSlot: source.slotIndex,
                        targetTable: tableIndex,
                        targetSlot: targetSlot,
                      ),
                    );
              },
            );
          }),
        ),
      ),
    );
  }

  bool _hasChanges(EditSeatingPageState state) {
    for (int r = 0; r < state.editedSeating.length; r++) {
      for (int t = 0; t < state.editedSeating[r].length; t++) {
        final edited = state.editedSeating[r][t];
        final original = state.originalSeating[r][t];
        for (int i = 0; i < edited.players.length; i++) {
          if (edited.players[i].playerId != original.players[i].playerId) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
