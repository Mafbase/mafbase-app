import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_effect.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_state.dart';

typedef _Emit = Emitter<SeatingPageDialogState>;

class SeatingPageDialogBloc
    extends Bloc<SeatingPageDialogEvent, SeatingPageDialogState>
    with EffectEmitter<SeatingPageDialogEffect, SeatingPageDialogState> {
  final PlayersRepository _playersRepository;

  SeatingPageDialogBloc(
    super.initialState,
    this._playersRepository, [
    BuildContext? context,
  ]) {
    on<SeatingPageDialogEventInit>(_init);
    on<SeatingPageDialogEventNewPlayer>(_newPlayer);
    on<SeatingPageDialogEventExistingPlayer>(_existingPlayer);
  }

  void _finishEdit(_Emit emit) {
    final notFound = state.notFound
        .where((element) => element != state.incorrectPlayer)
        .toList();

    if (notFound.isEmpty) {
      emitEffect(const SeatingPageDialogEffect.success());
    } else {
      emit(
        state.copyWith(
          loading: false,
          notFound: notFound,
          incorrectPlayer: notFound.firstOrNull,
        ),
      );
    }
  }

  Future<void> _existingPlayer(
    SeatingPageDialogEventExistingPlayer event,
    _Emit emit,
  ) async {
    emit(state.copyWith(loading: true));

    await _playersRepository.editPlayer(
      event.player.copyWith(
        fsmNickaname: state.incorrectPlayer,
      ),
    );

    _finishEdit(emit);
  }

  Future<void> _newPlayer(
    SeatingPageDialogEventNewPlayer event,
    _Emit emit,
  ) async {
    emit(state.copyWith(loading: true));

    await _playersRepository.createPlayer(
      PlayerModel(
        nickname: event.nickname,
        fsmNickaname: state.incorrectPlayer,
      ),
    );

    _finishEdit(emit);
  }

  Future<void> _init(
    SeatingPageDialogEventInit event,
    _Emit emit,
  ) async {
    final players = await _playersRepository.players;
    emit(
      state.copyWith(
        loading: false,
        players: players,
        incorrectPlayer: state.notFound.first,
      ),
    );
  }

}
