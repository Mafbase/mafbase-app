import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_player_dialog.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/club_translation_control_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/club_translation_control_event.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_event.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/widgets/translation_control_empty_slot.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/widgets/translation_control_game_selector.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/widgets/translation_control_phase_selector.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/widgets/translation_control_player_card.dart';
import 'package:seating_generator_web/utils.dart';

@RoutePage()
class TranslationControlPage extends StatefulWidget {
  final int tournamentId;
  final int clubId;
  final int table;
  final String translationKey;

  const TranslationControlPage({
    super.key,
    @QueryParam('tournamentId') this.tournamentId = 0,
    @QueryParam('clubId') this.clubId = 0,
    @QueryParam('table') this.table = 0,
    @QueryParam('key') this.translationKey = '',
  });

  bool get isClub => clubId > 0;

  @override
  State<TranslationControlPage> createState() => _TranslationControlPageState();
}

class _TranslationControlPageState extends State<TranslationControlPage> with WidgetsBindingObserver {
  TranslationControlBloc? _tournamentBloc;
  ClubTranslationControlBloc? _clubBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.isClub) {
      _clubBloc = ClubTranslationControlBloc(
        params: ClubTranslationControlBlocParams(
          clubId: widget.clubId,
          table: widget.table,
          key: widget.translationKey,
        ),
        repository: RepositoryFactory.of(context).clubTranslationRepository,
      )..add(const ClubTranslationControlEvent.pageOpened());
    } else {
      _tournamentBloc = TranslationControlBloc(
        params: TranslationContentBlocParams(
          tournamentId: widget.tournamentId,
          table: widget.table,
          key: widget.translationKey,
        ),
        repository: RepositoryFactory.of(context).translationRepository,
      )..add(const TranslationControlEvent.pageOpened());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tournamentBloc?.close();
    _clubBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isClub) {
      return BlocProvider<ClubTranslationControlBloc>.value(
        value: _clubBloc!,
        child: const _ClubTranslationControlContent(),
      );
    }
    return BlocProvider<TranslationControlBloc>.value(
      value: _tournamentBloc!,
      child: const TranslationControlContent(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _tournamentBloc?.add(const TranslationControlEvent.pageOpened());
      _clubBloc?.add(const ClubTranslationControlEvent.pageOpened());
    }
  }
}

class TranslationControlContent extends StatelessWidget {
  const TranslationControlContent({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<TranslationControlBloc, TranslationContentState>(
    builder: (context, state) {
      final theme = context.theme;
      return Scaffold(
        backgroundColor: theme.background1,
        appBar: AppBar(
          backgroundColor: theme.background2,
          elevation: 0,
          title: Text(
            context.locale.translationControlTitle,
            style: theme.defaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            if (state.totalGames > 0)
              TranslationControlGameSelector(
                game: state.game,
                totalGames: state.totalGames,
                onChanged: (index) {
                  context.read<TranslationControlBloc>().add(TranslationControlEvent.selectGame(gameIndex: index));
                },
                onClose: kIsWeb ? null : context.backOrGoToDefault(),
              ),
            if (state.isNotEmpty())
              TranslationControlPhaseSelector(
                phase: state.broadcastPhase,
                onChanged: (phase) {
                  context.read<TranslationControlBloc>().add(
                    TranslationControlEvent.changeBroadcastPhase(phase: phase),
                  );
                },
              ),
            Expanded(
              child: state.isNotEmpty()
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return TranslationControlPlayerCard(
                          index: index,
                          nickname: state.nicknames![index],
                          imageUrl: state.images![index],
                          role: state.roles![index],
                          status: state.statuses![index],
                          onRoleChanged: (role) {
                            context.read<TranslationControlBloc>().add(
                              TranslationControlEvent.changeRole(index: index, role: role),
                            );
                          },
                          onStatusChanged: (status) {
                            context.read<TranslationControlBloc>().add(
                              TranslationControlEvent.changeStatus(index: index, status: status),
                            );
                          },
                        );
                      },
                    )
                  : Center(child: Text(context.locale.translationControlEmpty, style: theme.hintTextStyle)),
            ),
          ],
        ),
      );
    },
  );
}

class _ClubTranslationControlContent extends StatefulWidget {
  const _ClubTranslationControlContent();

  @override
  State<_ClubTranslationControlContent> createState() => _ClubTranslationControlContentState();
}

class _ClubTranslationControlContentState extends State<_ClubTranslationControlContent> {
  late final List<TextEditingController> _controllers = List.generate(10, (_) => TextEditingController());
  late final List<FocusNode> _focusNodes = List.generate(10, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  bool _isSlotEditing(TranslationContentState state, int index) {
    if (!state.isNotEmpty()) return true;
    if (state.editingSlots.contains(index)) return true;
    return state.nicknames![index].isEmpty;
  }

  void _focusNextEmptySlot(TranslationContentState state, int fromIndex) {
    for (var i = fromIndex + 1; i < 10; i++) {
      if (_isSlotEditing(state, i)) {
        _focusNodes[i].requestFocus();
        return;
      }
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> _handleNewPlayer({required int index, required String initValue}) async {
    final bloc = context.read<ClubTranslationControlBloc>();
    final repos = RepositoryFactory.of(context);
    final state = bloc.state;

    final newPlayer = await AddPlayerDialog.open(context: context, initValue: initValue);
    if (newPlayer == null || !mounted) return;

    final id = await CreatePlayerInteractor(repos.playersRepository).run(playerModel: newPlayer);
    if (!mounted) return;

    bloc.add(ClubTranslationControlEvent.changePlayer(index: index, playerId: id));
    _controllers[index].clear();
    _focusNextEmptySlot(state, index);
  }

  Future<void> _handlePhotoEdit({required int index, required String nickname}) async {
    final repos = RepositoryFactory.of(context);
    final locale = context.locale;
    final messenger = ScaffoldMessenger.of(context);

    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) return;

    final bytes = Uint8List.fromList(await picked.readAsBytes());
    if (!mounted) return;

    final playerId = await _findPlayerIdByNickname(repos.playersRepository, nickname);
    if (playerId == null) {
      if (!mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(locale.translationControlPhotoNotFound)));
      return;
    }

    await repos.playersRepository.addPhoto(playerId, bytes, picked.name);
    if (!mounted) return;
    messenger.showSnackBar(SnackBar(content: Text(locale.translationControlPhotoUpdated)));
  }

  Future<int?> _findPlayerIdByNickname(PlayersRepository repo, String nickname) async {
    final results = await repo.searchPlayers(nickname, limit: 10);
    final exact = results.where((p) => p.nickname == nickname).firstOrNull;
    return exact == null || exact.id == PlayerModel.undefinedId ? null : exact.id;
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ClubTranslationControlBloc, TranslationContentState>(
    builder: (context, state) {
      final theme = context.theme;
      return Scaffold(
        backgroundColor: theme.background1,
        appBar: AppBar(
          backgroundColor: theme.background2,
          elevation: 0,
          title: Text(
            context.locale.translationControlTitle,
            style: theme.defaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            TranslationControlPhaseSelector(
              phase: state.broadcastPhase,
              onChanged: (phase) {
                context.read<ClubTranslationControlBloc>().add(
                  ClubTranslationControlEvent.changeBroadcastPhase(phase: phase),
                );
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: 10,
                itemBuilder: (context, index) {
                  final editing = _isSlotEditing(state, index);
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                    child: editing
                        ? TranslationControlEmptySlot(
                            key: ValueKey('empty-$index'),
                            index: index,
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            onPlayerSelected: (player) {
                              context.read<ClubTranslationControlBloc>().add(
                                ClubTranslationControlEvent.changePlayer(index: index, playerId: player.id),
                              );
                              _controllers[index].clear();
                              _focusNextEmptySlot(state, index);
                            },
                            onNewPlayer: ({required String initValue}) =>
                                _handleNewPlayer(index: index, initValue: initValue),
                          )
                        : TranslationControlPlayerCard(
                            key: ValueKey('filled-$index'),
                            index: index,
                            nickname: state.nicknames![index],
                            imageUrl: state.images![index],
                            role: state.roles![index],
                            status: state.statuses![index],
                            onRoleChanged: (role) {
                              context.read<ClubTranslationControlBloc>().add(
                                ClubTranslationControlEvent.changeRole(index: index, role: role),
                              );
                            },
                            onStatusChanged: (status) {
                              context.read<ClubTranslationControlBloc>().add(
                                ClubTranslationControlEvent.changeStatus(index: index, status: status),
                              );
                            },
                            onPlayerSwap: () {
                              context.read<ClubTranslationControlBloc>().add(
                                ClubTranslationControlEvent.startEditingPlayer(index: index),
                              );
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _focusNodes[index].requestFocus();
                              });
                            },
                            onPhotoTap: () => _handlePhotoEdit(index: index, nickname: state.nicknames![index]),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
