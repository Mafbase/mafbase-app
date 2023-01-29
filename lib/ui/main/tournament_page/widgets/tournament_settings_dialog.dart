import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentSettingsDialog extends StatefulWidget {
  final int defaultGames;
  final int swissGames;
  final int finalGames;

  const TournamentSettingsDialog({
    Key? key,
    this.defaultGames = 0,
    this.swissGames = 0,
    this.finalGames = 0,
  }) : super(key: key);

  @override
  State<TournamentSettingsDialog> createState() =>
      _TournamentSettingsDialogState();

  static Future<TournamentSettingsModel?> open({
    required BuildContext context,
    required TournamentSettingsModel initValue,
  }) {
    return showDialog(
      context: context,
      builder: (context) => TournamentSettingsDialog(
        defaultGames: initValue.defaultGames,
        swissGames: initValue.swissGames,
        finalGames: initValue.finalGames,
      ),
    );
  }
}

class _TournamentSettingsDialogState extends State<TournamentSettingsDialog> {
  final defaultGamesController = TextEditingController();
  final finalGamesController = TextEditingController();
  final swissGamesController = TextEditingController();

  final formState = GlobalKey<FormState>();

  @override
  void initState() {
    defaultGamesController.text = widget.defaultGames.toString();
    finalGamesController.text = widget.finalGames.toString();
    swissGamesController.text = widget.swissGames.toString();
    defaultGamesController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    defaultGamesController.dispose();
    swissGamesController.dispose();
    finalGamesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: SizedBox(
        width: 600,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formState,
          onChanged: () {
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.locale.tournamentSettingsTitle,
                  style: MyTheme.of(context).headerTextStyle,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  hint: "6",
                  validate: (value) => int.tryParse(value ?? "") == null
                      ? "Неверный формат числа"
                      : null,
                  label: context.locale.defaultGamesLabel,
                  controller: defaultGamesController,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  validate: (value) => int.tryParse(value ?? "") == null
                      ? "Неверный формат числа"
                      : null,
                  hint: "6",
                  label: context.locale.swissGamesLabel,
                  controller: swissGamesController,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  hint: "6",
                  validate: (value) => int.tryParse(value ?? "") == null
                      ? "Неверный формат числа"
                      : null,
                  label: context.locale.finalGamesLabel,
                  controller: finalGamesController,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  text: context.locale.save,
                  disabled: formState.currentState?.validate() != true,
                  onTap: () {
                    Navigator.of(context).pop(
                      TournamentSettingsModel(
                        defaultGames: int.parse(defaultGamesController.text),
                        swissGames: int.parse(swissGamesController.text),
                        finalGames: int.parse(finalGamesController.text),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
