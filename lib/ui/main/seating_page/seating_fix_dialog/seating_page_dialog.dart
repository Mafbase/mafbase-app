import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_effect.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_state.dart';
import 'package:seating_generator_web/utils.dart';

class SeatingPageDialog extends StatefulWidget {
  const SeatingPageDialog._();

  static Future<bool?> show({
    required BuildContext context,
    required List<String> players,
  }) =>
      showDialog(
        context: context,
        builder: (context) => create(players),
      );

  static Widget create(List<String> players) => BlocProvider<SeatingPageDialogBloc>(
        create: (context) => SeatingPageDialogBloc(
          SeatingPageDialogState(notFound: players),
          RepositoryFactory.of(context).playersRepository,
          context,
        )..add(const SeatingPageDialogEvent.init()),
        child: const SeatingPageDialog._(),
      );

  @override
  State<SeatingPageDialog> createState() => _SeatingPageDialogState();
}

class _SeatingPageDialogState extends State<SeatingPageDialog>
    with EffectListener<SeatingPageDialogEffect, SeatingPageDialogState, SeatingPageDialogBloc, SeatingPageDialog> {
  late final FocusNode focusNode = FocusNode();
  late final TextEditingController controller = TextEditingController();

  PlayerModel? selectedPlayer;

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<SeatingPageDialogBloc, SeatingPageDialogState>(
        listenWhen: (prev, curr) => prev.loading && !curr.loading,
        listener: (context, state) {
          controller.text = state.incorrectPlayer ?? '';
          focusNode.requestFocus();
        },
        builder: (context, state) {
          return CustomDialog(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: state.loading
                  ? const SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text.rich(
                            TextSpan(
                              style: const TextStyle(fontSize: 24),
                              children: [
                                TextSpan(
                                  text: context.locale.seatingPlayerNotFound,
                                ),
                                TextSpan(
                                  text: state.incorrectPlayer,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            context.locale.seatingSelectOrCreatePlayer,
                          ),
                          NicknameField(
                            controller: controller,
                            focusNode: focusNode,
                            readOnly: false,
                            label: context.locale.nicknameHint,
                            down: true,
                            onNewPlayer: ({initValue}) {
                              if (initValue == null) return;

                              context.read<SeatingPageDialogBloc>().add(
                                    SeatingPageDialogEvent.newPlayer(initValue),
                                  );
                            },
                            onSelected: (player) {
                              setState(
                                () => selectedPlayer = player,
                              );
                            },
                          ),
                          if (selectedPlayer?.fsmNickaname case String fsmNickname)
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: context.locale.seatingCurrentFsmNickname,
                                  ),
                                  TextSpan(
                                    text: fsmNickname,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 32),
                          CustomButton(
                            text: context.locale.confirm,
                            disabled: selectedPlayer == null,
                            onTap: () {
                              final player = selectedPlayer;
                              if (player == null) return;

                              context.read<SeatingPageDialogBloc>().add(
                                    SeatingPageDialogEvent.existingPlayer(
                                      player,
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      );

  @override
  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {
    on<SeatingPageDialogEffectSuccess>(_success);
  }

  void _success(SeatingPageDialogEffectSuccess effect) => Navigator.pop(context, true);
}
