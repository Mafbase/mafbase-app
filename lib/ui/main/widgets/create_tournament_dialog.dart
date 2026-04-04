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
    return showDialog(
      context: context,
      builder: (context) => const CreateTournamentDialog(),
    );
  }
}

class _CreateTournamentDialogState extends State<CreateTournamentDialog> {
  final controller = TextEditingController();
  static final _format = DateFormat('dd MM yyyy');
  DateTimeRange? range;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [CloseButton()],
              ),
              CustomTextField(
                controller: controller,
                label: context.locale.createTournamentLabel,
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {
                  showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 356),
                    ),
                    lastDate: DateTime.now().add(
                      const Duration(days: 356),
                    ),
                  ).then((value) => setState(() => range = value ?? range));
                },
                child: Text(
                  range == null
                      ? context.locale.dateTimeRangePlaceholder
                      : '${_format.format(range!.start)} - ${_format.format(range!.end)}',
                  style: MyTheme.of(context).textBtnTextStyle,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                text: context.locale.create,
                disabled: range == null || controller.text.isEmpty,
                onTap: () {
                  Navigator.pop(
                    context,
                    CreateTournamentData(range!, controller.text),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateTournamentData {
  final DateTimeRange range;
  final String name;

  CreateTournamentData(this.range, this.name);
}
