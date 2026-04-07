import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/feature/info_table_description/ui/info_table_description_bloc.dart';
import 'package:seating_generator_web/feature/info_table_description/ui/info_table_description_event.dart';
import 'package:seating_generator_web/feature/info_table_description/ui/info_table_description_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils.dart';

@RoutePage()
class InfoTableDescriptionPage extends StatelessWidget {
  @PathParam('id')
  final int tournamentId;

  const InfoTableDescriptionPage({
    super.key,
    required this.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoTableDescriptionBloc(
        const InfoTableState(),
        RepositoryFactory.of(context).infoTableDescriptionRepository,
      )..add(InfoTableDescriptionEventInit(tournamentId.toString())),
      child: _InfoTableDescriptionPageContent(tournamentId: tournamentId),
    );
  }
}

class _InfoTableDescriptionPageContent extends StatefulWidget {
  final int tournamentId;

  const _InfoTableDescriptionPageContent({required this.tournamentId});

  @override
  State<_InfoTableDescriptionPageContent> createState() => _InfoTableDescriptionPageState();
}

class _InfoTableDescriptionPageState extends State<_InfoTableDescriptionPageContent> {
  final _tableController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _controllers = <int, TextEditingController>{};

  @override
  void dispose() {
    _tableController.dispose();
    _descriptionController.dispose();
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  InfoTableDescriptionBloc get _bloc => context.read();

  TextEditingController _getControllerFor({
    required int table,
    String? defaultText,
  }) {
    if (_controllers[table] == null) {
      _controllers[table] = TextEditingController(text: defaultText);
    }
    return _controllers[table]!;
  }

  bool _areAllDescriptionsFilled(List<MapEntry<int, String>> descriptions) {
    return descriptions.every((entry) => entry.value.isNotEmpty);
  }

  void _addTable() {
    final tableNumber = int.tryParse(_tableController.text);
    if (tableNumber == null) return;

    _bloc.add(
      InfoTableDescriptionEventAddWithDescription(
        table: tableNumber,
        description: _descriptionController.text,
      ),
    );
    _tableController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: context.backOrGoToDefault(
            (c) => '/tournament/${widget.tournamentId}',
          ),
        ),
        title: Text(locale.tableDescriptionsTitle),
        actions: [
          TournamentMenuAction(
            tournamentId: widget.tournamentId,
            openDrawer: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      body: BlocBuilder<InfoTableDescriptionBloc, InfoTableState>(
        builder: (context, state) {
          if (state.loading) {
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
                      for (final entry in state.tableDescriptions)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                child: Chip(label: Text('${entry.key}')),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: CustomTextField(
                                  controller: _getControllerFor(
                                    table: entry.key,
                                    defaultText: entry.value,
                                  ),
                                  label: locale.tableDescriptionsDescription,
                                  onChanged: (text) {
                                    _bloc.add(
                                      InfoTableDescriptionEventChange(
                                        table: entry.key,
                                        description: text,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: () => _bloc.add(InfoTableDescriptionEventDelete(entry.key)),
                                icon: const Icon(Icons.delete_outline_outlined),
                              ),
                            ],
                          ),
                        ),
                      if (state.tableDescriptions.isNotEmpty) const Divider(height: 24),
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
                              child: CustomTextField(
                                label: locale.tableDescriptionsDescription,
                                controller: _descriptionController,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: int.tryParse(_tableController.text) != null ? _addTable : null,
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: locale.save,
                        disabled: !_areAllDescriptionsFilled(state.tableDescriptions),
                        onTap: () async {
                          final completer = Completer<void>();
                          _bloc.add(InfoTableDescriptionEventSave(completer: completer));
                          await completer.future;
                          if (context.mounted) {
                            context.backOrGoToDefault(
                              (c) => '/tournament/${widget.tournamentId}',
                            )();
                          }
                        },
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
