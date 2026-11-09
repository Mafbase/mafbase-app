import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_texts.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_billing_flow.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

/// «Готовность турнира A/B · Дальше: …» над списком участников, пока в чеклисте есть невыполненные пункты.
class OrganizerChecklistBanner extends StatelessWidget {
  const OrganizerChecklistBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizerChecklistBloc, OrganizerChecklistState>(
      builder: (context, state) {
        final checklist = state.checklist;
        final next = checklist?.next;
        if (checklist == null || next == null || state.isBannerHidden) return const SizedBox.shrink();

        return _BannerContent(checklist: checklist, next: next);
      },
    );
  }
}

class _BannerContent extends StatelessWidget {
  final OrganizerChecklistModel checklist;
  final ChecklistItemModel next;

  const _BannerContent({required this.checklist, required this.next});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;
    final bloc = context.read<OrganizerChecklistBloc>();
    final isMobile = context.isMobile;
    final accent = theme.btnColor2;
    final (:done, :total) = checklist.progress;
    final pay = next.isLocked && isTournamentBillingVisible(context);

    final texts = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          locale.checklistProgress(done, total),
          style: theme.defaultTextStyle.copyWith(fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        Text(
          locale.checklistBannerNext(locale.checklistItemTitle(next.key)),
          style: theme.defaultTextStyle.copyWith(fontSize: isMobile ? 13 : 14, color: theme.darkGreyColor),
        ),
      ],
    );
    final button = CustomButton(
      text: pay ? locale.checklistSheetPay : locale.checklistBannerOpen,
      minimize: true,
      expand: false,
      onTap: pay
          ? () => openTournamentBilling(
                context,
                preselectTranslation: next.key.group == ChecklistGroup.translation,
              )
          : () => context.router.push(OrganizerChecklistRoute(tournamentId: bloc.tournamentId)),
    );
    final close = IconButton(
      onPressed: () => bloc.add(const OrganizerChecklistEventHideBanner()),
      icon: const Icon(Icons.close, size: 20),
      color: theme.darkGreyColor,
      tooltip: locale.checklistBannerClose,
    );
    final icon = Icon(Icons.fact_check_outlined, color: accent);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    icon,
                    const SizedBox(width: 12),
                    Expanded(child: texts),
                    close,
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12, bottom: 4),
                  child: button,
                ),
              ],
            )
          : Row(
              children: [
                icon,
                const SizedBox(width: 12),
                Expanded(child: texts),
                const SizedBox(width: 12),
                button,
                const SizedBox(width: 4),
                close,
              ],
            ),
    );
  }
}
