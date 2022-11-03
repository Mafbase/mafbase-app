import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/utils.dart';

class AddPlayerDialog extends StatefulWidget {
  final List<PlayerModel> availablePlayers;

  const AddPlayerDialog({
    Key? key,
    required this.availablePlayers,
  }) : super(key: key);

  @override
  State<AddPlayerDialog> createState() => _AddPlayerDialogState();

  static Future<PlayerModel?> open({
    required BuildContext context,
    required List<PlayerModel> availablePlayers,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AddPlayerDialog(
          availablePlayers: availablePlayers,
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

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _controllerFsm.dispose();
    _controllerMafbank.dispose();
    super.dispose();
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.locale.addPlayerDialogTitle,
              style: MyTheme.of(context).headerTextStyle,
            ),
            const SizedBox(
              height: 100,
            ),
            CustomAutoComplete(
              hint: context.locale.nicknameHint,
              controller: _controller,
              displayStringForOption: (model) => model.nickname,
              focusNode: _focusNode,
              availablePlayers: widget.availablePlayers,
              onSelected: (player) {
                _controllerFsm.text = player.fsmNickaname ?? "";
                _controllerMafbank.text = player.mafbankNickname ?? "";
                _controller.text = player.nickname;
              },
              optionsBuilder: (text) {
                return widget.availablePlayers
                    .where(
                      (element) => element.nickname
                          .toLowerCase()
                          .contains(text.text.toLowerCase()),
                    )
                    .sortedBy<num>((element) => element.nickname.length);
              },
              onSubmit: () {
                _focusNodeFsm.requestFocus();
              },
            ),
            CustomAutoComplete(
              hint: context.locale.fsmNicknameHint,
              controller: _controllerFsm,
              displayStringForOption: (model) => model.fsmNickaname ?? "",
              focusNode: _focusNodeFsm,
              availablePlayers: widget.availablePlayers,
              onSelected: (player) {
                _controllerFsm.text = player.fsmNickaname ?? "";
                _controllerMafbank.text = player.mafbankNickname ?? "";
                _controller.text = player.nickname;
              },
              optionsBuilder: (text) {
                return widget.availablePlayers
                    .where((element) => element.fsmNickaname != null)
                    .where(
                      (element) => (element.fsmNickaname ?? "")
                          .toLowerCase()
                          .contains(text.text.toLowerCase()),
                    )
                    .sortedBy<num>((element) => element.nickname.length);
              },
              onSubmit: () {
                _focusNodeMafbank.requestFocus();
              },
            ),
            CustomAutoComplete(
              hint: context.locale.mafbankNicknameHint,
              controller: _controllerMafbank,
              displayStringForOption: (model) => model.mafbankNickname ?? "",
              focusNode: _focusNodeMafbank,
              availablePlayers: widget.availablePlayers,
              onSelected: (player) {
                _controllerFsm.text = player.fsmNickaname ?? "";
                _controllerMafbank.text = player.mafbankNickname ?? "";
                _controller.text = player.nickname;
              },
              optionsBuilder: (text) {
                return widget.availablePlayers
                    .where((element) => element.mafbankNickname != null)
                    .where(
                      (element) => (element.mafbankNickname ?? "")
                          .toLowerCase()
                          .contains(text.text.toLowerCase()),
                    )
                    .sortedBy<num>((element) => element.nickname.length);
              },
              onSubmit: onSubmit,
            ),
            const SizedBox(
              height: 100,
            ),
            CustomButton(text: context.locale.add, onTap: onSubmit),
          ],
        ),
      ),
    );
  }

  void onSubmit() {
    final player = widget.availablePlayers
            .firstWhereOrNull(
              (element) =>
                  element.nickname == _controller.text &&
                  (element.fsmNickaname == null ||
                      (element.fsmNickaname ?? "") == _controllerFsm.text) &&
                  (element.mafbankNickname == null ||
                      (element.mafbankNickname ?? "") ==
                          _controllerMafbank.text),
            )
            ?.copyWith(
              mafbankNickname: _controllerMafbank.text.isEmpty
                  ? null
                  : _controllerMafbank.text,
              fsmNickaname:
                  _controllerFsm.text.isEmpty ? null : _controllerFsm.text,
            ) ??
        PlayerModel(
          id: 0,
          nickname: _controller.text,
          fsmNickaname:
              _controllerFsm.text.isEmpty ? null : _controllerFsm.text,
          mafbankNickname:
              _controllerMafbank.text.isEmpty ? null : _controllerMafbank.text,
        );

    if (player.id == 0 &&
        widget.availablePlayers
            .any((element) => element.nickname == player.nickname)) {
      AppRouter.showErrorDialog(
        context,
        "Игрок с таким никнеймом уже существует",
      );
    } else {
      Navigator.pop(context, player);
    }
  }
}
