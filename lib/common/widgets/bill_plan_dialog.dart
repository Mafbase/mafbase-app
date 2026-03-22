import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/utils.dart';

class BillPlanDialog extends StatefulWidget {
  final String title;
  final String? subtitle;

  const BillPlanDialog._({
    required this.title,
    this.subtitle,
  });

  static Future<int?> open({
    required BuildContext context,
    required String title,
    String? subtitle,
  }) {
    return showDialog(
      context: context,
      builder: (context) => BillPlanDialog._(
        title: title,
        subtitle: subtitle,
      ),
    );
  }

  @override
  State<BillPlanDialog> createState() => _BillPlanDialogState();
}

class _BillPlanDialogState extends State<BillPlanDialog> {
  BillPlanOption _selected = BillPlanOption.year;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return RadioGroup(
      groupValue: _selected,
      onChanged: (_) {},
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: theme.defaultTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              if (widget.subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  widget.subtitle!,
                  style: theme.defaultTextStyle.copyWith(
                    fontSize: 13,
                    color: theme.darkGreyColor,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              ...BillPlanOption.values.map(
                (option) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _OptionCard(
                    option: option,
                    isSelected: _selected == option,
                    onTap: () => setState(() => _selected = option),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: theme.greyColor),
                    ),
                    child: Text(
                      locale.cancel,
                      style: theme.defaultTextStyle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, _selected.days),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        backgroundColor: theme.darkBlueColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          locale.profileBillDialogPayButton(
                            _selected.amount.floor(),
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final BillPlanOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: isSelected ? 12 : 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.darkBlueColor : Theme.of(context).dividerColor,
            width: isSelected ? 2 : 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Row(
          children: [
            Radio(value: option),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.label(locale),
                    style: theme.defaultTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    locale.profileBillPerMonth(option.monthlyPrice),
                    style: theme.defaultTextStyle.copyWith(
                      fontSize: 12,
                      color: theme.darkGreyColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${option.amount.floor()} \u20BD',
                  style: theme.defaultTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                if (option.discountPercent > 0) ...[
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.successColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      locale.profileBillDiscountBadge(option.discountPercent),
                      style: TextStyle(
                        color: theme.successColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum BillPlanOption {
  oneMonth(500.0, 30),
  threeMonths(1200.0, 90),
  sixMonths(2000.0, 180),
  year(3500.0, 365);

  const BillPlanOption(this.amount, this.days);

  final double amount;
  final int days;

  int get monthlyPrice => (amount / days * 30).round();

  int get discountPercent {
    const baseMonthly = 500.0;
    final actual = amount / days * 30;
    final discount = ((baseMonthly - actual) / baseMonthly * 100).round();
    return discount > 0 ? discount : 0;
  }

  String label(dynamic locale) {
    switch (this) {
      case oneMonth:
        return locale.profileBillOptionOneMonth;
      case threeMonths:
        return locale.profileBillOptionThreeMonths;
      case sixMonths:
        return locale.profileBillOptionSixMonths;
      case year:
        return locale.profileBillOptionYear;
    }
  }
}
