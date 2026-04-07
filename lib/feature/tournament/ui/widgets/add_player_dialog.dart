import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/utils.dart';

class AddPlayerDialog extends StatefulWidget {
  final String? initValue;
  final PlayerModel? player;

  const AddPlayerDialog({
    super.key,
    this.initValue,
    this.player,
  });

  @override
  State<AddPlayerDialog> createState() => _AddPlayerDialogState();

  static Future<PlayerModel?> open({
    required BuildContext context,
    String? initValue,
    PlayerModel? player,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AddPlayerDialog(
          initValue: initValue,
          player: player,
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
  List<PlayerModel> _nicknameSearchResults = [];
  bool _isNicknameSearching = false;
  String? _lastNicknameSearchedQuery;

  @override
  void initState() {
    if (widget.player != null) {
      final player = widget.player!;
      _controller.text = player.nickname;
      _controllerFsm.text = player.fsmNickaname ?? '';
      _controllerMafbank.text = player.mafbankNickname ?? '';
      _selectedPlayer = player;
      _lastNicknameSearchedQuery = player.nickname;
    } else {
      _controller.text = widget.initValue ?? '';
    }
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
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final loading = _isNicknameSearching ||
              (_controller.text.isNotEmpty && _controller.text != (_lastNicknameSearchedQuery ?? ''));

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
                    Row(
                      children: [
                        const SizedBox(width: 48),
                        Expanded(
                          child: Text(
                            context.locale.addPlayerDialogTitle,
                            textAlign: TextAlign.center,
                            style: MyTheme.of(context).headerTextStyle,
                          ),
                        ),
                        const CloseButton(),
                      ],
                    ),
                    const SizedBox(height: 24),
                    PlayerAutoComplete(
                      label: context.locale.nicknameHint,
                      controller: _controller,
                      focusNode: _focusNode,
                      onSelected: _onPlayerSelected,
                      onResultsChanged: (results) => _nicknameSearchResults = results,
                      onSearchStateChanged: (isLoading, query) {
                        setState(() {
                          _isNicknameSearching = isLoading;
                          _lastNicknameSearchedQuery = query;
                        });
                      },
                      onSubmit: () {
                        _focusNodeFsm.requestFocus();
                      },
                    ),
                    const SizedBox(height: 8),
                    PlayerAutoComplete(
                      label: context.locale.fsmNicknameHint,
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
                      label: context.locale.mafbankNicknameHint,
                      controller: _controllerMafbank,
                      focusNode: _focusNodeMafbank,
                      displayStringForOption: (m) => m.mafbankNickname ?? '',
                      onSelected: _onPlayerSelected,
                      onSubmit: onSubmit,
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: context.locale.add,
                      onTap: onSubmit,
                      isLoading: loading,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  void onSubmit() {
    final selectedPlayer = _selectedPlayer ?? _findExactMatch();
    final player = selectedPlayer?.copyWith(
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

  PlayerModel? _findExactMatch() {
    final lowerText = _controller.text.toLowerCase();
    return _nicknameSearchResults.where((p) => p.nickname.toLowerCase() == lowerText).firstOrNull;
  }
}
