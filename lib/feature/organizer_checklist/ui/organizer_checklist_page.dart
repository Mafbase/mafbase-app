import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_view.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils.dart';

/// Чеклист берёт блок со страницы турнира, поэтому открывается только её дочерним маршрутом.
@RoutePage()
class OrganizerChecklistPage extends StatefulWidget {
  final int tournamentId;

  const OrganizerChecklistPage({
    super.key,
    @PathParam('id') required this.tournamentId,
  });

  @override
  State<OrganizerChecklistPage> createState() => _OrganizerChecklistPageState();
}

class _OrganizerChecklistPageState extends State<OrganizerChecklistPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrganizerChecklistBloc>().add(const OrganizerChecklistEventLoad());
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: context.backOrGoToDefault((c) => '/tournament/${widget.tournamentId}'),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(locale.checklistTitle),
        ),
        actions: [
          TournamentMenuAction(
            openDrawer: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      body: BlocBuilder<OrganizerChecklistBloc, OrganizerChecklistState>(
        builder: (context, state) {
          if (state.checklist case final checklist?) {
            return Stack(
              children: [
                OrganizerChecklistView(
                  tournamentId: widget.tournamentId,
                  checklist: checklist,
                  isUpdating: state.isUpdating,
                ),
                if (state.isUpdating) const LinearProgressIndicator(),
              ],
            );
          }
          if (state.hasError) {
            return _LoadError(
              onRetry: () => context.read<OrganizerChecklistBloc>().add(const OrganizerChecklistEventLoad()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _LoadError extends StatelessWidget {
  final VoidCallback onRetry;

  const _LoadError({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_outlined, size: 56, color: theme.greyColor),
            const SizedBox(height: 16),
            Text(
              locale.checklistLoadError,
              textAlign: TextAlign.center,
              style: theme.defaultTextStyle.copyWith(color: theme.darkGreyColor),
            ),
            const SizedBox(height: 24),
            CustomButton(text: locale.checklistRetry, expand: false, onTap: onRetry),
          ],
        ),
      ),
    );
  }
}
