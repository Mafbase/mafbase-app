import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/utils.dart';

/// «Получат: X из N» под формой оповещения в меню турнира; без счётчиков пункта охвата не показывается.
class NotificationCoverageCounterLink extends StatelessWidget {
  const NotificationCoverageCounterLink({super.key});

  @override
  Widget build(BuildContext context) {
    final item = context.select<OrganizerChecklistBloc, ChecklistItemModel?>(
      (bloc) => bloc.state.checklist?.item(ChecklistKey.notifyCoverage),
    );
    if (item == null || item.unavailable || item.isLocked) return const SizedBox.shrink();
    final (current, total) = (item.current, item.total);
    if (current == null || total == null || total == 0) return const SizedBox.shrink();

    final theme = context.theme;
    final everyone = current >= total;
    final color = theme.sidebarInactiveTextColor;

    return InkWell(
      onTap: () {
        final tournamentId = context.read<OrganizerChecklistBloc>().tournamentId;
        Scaffold.maybeOf(context)?.closeEndDrawer();
        context.router.navigate(NotificationCoverageRoute(tournamentId: tournamentId));
      },
      borderRadius: BorderRadius.circular(8),
      hoverColor: theme.sidebarActiveItemBgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          children: [
            Icon(
              everyone ? Icons.check_circle_outline : Icons.error_outline,
              size: 16,
              color: everyone ? theme.successColor : theme.statusBillingColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                context.locale.checklistCoverageFormCounter(current, total),
                style: theme.defaultTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.w500, color: color),
              ),
            ),
            Icon(Icons.chevron_right, size: 18, color: color),
          ],
        ),
      ),
    );
  }
}
