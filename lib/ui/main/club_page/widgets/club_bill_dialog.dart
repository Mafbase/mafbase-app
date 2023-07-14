import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/utils.dart';

enum ClubBillOptions {
  oneMonth(500.0, 30),
  threeMonths(1200.0, 90),
  sixMonths(2000.0, 180),
  year(3500.0, 365);

  const ClubBillOptions(this.amount, this.days);

  final double amount;
  final int days;
}

class ClubBillDialog extends StatefulWidget {
  final DateTime? billedFor;

  const ClubBillDialog._({Key? key, this.billedFor}) : super(key: key);

  @override
  State<ClubBillDialog> createState() => _ClubBillDialogState();

  static Future<ClubBillOptions?> open({
    required BuildContext context,
    required DateTime? billedFor,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ClubBillDialog._(billedFor: billedFor),
    );
  }
}

class _ClubBillDialogState extends State<ClubBillDialog> {
  ClubBillOptions? groupValue;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.billedFor != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  context.locale.billedFor(
                    DateFormat(
                      "dd MMMM yyyy",
                      Localizations.localeOf(context).languageCode,
                    ).format(widget.billedFor!),
                  ),
                ),
              ),
            ...ClubBillOptions.values.map(
              (value) => RadioListTile(
                title: Text(
                  context.locale.billClubDialogOption(value.days),
                ),
                subtitle: Text(
                  "${value.amount.floor()}₽",
                ),
                value: value,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() {
                    groupValue = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: groupValue == null
                  ? context.locale.billClubButtonDisabledText
                  : context.locale
                      .billClubButtonText(groupValue!.amount.floor()),
              disabled: groupValue == null,
              onTap: () {
                Navigator.of(context).pop(groupValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
