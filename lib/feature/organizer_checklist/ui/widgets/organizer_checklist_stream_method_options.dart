import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_texts.dart';
import 'package:seating_generator_web/utils.dart';

/// Выбор способа закрывает лист; выбранный способ отмечен и не нажимается.
class OrganizerChecklistStreamMethodOptions extends StatelessWidget {
  final ChecklistStreamMethod? selected;
  final ValueChanged<ChecklistStreamMethod> onSelect;

  const OrganizerChecklistStreamMethodOptions({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        for (final method in ChecklistStreamMethod.values)
          _MethodOption(
            method: method,
            selected: method == selected,
            onTap: method == selected
                ? null
                : () {
                    Navigator.pop(context);
                    onSelect(method);
                  },
          ),
      ],
    );
  }
}

class _MethodOption extends StatelessWidget {
  final ChecklistStreamMethod method;
  final bool selected;
  final VoidCallback? onTap;

  const _MethodOption({
    required this.method,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;
    final borderColor = selected ? theme.successColor : theme.borderColor;

    return Material(
      color: theme.background2,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                method == ChecklistStreamMethod.obs ? Icons.desktop_windows_outlined : Icons.smartphone,
                color: theme.darkGreyColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      locale.checklistStreamMethodName(method),
                      style: theme.defaultTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      method == ChecklistStreamMethod.obs
                          ? locale.checklistSheetStreamMethodObsHint
                          : locale.checklistSheetStreamMethodPhoneHint,
                      style: theme.defaultTextStyle.copyWith(fontSize: 14, color: theme.darkGreyColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (selected) ...[
                Icon(Icons.check_circle, size: 18, color: theme.successColor),
                const SizedBox(width: 4),
                Text(
                  locale.checklistSheetStreamMethodSelected,
                  style: theme.defaultTextStyle.copyWith(fontSize: 14, color: theme.successColor),
                ),
              ] else
                Icon(Icons.chevron_right, color: theme.hintColor),
            ],
          ),
        ),
      ),
    );
  }
}
