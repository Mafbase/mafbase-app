import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentSubscriptionBillDialog extends StatefulWidget {
  final bool isRenew;

  const TournamentSubscriptionBillDialog._({
    required this.isRenew,
  });

  static const List<TournamentSubscriptionBillOption> options = [
    TournamentSubscriptionBillOption.oneMonth,
    TournamentSubscriptionBillOption.threeMonths,
    TournamentSubscriptionBillOption.sixMonths,
    TournamentSubscriptionBillOption.year,
  ];

  static Future<int?> open({
    required BuildContext context,
    required bool isRenew,
  }) {
    return showDialog(
      context: context,
      builder: (context) => TournamentSubscriptionBillDialog._(
        isRenew: isRenew,
      ),
    );
  }

  @override
  State<TournamentSubscriptionBillDialog> createState() =>
      _TournamentSubscriptionBillDialogState();
}

class _TournamentSubscriptionBillDialogState
    extends State<TournamentSubscriptionBillDialog> {
  TournamentSubscriptionBillOption? _option;

  @override
  Widget build(BuildContext context) {
    final actionText = widget.isRenew
        ? context.locale.profileTournamentSubscriptionRenew
        : context.locale.profileTournamentSubscriptionCreate;

    return CustomDialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              actionText,
              style: context.theme.defaultTextStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            RadioGroup(
              groupValue: _option,
              onChanged: (value) {
                setState(() {
                  _option = value;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: TournamentSubscriptionBillDialog.options
                    .map(
                      (option) => RadioListTile(
                        title: Text(
                          context.locale.profileTournamentSubscriptionOption(
                            option.days,
                          ),
                        ),
                        subtitle: Text(
                          '${option.amount.floor()}₽',
                        ),
                        value: option,
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: actionText,
              disabled: _option == null,
              onTap: () => Navigator.of(context).pop(_option?.days),
            ),
          ],
        ),
      ),
    );
  }
}

enum TournamentSubscriptionBillOption {
  oneMonth(500.0, 30),
  threeMonths(1200.0, 90),
  sixMonths(2000.0, 180),
  year(3500.0, 365);

  const TournamentSubscriptionBillOption(this.amount, this.days);

  final double amount;
  final int days;
}
