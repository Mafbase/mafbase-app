import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_texts.dart';
import 'package:seating_generator_web/utils.dart';

/// Свёрнутый блок «Скрытые (N)». Если скрыта вся группа «Трансляция», она возвращается одной строкой.
class OrganizerChecklistHiddenSection extends StatelessWidget {
  final OrganizerChecklistModel checklist;
  final bool enabled;
  final ValueChanged<List<ChecklistKey>> onRestore;

  const OrganizerChecklistHiddenSection({
    super.key,
    required this.checklist,
    required this.enabled,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;
    final dismissed = checklist.dismissedItems;
    final translationKeys = [
      for (final item in checklist.items)
        if (item.key.group == ChecklistGroup.translation) item.key,
    ];
    final translationHidden = translationKeys.length > 1 && translationKeys.every(checklist.isDismissed);

    final rows = <Widget>[];
    var translationRowAdded = false;
    for (final item in dismissed) {
      if (translationHidden && item.key.group == ChecklistGroup.translation) {
        if (translationRowAdded) continue;
        translationRowAdded = true;
        rows.add(
          _HiddenRow(
            title: locale.checklistGroupTranslation,
            subtitle: locale.checklistHiddenGroup,
            onRestore: enabled ? () => onRestore(translationKeys) : null,
          ),
        );
      } else {
        rows.add(
          _HiddenRow(
            title: locale.checklistItemTitle(item.key),
            onRestore: enabled ? () => onRestore([item.key]) : null,
          ),
        );
      }
    }

    return Material(
      color: theme.background2,
      shadowColor: theme.cardShadowColor,
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        leading: Icon(Icons.visibility_off_outlined, color: theme.darkGreyColor),
        title: Text(
          locale.checklistHidden(dismissed.length),
          style: theme.defaultTextStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
        children: rows,
      ),
    );
  }
}

class _HiddenRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onRestore;

  const _HiddenRow({
    required this.title,
    required this.onRestore,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: theme.defaultTextStyle.copyWith(fontSize: 14, color: theme.darkGreyColor)),
                if (subtitle case final subtitle?)
                  Text(subtitle, style: theme.defaultTextStyle.copyWith(fontSize: 12, color: theme.hintColor)),
              ],
            ),
          ),
          TextButton(
            onPressed: onRestore,
            style: TextButton.styleFrom(
              textStyle: theme.defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            child: Text(context.locale.checklistRestore),
          ),
        ],
      ),
    );
  }
}
