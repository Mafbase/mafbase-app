import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/utils.dart';

class CreateTournamentDialog extends StatefulWidget {
  const CreateTournamentDialog({super.key});

  @override
  State<CreateTournamentDialog> createState() => _CreateTournamentDialogState();

  static Future<CreateTournamentData?> open(BuildContext context) {
    return showDialog(context: context, builder: (context) => const CreateTournamentDialog());
  }
}

class _CreateTournamentDialogState extends State<CreateTournamentDialog> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static final _format = DateFormat('dd MM yyyy');
  DateTimeRange? range;
  bool dateError = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return CustomDialog(
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(alignment: Alignment.centerRight, child: CloseButton()),
                CustomTextField(
                  controller: controller,
                  label: context.locale.createTournamentLabel,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return context.locale.createTournamentNameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: dateError ? theme.redColor : Colors.transparent, width: 1.5),
                        ),
                        child: TextButton(
                          onPressed: pickDateRange,
                          child: Text(
                            range == null
                                ? context.locale.dateTimeRangePlaceholder
                                : '${_format.format(range!.start)} - ${_format.format(range!.end)}',
                            style: theme.textBtnTextStyle,
                          ),
                        ),
                      ),
                      if (dateError)
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 4),
                          child: Text(
                            context.locale.createTournamentDateRequired,
                            style: TextStyle(color: theme.redColor, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(text: context.locale.create, onTap: onSubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickDateRange() async {
    final value = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 356)),
      lastDate: DateTime.now().add(const Duration(days: 356)),
    );
    if (value != null) {
      setState(() {
        range = value;
        dateError = false;
      });
    }
  }

  void onSubmit() {
    final isNameValid = _formKey.currentState?.validate() ?? false;
    final selectedRange = range;
    setState(() => dateError = selectedRange == null);

    if (isNameValid && selectedRange != null) {
      Navigator.pop(context, CreateTournamentData(selectedRange, controller.text));
    }
  }
}

class CreateTournamentData {
  final DateTimeRange range;
  final String name;

  CreateTournamentData(this.range, this.name);
}
