import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/utils.dart';

class FinalPlayersDialog extends StatefulWidget {
  final List<PlayerModel> initValue;
  final List<PlayerModel> players;

  const FinalPlayersDialog({
    super.key,
    required this.initValue,
    required this.players,
  });

  @override
  State<FinalPlayersDialog> createState() => _FinalPlayersDialogState();

  static Future<List<PlayerModel>?> open({
    required BuildContext context,
    required List<PlayerModel> initValue,
    required List<PlayerModel> players,
  }) {
    return showDialog(
      context: context,
      builder: (context) => FinalPlayersDialog(
        initValue: initValue,
        players: players,
      ),
    );
  }
}

class _FinalPlayersDialogState extends State<FinalPlayersDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 600, maxWidth: 400),
            child: FormField<Set<int>>(
              initialValue: widget.initValue.map((e) => e.id).toSet(),
              validator: (value) {
                if (value == null || value.length != 10) {
                  return 'Выберите игроков';
                }
                return null;
              },
              builder: (field) => Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      child: ListView.builder(
                        itemCount: widget.players.length,
                        itemBuilder: (context, index) {
                          final disabled = field.value?.length == 10;
                          final player = widget.players[index];
                          return Row(
                            children: [
                              Checkbox(
                                value: field.value?.contains(player.id),
                                onChanged: disabled && (field.value?.contains(player.id) == false)
                                    ? null
                                    : (value) {
                                        if (value == true) {
                                          field.didChange(
                                            field.value?.union({player.id}) ?? {player.id},
                                          );
                                        } else {
                                          field.didChange(
                                            field.value?.difference({player.id}) ?? {},
                                          );
                                        }
                                      },
                              ),
                              Text(
                                player.nickname,
                                style: MyTheme.of(context).defaultTextStyle,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  CustomButton(
                    text: context.locale.save,
                    disabled: !field.isValid,
                    onTap: () {
                      Navigator.of(context).pop(
                        field.value
                            ?.map(
                              (e) => widget.players.firstWhere(
                                (element) => element.id == e,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const Positioned(top: 0, right: 0, child: CloseButton()),
        ],
      ),
    );
  }
}
