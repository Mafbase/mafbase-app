import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/profile_page/widgets/player_avatar_widget.dart';
import 'package:seating_generator_web/utils.dart';

/// Одна строка списка выбранных игроков в [AddPlayersDialog].
///
/// По умолчанию свёрнута: аватар + основной ник + бейдж «новый» (для id == -1) +
/// кнопки редактирования и удаления. По нажатию на «карандаш» раскрывается в три
/// редактируемых поля (основной ник / ФСМ / Mafbank) — набор полей переиспользует
/// связку из одиночного `AddPlayerDialog`.
class AddPlayersStagedRow extends StatefulWidget {
  final PlayerModel player;
  final ValueChanged<PlayerModel> onChanged;
  final VoidCallback onRemove;

  const AddPlayersStagedRow({super.key, required this.player, required this.onChanged, required this.onRemove});

  @override
  State<AddPlayersStagedRow> createState() => _AddPlayersStagedRowState();
}

class _AddPlayersStagedRowState extends State<AddPlayersStagedRow> {
  bool _expanded = false;

  late final TextEditingController _nicknameController = TextEditingController(text: widget.player.nickname);
  late final TextEditingController _fsmController = TextEditingController(text: widget.player.fsmNickaname ?? '');
  late final TextEditingController _mafbankController = TextEditingController(
    text: widget.player.mafbankNickname ?? '',
  );

  final FocusNode _nicknameFocus = FocusNode();
  final FocusNode _fsmFocus = FocusNode();
  final FocusNode _mafbankFocus = FocusNode();

  bool get _isNew => widget.player.id == PlayerModel.undefinedId;

  @override
  void dispose() {
    _nicknameController.dispose();
    _fsmController.dispose();
    _mafbankController.dispose();
    _nicknameFocus.dispose();
    _fsmFocus.dispose();
    _mafbankFocus.dispose();
    super.dispose();
  }

  void _applyEdits() {
    widget.onChanged(
      widget.player.copyWith(
        nickname: _nicknameController.text.trim().isEmpty ? widget.player.nickname : _nicknameController.text.trim(),
        fsmNickaname: _fsmController.text.trim().isEmpty ? null : _fsmController.text.trim(),
        mafbankNickname: _mafbankController.text.trim().isEmpty ? null : _mafbankController.text.trim(),
      ),
    );
  }

  void _toggleExpanded() {
    if (_expanded) {
      _applyEdits();
    }
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.background2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              PlayerAvatarWidget(player: widget.player, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Text(widget.player.nickname, style: theme.fieldTextStyle, overflow: TextOverflow.ellipsis),
              ),
              if (_isNew) ...[_NewBadge(text: context.locale.addPlayersNewBadge), const SizedBox(width: 8)],
              IconButton(
                tooltip: context.locale.addPlayersEditTooltip,
                onPressed: _toggleExpanded,
                icon: Icon(_expanded ? Icons.expand_less : Icons.edit_outlined, color: theme.darkGreyColor, size: 20),
              ),
              IconButton(
                onPressed: widget.onRemove,
                icon: Icon(Icons.close, color: theme.redColor, size: 20),
              ),
            ],
          ),
          if (_expanded) ...[
            const SizedBox(height: 8),
            PlayerAutoComplete(
              label: context.locale.nicknameHint,
              controller: _nicknameController,
              focusNode: _nicknameFocus,
              onSelected: (selectedPlayer) {
                _fsmController.text = selectedPlayer.fsmNickaname ?? '';
                _mafbankController.text = selectedPlayer.mafbankNickname ?? '';
                widget.onChanged(selectedPlayer);
                setState(() => _expanded = false);
              },
              openDirection: OptionsViewOpenDirection.down,
              onSubmit: () => _fsmFocus.requestFocus(),
            ),
            const SizedBox(height: 8),
            PlayerAutoComplete(
              label: context.locale.fsmNicknameHint,
              controller: _fsmController,
              focusNode: _fsmFocus,
              displayStringForOption: (m) => m.fsmNickaname ?? '',
              onSelected: (_) {},
              onSubmit: () => _mafbankFocus.requestFocus(),
            ),
            const SizedBox(height: 8),
            PlayerAutoComplete(
              label: context.locale.mafbankNicknameHint,
              controller: _mafbankController,
              focusNode: _mafbankFocus,
              displayStringForOption: (m) => m.mafbankNickname ?? '',
              onSelected: (_) {},
              onSubmit: _toggleExpanded,
            ),
          ],
        ],
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  final String text;

  const _NewBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: theme.greenForCard.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: theme.hintTextStyle.copyWith(color: theme.greenForCard, fontWeight: FontWeight.w600),
      ),
    );
  }
}
