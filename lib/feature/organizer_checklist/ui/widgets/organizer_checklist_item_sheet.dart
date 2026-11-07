import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_texts.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_info_sheet.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_item_content.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_status_icon.dart';
import 'package:seating_generator_web/utils.dart';

/// Лист деталей пункта чеклиста: пояснение, «Сделать», «Не нужно» и «Задать вопрос».
class OrganizerChecklistItemSheet {
  OrganizerChecklistItemSheet._();

  /// [context] должен пережить лист и видеть блоки страницы турнира. Вне страницы чеклиста пункт может быть
  /// не загружен — тогда выключают [showStatus] и [showDismiss].
  static Future<void> show(
    BuildContext context, {
    required int tournamentId,
    required ChecklistItemModel item,
    OrganizerChecklistModel? checklist,
    String? title,
    bool showStatus = true,
    bool showAction = true,
    bool showDismiss = true,
  }) {
    final locale = context.locale;
    final content = OrganizerChecklistItemContent(
      context,
      tournamentId: tournamentId,
      item: item,
      checklist: checklist,
    );

    return OrganizerChecklistInfoSheet.show(
      context,
      title: title ?? locale.checklistItemTitle(item.key),
      body: [
        if (showStatus)
          _StatusLine(
            status: item.status,
            text: locale.checklistItemSubtitle(
              item,
              isFsm: checklist?.isFsm ?? false,
              streamMethod: checklist?.streamMethod,
            ),
          ),
        ...content.body(),
      ],
      primaryAction: showAction ? content.primaryAction() : null,
      secondaryAction: showDismiss ? content.dismissAction() : null,
    );
  }
}

class _StatusLine extends StatelessWidget {
  final ChecklistStatus status;
  final String text;

  const _StatusLine({required this.status, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OrganizerChecklistStatusIcon(status: status, size: 32),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
