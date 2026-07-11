import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_players_staged_row.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

/// Единый диалог батч-добавления участников на турнир (Вариант A «Поиск + накопление»).
///
/// Сверху — один [PlayerAutoComplete] с автофокусом. Выбранные игроки копятся в
/// [_staged], поле после выбора очищается и фокус возвращается — чтобы вводить
/// следующего, не закрывая диалог. Снизу — кнопка батч-отправки.
///
/// Отправка выполняется внутри диалога с прогрессом ([LoadingOverlayWidget]).
/// [open] возвращает `true`, если хотя бы один участник был успешно добавлен —
/// вызывающий код должен один раз перезагрузить список участников.
class AddPlayersDialog extends StatefulWidget {
  final int tournamentId;
  final List<PlayerModel> existingPlayers;

  const AddPlayersDialog({
    super.key,
    required this.tournamentId,
    required this.existingPlayers,
  });

  static Future<bool> open({
    required BuildContext context,
    required int tournamentId,
    required List<PlayerModel> existingPlayers,
  }) =>
      showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AddPlayersDialog(
          tournamentId: tournamentId,
          existingPlayers: existingPlayers,
        ),
      ).then((value) => value ?? false);

  @override
  State<AddPlayersDialog> createState() => _AddPlayersDialogState();
}

class _AddPlayersDialogState extends State<AddPlayersDialog> {
  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  final List<PlayerModel> _staged = [];

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _searchFocus.requestFocus());
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  bool _isDuplicate(PlayerModel player) {
    bool sameAsNew(PlayerModel other) =>
        other.id == PlayerModel.undefinedId && other.nickname.toLowerCase() == player.nickname.toLowerCase();

    if (player.id == PlayerModel.undefinedId) {
      return _staged.any(sameAsNew) || widget.existingPlayers.any(sameAsNew);
    }

    return _staged.any((p) => p.id == player.id) || widget.existingPlayers.any((p) => p.id == player.id);
  }

  void _addPlayer(PlayerModel player) {
    if (_isDuplicate(player)) {
      _showTransientMessage(context.locale.addPlayersAlreadyAdded);
    } else {
      setState(() => _staged.add(player));
    }
    _searchController.clear();
    _searchFocus.requestFocus();
  }

  void _showTransientMessage(String message) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
      );
  }

  void _updateStagedAt(int index, PlayerModel player) {
    setState(() => _staged[index] = player);
  }

  void _removeStagedAt(int index) {
    setState(() => _staged.removeAt(index));
  }

  Future<void> _submit() async {
    if (_staged.isEmpty || _isSubmitting) return;

    setState(() => _isSubmitting = true);

    // Эндпоинт атомарен (одна транзакция): либо добавлены все, либо никто.
    // При ошибке оставляем всех в _staged — ничего не потеряно.
    var addedAny = false;
    try {
      final addedCount = await RepositoryFactory.of(context).playersRepository.addPlayers(
            widget.tournamentId,
            List<PlayerModel>.of(_staged),
          );
      addedAny = addedCount > 0;
    } catch (_) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        _showTransientMessage(context.locale.addPlayersError);
      }
      return;
    }

    if (!mounted) return;
    Navigator.pop(context, addedAny);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final size = MediaQuery.sizeOf(context);

    final content = Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 40, horizontal: isMobile ? 20 : 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(context),
          const SizedBox(height: 24),
          PlayerAutoComplete(
            label: context.locale.nicknameHint,
            controller: _searchController,
            focusNode: _searchFocus,
            onSelected: _addPlayer,
            onNewPlayer: ({required String initValue}) {
              if (initValue.trim().isEmpty) return;
              _addPlayer(PlayerModel(nickname: initValue.trim()));
            },
          ),
          const SizedBox(height: 16),
          Text(
            context.locale.addPlayersSelected(_staged.length),
            style: MyTheme.of(context).hintTextStyle,
          ),
          const SizedBox(height: 8),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < _staged.length; i++)
                    AddPlayersStagedRow(
                      key: ValueKey('${_staged[i].id}_${_staged[i].nickname}_$i'),
                      player: _staged[i],
                      onChanged: (updated) => _updateStagedAt(i, updated),
                      onRemove: () => _removeStagedAt(i),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: context.locale.addPlayersSubmit(_staged.length),
            onTap: _submit,
            disabled: _staged.isEmpty,
            isLoading: _isSubmitting,
          ),
        ],
      ),
    );

    return PopScope(
      canPop: !_isSubmitting,
      child: CustomDialog(
        child: Stack(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? size.width : 580,
                maxHeight: size.height * (isMobile ? 0.9 : 0.8),
              ),
              child: content,
            ),
            if (_isSubmitting)
              const Positioned.fill(
                child: LoadingOverlayWidget(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) => Row(
        children: [
          const SizedBox(width: 48),
          Expanded(
            child: Text(
              context.locale.addPlayersDialogTitle,
              textAlign: TextAlign.center,
              style: MyTheme.of(context).headerTextStyle,
            ),
          ),
          const CloseButton(),
        ],
      );
}
