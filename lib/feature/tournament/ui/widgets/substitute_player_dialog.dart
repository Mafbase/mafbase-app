import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/utils.dart';

class SubstitutePlayerDialog extends StatefulWidget {
  final PlayerModel oldPlayer;
  final List<int> gameNumbers;
  final bool isBottomSheet;

  const SubstitutePlayerDialog({
    super.key,
    required this.oldPlayer,
    required this.gameNumbers,
    this.isBottomSheet = false,
  });

  static Future<({int newPlayerId, List<int> games})?> show({
    required BuildContext context,
    required PlayerModel oldPlayer,
    required List<int> gameNumbers,
  }) {

    return showDialog<({int newPlayerId, List<int> games})>(
      context: context,
      builder: (ctx) => SubstitutePlayerDialog(
        oldPlayer: oldPlayer,
        gameNumbers: gameNumbers,
      ),
    );
  }

  @override
  State<SubstitutePlayerDialog> createState() =>
      _SubstitutePlayerDialogState();
}

class _SubstitutePlayerDialogState extends State<SubstitutePlayerDialog> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  PlayerModel? _selectedPlayer;
  late final Map<int, bool> _selectedGames;

  @override
  void initState() {
    super.initState();
    _selectedGames = {
      for (final game in widget.gameNumbers) game: true,
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _selectedPlayer != null &&
      _selectedGames.values.any((selected) => selected);

  List<int> get _selectedGameNumbers => _selectedGames.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList()
    ..sort();

  void _onSubmit() {
    if (!_canSubmit) return;
    Navigator.pop(
      context,
      (newPlayerId: _selectedPlayer!.id, games: _selectedGameNumbers),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);
    if (widget.isBottomSheet) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: content,
        ),
      );
    }
    return CustomDialog(child: content);
  }

  Widget _buildContent(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return Container(
      width: widget.isBottomSheet ? null : 580,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 40,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Text(
                    locale.substitutePlayer,
                    textAlign: TextAlign.center,
                    style: theme.headerTextStyle,
                  ),
                ),
                const CloseButton(),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              locale.substitutePlayerOld,
              style: theme.defaultTextStyle.copyWith(
                color: theme.darkGreyColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.oldPlayer.nickname,
              style: theme.defaultTextStyle,
            ),
            const SizedBox(height: 16),
            Text(
              locale.substitutePlayerNew,
              style: theme.defaultTextStyle.copyWith(
                color: theme.darkGreyColor,
              ),
            ),
            const SizedBox(height: 8),
            PlayerAutoComplete(
              hint: locale.substitutePlayerNew,
              controller: _controller,
              focusNode: _focusNode,
              onSelected: (player) {
                setState(() {
                  _selectedPlayer = player;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              locale.substitutePlayerSelectGames,
              style: theme.defaultTextStyle.copyWith(
                color: theme.darkGreyColor,
              ),
            ),
            const SizedBox(height: 8),
            ...widget.gameNumbers.map(
              (game) => CheckboxListTile(
                title: Text(
                  locale.substitutePlayerGameNumber(game),
                  style: theme.defaultTextStyle,
                ),
                value: _selectedGames[game] ?? false,
                onChanged: (value) {
                  setState(() {
                    _selectedGames[game] = value ?? false;
                  });
                },
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: locale.substitutePlayerButton,
              onTap: _onSubmit,
              disabled: !_canSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
