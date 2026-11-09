import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_texts.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_group_section.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_hidden_section.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_item_row.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_item_sheet.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_progress_header.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class OrganizerChecklistView extends StatelessWidget {
  final int tournamentId;
  final OrganizerChecklistModel checklist;
  final bool isUpdating;

  const OrganizerChecklistView({
    super.key,
    required this.tournamentId,
    required this.checklist,
    required this.isUpdating,
  });

  void _openItem(BuildContext context, ChecklistItemModel item) {
    final bloc = context.read<OrganizerChecklistBloc>();
    OrganizerChecklistItemSheet.show(context, tournamentId: tournamentId, item: item, checklist: checklist).then((_) {
      if (!bloc.isClosed) bloc.add(const OrganizerChecklistEventLoad());
    });
  }

  void _setDismissed(BuildContext context, List<ChecklistKey> keys, {required bool dismissed}) {
    context.read<OrganizerChecklistBloc>().add(OrganizerChecklistEventSetDismissed(keys: keys, dismissed: dismissed));
  }

  List<Widget> _rows(BuildContext context, ChecklistGroup group, List<ChecklistItemModel> items) {
    final locale = context.locale;

    Widget row(ChecklistItemModel item) => OrganizerChecklistItemRow(
          status: item.status,
          title: locale.checklistItemTitle(item.key),
          subtitle: locale.checklistItemSubtitle(
            item,
            isFsm: checklist.isFsm,
            streamMethod: checklist.streamMethod,
          ),
          onTap: () => _openItem(context, item),
        );

    if (group != ChecklistGroup.translation || checklist.isStreamMethodChosen) return items.map(row).toList();

    return [
      for (final item in items)
        if (item.key.method == null) row(item),
      for (final method in ChecklistStreamMethod.values)
        if (items.where((item) => item.key.method == method).toList() case final methodItems
            when methodItems.isNotEmpty) ...[
          OrganizerChecklistSubheader(text: locale.checklistStreamMethodSection(method)),
          ...methodItems.map(row),
        ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final isMobile = context.isMobile;
    final visible = checklist.visibleItems;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: isMobile ? 16 : 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 24,
            children: [
              OrganizerChecklistProgressHeader(progress: checklist.progress),
              for (final group in ChecklistGroup.values)
                if (visible.where((item) => item.key.group == group).toList() case final items when items.isNotEmpty)
                  OrganizerChecklistGroupSection(
                    title: locale.checklistGroupTitle(group),
                    action: group == ChecklistGroup.translation
                        ? TextButton(
                            onPressed: isUpdating ? null : () => _setDismissed(context, group.keys, dismissed: true),
                            child: Text(locale.checklistGroupNotNeeded),
                          )
                        : null,
                    children: _rows(context, group, items),
                  ),
              if (checklist.dismissedItems.isNotEmpty)
                OrganizerChecklistHiddenSection(
                  checklist: checklist,
                  enabled: !isUpdating,
                  onRestore: (keys) => _setDismissed(context, keys, dismissed: false),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
