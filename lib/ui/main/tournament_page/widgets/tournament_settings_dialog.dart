import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
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
}

class _TournamentSettingsDialogState extends State<TournamentSettingsDialog> {
  final defaultGamesController = TextEditingController();
  final finalGamesController = TextEditingController();
  final swissGamesController = TextEditingController();

  @override
  void initState() {
    defaultGamesController.text = widget.defaultGames.toString();
    finalGamesController.text = widget.finalGames.toString();
    swissGamesController.text = widget.swissGames.toString();
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
        child: Column(
          children: [
            Text(
              context.locale.tournamentSettingsTitle,
              style: MyTheme.of(context).headerTextStyle,
            ),
            CustomTextField(
              controller: defaultGamesController,
            ),
            CustomTextField(
              controller: swissGamesController,
            ),
            CustomTextField(
              controller: finalGamesController,
            ),
          ],
        ),
      ),
    );
  }
}
