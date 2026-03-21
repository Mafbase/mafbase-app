import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/utils.dart';

class AddPlayerDialog extends StatefulWidget {
  final String? initValue;

  const AddPlayerDialog({
    super.key,
    this.initValue,
  });

  @override
  State<AddPlayerDialog> createState() => _AddPlayerDialogState();

  static Future<PlayerModel?> open({
    required BuildContext context,
    String? initValue,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AddPlayerDialog(
          initValue: initValue,
        ),
      );
}

class _AddPlayerDialogState extends State<AddPlayerDialog> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNodeMafbank = FocusNode();
  final FocusNode _focusNodeFsm = FocusNode();
  final _controller = TextEditingController();
  final _controllerMafbank = TextEditingController();
  final _controllerFsm = TextEditingController();

  PlayerModel? _selectedPlayer;

  @override
  void initState() {
    _controller.text = widget.initValue ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNodeMafbank.dispose();
    _focusNodeFsm.dispose();
    _controller.dispose();
    _controllerFsm.dispose();
    _controllerMafbank.dispose();
    super.dispose();
  }

  void _onPlayerSelected(PlayerModel player) {
    _selectedPlayer = player;
    _controller.text = player.nickname;
    _controllerFsm.text = player.fsmNickaname ?? '';
    _controllerMafbank.text = player.mafbankNickname ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Container(
        width: 580,
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.locale.addPlayerDialogTitle,
                style: MyTheme.of(context).headerTextStyle,
              ),
              const SizedBox(height: 24),
              PlayerAutoComplete(
                hint: context.locale.nicknameHint,
                controller: _controller,
                focusNode: _focusNode,
                onSelected: _onPlayerSelected,
                onSubmit: () {
                  _focusNodeFsm.requestFocus();
                },
              ),
              const SizedBox(height: 8),
              PlayerAutoComplete(
                hint: context.locale.fsmNicknameHint,
                controller: _controllerFsm,
                focusNode: _focusNodeFsm,
                displayStringForOption: (m) => m.fsmNickaname ?? '',
                onSelected: _onPlayerSelected,
                onSubmit: () {
                  _focusNodeMafbank.requestFocus();
                },
              ),
              const SizedBox(height: 8),
              PlayerAutoComplete(
                hint: context.locale.mafbankNicknameHint,
                controller: _controllerMafbank,
                focusNode: _focusNodeMafbank,
                displayStringForOption: (m) => m.mafbankNickname ?? '',
                onSelected: _onPlayerSelected,
                onSubmit: onSubmit,
              ),
              const SizedBox(height: 24),
              CustomButton(text: context.locale.add, onTap: onSubmit),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    final player = _selectedPlayer?.copyWith(
          mafbankNickname: _controllerMafbank.text.isEmpty ? null : _controllerMafbank.text,
          fsmNickaname: _controllerFsm.text.isEmpty ? null : _controllerFsm.text,
        ) ??
        PlayerModel(
          id: 0,
          nickname: _controller.text,
          fsmNickaname: _controllerFsm.text.isEmpty ? null : _controllerFsm.text,
          mafbankNickname: _controllerMafbank.text.isEmpty ? null : _controllerMafbank.text,
        );

    Navigator.pop(context, player);
  }
}
