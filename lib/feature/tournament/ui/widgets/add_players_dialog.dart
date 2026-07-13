import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_players_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_players_effect.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_players_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_players_staged_row.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_players_state.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

/// Единый диалог батч-добавления участников на турнир (Вариант A «Поиск + накопление»).
///
/// Бизнес-логика (дедуп, создание новых игроков, батч-отправка) инкапсулирована в
/// [AddPlayersBloc]. Диалог отвечает только за UI: поле поиска с автофокусом, список
/// staged-участников, индикатор загрузки и переходы по [AddPlayersEffect].
///
/// [open] возвращает `true`, если хотя бы один участник был успешно добавлен —
/// вызывающий код должен один раз перезагрузить список участников.
class AddPlayersDialog extends StatefulWidget {
  const AddPlayersDialog({super.key});

  static Future<bool> open({
    required BuildContext context,
    required int tournamentId,
    required List<PlayerModel> existingPlayers,
  }) =>
      showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => BlocProvider(
          create: (context) => AddPlayersBloc(
            playersRepository: RepositoryFactory.of(context).playersRepository,
            tournamentId: tournamentId,
            existingPlayers: existingPlayers,
          ),
          child: const AddPlayersDialog(),
        ),
      ).then((value) => value ?? false);

  @override
  State<AddPlayersDialog> createState() => _AddPlayersDialogState();
}

class _AddPlayersDialogState extends State<AddPlayersDialog>
    with EffectListener<AddPlayersEffect, AddPlayersState, AddPlayersBloc, AddPlayersDialog> {
  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void registerEffectHandlers(on) {
    on<AddPlayersEffectShowDuplicateWarning>((_) => _showTransientMessage(context.locale.addPlayersAlreadyAdded));
    on<AddPlayersEffectSubmitCompleted>((effect) => Navigator.pop(context, effect.addedAny));
  }

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

  void _addPlayer(PlayerModel player) {
    context.read<AddPlayersBloc>().add(AddPlayersEvent.playerAdded(player: player));
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

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final size = MediaQuery.sizeOf(context);

    return BlocBuilder<AddPlayersBloc, AddPlayersState>(
      builder: (context, state) {
        final bloc = context.read<AddPlayersBloc>();

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
                excludeIds: bloc.excludedIds,
              ),
              const SizedBox(height: 16),
              Text(
                context.locale.addPlayersSelected(state.staged.length),
                style: MyTheme.of(context).hintTextStyle,
              ),
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < state.staged.length; i++)
                        AddPlayersStagedRow(
                          key: ValueKey('${state.staged[i].id}_${state.staged[i].nickname}_$i'),
                          player: state.staged[i],
                          onChanged: (updated) => bloc.add(AddPlayersEvent.playerUpdated(index: i, player: updated)),
                          onRemove: () => bloc.add(AddPlayersEvent.playerRemoved(index: i)),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: context.locale.addPlayersSubmit(state.staged.length),
                onTap: () => bloc.add(const AddPlayersEvent.submitted()),
                disabled: state.staged.isEmpty,
                isLoading: state.isSubmitting,
              ),
            ],
          ),
        );

        return PopScope(
          canPop: !state.isSubmitting,
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
                if (state.isSubmitting)
                  const Positioned.fill(
                    child: LoadingOverlayWidget(),
                  ),
              ],
            ),
          ),
        );
      },
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
