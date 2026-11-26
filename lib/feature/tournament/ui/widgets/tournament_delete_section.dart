import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/utils.dart';

/// Кнопка удаления турнира внизу настроек; видна, только если backend разрешил удаление.
class TournamentDeleteSection extends StatelessWidget {
  const TournamentDeleteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentPageBloc, TournamentPageState>(
      buildWhen: (prev, curr) =>
          prev.canDeleteTournament != curr.canDeleteTournament ||
          prev.isDeletingTournament != curr.isDeletingTournament ||
          prev.tournamentName != curr.tournamentName,
      builder: (context, state) {
        if (!state.canDeleteTournament) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            const Divider(height: 1),
            const SizedBox(height: 24),
            CustomButton(
              text: context.locale.tournamentDelete,
              isRed: true,
              isLoading: state.isDeletingTournament,
              onTap: () => _confirmDelete(context, state.tournamentName ?? ''),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, String tournamentName) async {
    final bloc = context.read<TournamentPageBloc>();
    final confirmed = await ConfirmDialog.open(context, context.locale.tournamentDeleteConfirm(tournamentName));
    if (confirmed == true) {
      bloc.add(const TournamentPageEvent.deleteTournament());
    }
  }
}
