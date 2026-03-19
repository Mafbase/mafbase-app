import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/feature/info_table_description/ui/info_table_dialog.dart';
import 'package:seating_generator_web/utils.dart';

class StartGameInfoDialog extends StatefulWidget {
  final int maxGame;
  final String tournamentId;

  const StartGameInfoDialog._({
    required this.maxGame,
    required this.tournamentId,
  });

  static Future<(int, TimeOfDay?)?> show({
    required BuildContext context,
    required int maxGame,
    required String tournamentId,
  }) {
    return showDialog(
      context: context,
      builder: (_) => StartGameInfoDialog._(
        maxGame: maxGame,
        tournamentId: tournamentId,
      ),
    );
  }

  @override
  State<StartGameInfoDialog> createState() => _StartGameInfoDialogState();
}

class _StartGameInfoDialogState extends State<StartGameInfoDialog> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) => CustomDialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      'Оповещение об игре',
                      style: MyTheme.of(context).headerTextStyle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => InfoTableDialog.show(context: context, tournamentId: widget.tournamentId),
                    icon: const Icon(Icons.info_outline_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                  );

                  if (time == null || !mounted) return;

                  setState(() {
                    selectedTime = time;
                  });
                },
                child: Text(
                  switch (selectedTime) {
                    final TimeOfDay time => DateFormat('HH:mm').format(
                        DateTime.now().copyWith(
                          hour: time.hour,
                          minute: time.minute,
                        ),
                      ),
                    _ => context.locale.local_time_placeholder,
                  },
                ),
              ),
              const SizedBox(height: 24),
              FormField<int>(
                validator: (value) => value != null && value > 0 && value <= widget.maxGame ? null : '',
                builder: (field) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 60,
                        child: CustomDropdown(
                          items: List.generate(widget.maxGame, (index) => index + 1),
                          initValue: field.value,
                          onChanged: (value) => field.didChange(value),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomButton(
                        text: 'Отправить',
                        onTap: () {
                          Navigator.pop(
                            context,
                            (field.value, selectedTime),
                          );
                        },
                        disabled: !field.validate(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
}
