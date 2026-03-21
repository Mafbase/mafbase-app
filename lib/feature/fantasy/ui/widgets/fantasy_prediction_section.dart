import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_bloc.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_event.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_state.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_game_win_utils.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

class FantasyPredictionSection extends StatelessWidget {
  final FantasyState state;
  final int tournamentId;

  const FantasyPredictionSection({
    super.key,
    required this.state,
    required this.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    final currentGameInfo = state.currentGameInfo;
    if (currentGameInfo == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            context.locale.fantasyCurrentGameInfoUnavailable,
            textAlign: TextAlign.center,
            style: MyTheme.of(context).defaultTextStyle,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.locale.fantasyCurrentGame,
          style: MyTheme.of(context).headerTextStyle,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  context.locale.fantasyGame(currentGameInfo.gameNumber),
                  style: MyTheme.of(context).defaultTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              if (!currentGameInfo.canParticipate) ...[
                Builder(
                  builder: (context) {
                    final isAuthorized = context.read<AuthNotifier>().value is AuthNotifierAuthorizedModel;
                    final message =
                        isAuthorized ? context.locale.fantasyNotParticipating : context.locale.fantasyNotAuthorized;
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Colors.orange,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              message,
                              style: MyTheme.of(context).defaultTextStyle.copyWith(
                                    color: Colors.orange.shade700,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ] else if (currentGameInfo.canPredict) ...[
                Text(
                  context.locale.fantasyYourPrediction,
                  style: MyTheme.of(context).defaultTextStyle,
                ),
                const SizedBox(height: 8),
                CustomDropdown<GameWin>(
                  initValue: state.selectedPrediction,
                  mapToString: (win) => context.getGameWinText(win) ?? '',
                  items: GameWin.values,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<FantasyBloc>().add(
                            FantasyEventSetPrediction(
                              tournamentId: tournamentId,
                              prediction: value,
                            ),
                          );
                    }
                  },
                ),
              ] else ...[
                Text(
                  context.locale.fantasyPredictionTimeExpired,
                  style: MyTheme.of(context).defaultTextStyle.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
