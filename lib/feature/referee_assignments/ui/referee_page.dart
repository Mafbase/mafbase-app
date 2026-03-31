import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/referee_assignments/ui/referee_bloc.dart';
import 'package:seating_generator_web/feature/referee_assignments/ui/referee_event.dart';
import 'package:seating_generator_web/feature/referee_assignments/ui/referee_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils.dart';

class RefereePage extends StatefulWidget {
  final int tournamentId;

  const RefereePage({
    super.key,
    required this.tournamentId,
  });

  @override
  State<RefereePage> createState() => _RefereePageState();

  static String createLocation({
    required int tournamentId,
    required BuildContext context,
  }) {
    return context.namedLocation(
      _routeName,
      pathParameters: {
        'id': tournamentId.toString(),
      },
    );
  }

  static const _routeName = 'tournament_referees';

  static final GoRoute tournamentRoute = GoRoute(
    path: 'referees',
    name: _routeName,
    builder: (context, state) {
      final tournamentId = int.parse(state.pathParameters['id']!);
      return BlocProvider(
        create: (context) => RefereeBloc(
          const RefereeState(),
          RepositoryFactory.of(context).refereeRepository,
        )..add(RefereeEventInit(tournamentId)),
        child: RefereePage(tournamentId: tournamentId),
      );
    },
  );
}

class _RefereePageState extends State<RefereePage> {
  final _tableController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _nicknameFocusNode = FocusNode();
  PlayerModel? _selectedReferee;

  @override
  void dispose() {
    _tableController.dispose();
    _nicknameController.dispose();
    _nicknameFocusNode.dispose();
    super.dispose();
  }

  RefereeBloc get _bloc => context.read();

  void _addReferee() {
    final tableNumber = int.tryParse(_tableController.text);
    if (tableNumber == null || _selectedReferee == null) return;

    _bloc.add(
      RefereeEventSetReferee(
        table: tableNumber,
        referee: _selectedReferee!,
      ),
    );
    _tableController.clear();
    _nicknameController.clear();
    _selectedReferee = null;
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: context.backOrGoToDefault(
            (c) => TournamentPage.createLocation(context: c, tournamentId: widget.tournamentId),
          ),
        ),
        title: Text(locale.referees),
        actions: [
          TournamentMenuAction(
            tournamentId: widget.tournamentId,
            openDrawer: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      body: BlocBuilder<RefereeBloc, RefereeState>(
        builder: (context, state) {
          if (state.loading && state.assignments.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final assignment in state.assignments)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                child: Chip(label: Text('${assignment.table}')),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  assignment.referee.nickname,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: state.loading
                                    ? null
                                    : () => _bloc.add(RefereeEventDeleteReferee(assignment.table)),
                                icon: const Icon(Icons.delete_outline_outlined),
                              ),
                            ],
                          ),
                        ),
                      if (state.assignments.isNotEmpty) const Divider(height: 24),
                      ListenableBuilder(
                        listenable: _tableController,
                        builder: (context, _) => Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: CustomTextField(
                                hint: '1',
                                label: locale.tableDescriptionsTableNumber,
                                controller: _tableController,
                                textInputType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: PlayerAutoComplete(
                                controller: _nicknameController,
                                focusNode: _nicknameFocusNode,
                                label: locale.nicknameHint,
                                onSelected: (player) {
                                  setState(() {
                                    _selectedReferee = player;
                                    _nicknameController.text = player.nickname;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: int.tryParse(_tableController.text) != null && _selectedReferee != null
                                  ? _addReferee
                                  : null,
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
