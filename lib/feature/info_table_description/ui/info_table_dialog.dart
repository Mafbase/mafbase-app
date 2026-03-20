import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/feature/info_table_description/ui/info_table_description_bloc.dart';
import 'package:seating_generator_web/feature/info_table_description/ui/info_table_description_event.dart';
import 'package:seating_generator_web/feature/info_table_description/ui/info_table_description_state.dart';

class InfoTableDialog extends StatefulWidget {
  const InfoTableDialog({super.key});

  static Future<void> show({required BuildContext context, required String tournamentId}) => showDialog(
        context: context,
        builder: (_) => BlocProvider(
          create: (_) => InfoTableDescriptionBloc(
            const InfoTableState(),
            RepositoryFactory.of(context).infoTableDescriptionRepository,
          )..add(InfoTableDescriptionEventInit(tournamentId)),
          child: InfoTableDialog(),
        ),
      );

  @override
  State<InfoTableDialog> createState() => _InfoTableDialogState();
}

class _InfoTableDialogState extends State<InfoTableDialog> {
  final _controller = TextEditingController();
  final _controllers = <int, TextEditingController>{};

  InfoTableDescriptionBloc get _bloc => context.read();

  @override
  void dispose() {
    _controller.dispose();
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController getControllerFor({
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

  @override
  Widget build(BuildContext context) => BlocBuilder<InfoTableDescriptionBloc, InfoTableState>(
        builder: (context, state) => CustomDialog(
          child: state.loading
              ? SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(child: const CircularProgressIndicator()),
                )
              : ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(16),
                    child: Column(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Описания локаций',
                          style: MyTheme.of(context).headerTextStyle,
                        ),
                        for (final entry in state.tableDescriptions)
                          Row(
                            children: [
                              Text('${entry.key} - '),
                              Flexible(
                                child: CustomTextField(
                                  controller: getControllerFor(
                                    table: entry.key,
                                    defaultText: entry.value,
                                  ),
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
                              )
                            ],
                          ),
                        ListenableBuilder(
                          listenable: _controller,
                          builder: (context, _) => Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: CustomTextField(
                                  hint: '1',
                                  controller: _controller,
                                  textInputType: TextInputType.number,
                                ),
                              ),
                              Flexible(
                                child: CustomButton(
                                  text: 'Добавить описание',
                                  disabled: int.tryParse(_controller.text) == null,
                                  onTap: () => _bloc.add(InfoTableDescriptionEventAdd(int.parse(_controller.text))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            text: 'Сохранить',
                            disabled: !_areAllDescriptionsFilled(state.tableDescriptions),
                            onTap: () async {
                              final completer = Completer<void>();
                              _bloc.add(InfoTableDescriptionEventSave(completer: completer));
                              await completer.future;
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );
}
