import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/utils.dart';

class SeparationDialog extends StatefulWidget {
  final List<PlayerModel> availablePlayers;

  const SeparationDialog({
    super.key,
    required this.availablePlayers,
  });

  static Future<Pair<PlayerModel, PlayerModel>?> open(
    BuildContext context,
    List<PlayerModel> availablePlayers,
  ) {
    return showDialog(
      context: context,
      builder: (context) =>
          SeparationDialog(availablePlayers: availablePlayers),
    );
  }

  @override
  State<SeparationDialog> createState() => _SeparationDialogState();
}

class _SeparationDialogState extends State<SeparationDialog> {
  final firstPlayerTextField = TextEditingController();
  final secondPlayerTextField = TextEditingController();
  final firstFocusNode = FocusNode();
  final secondFocusNode = FocusNode();

  @override
  void dispose() {
    firstPlayerTextField.dispose();
    secondPlayerTextField.dispose();
    firstFocusNode.dispose();
    secondFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.locale.separateTitle,
                style: MyTheme.of(context).headerTextStyle,
              ),
              const SizedBox(
                height: 8,
              ),
              NicknameField(
                down: true,
                controller: firstPlayerTextField,
                focusNode: firstFocusNode,
                availablePlayers: widget.availablePlayers,
                readOnly: false,
                hint: context.locale.nicknameHint,
                onSelected: (_) {
                  secondFocusNode.requestFocus();
                },
              ),
              const SizedBox(
                height: 8,
              ),
              NicknameField(
                down: true,
                controller: secondPlayerTextField,
                focusNode: secondFocusNode,
                availablePlayers: widget.availablePlayers,
                readOnly: false,
                hint: context.locale.nicknameHint,
                onSelected: (_) {
                  secondFocusNode.unfocus();
                },
              ),
              const SizedBox(
                height: 8,
              ),
              CustomButton(
                text: context.locale.save,
                onTap: () {
                  Navigator.pop(
                    context,
                    Pair(
                      widget.availablePlayers.firstWhere(
                        (element) =>
                            element.nickname == firstPlayerTextField.text,
                      ),
                      widget.availablePlayers.firstWhere(
                        (element) =>
                            element.nickname == secondPlayerTextField.text,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
