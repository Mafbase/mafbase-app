import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/data/sockets/tournament_content_socket.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_event.dart';

class TranslationControlBloc extends Bloc<TranslationControlEvent, TranslationContentState> {
  TournamentContentSocket? _socket;
  final TranslationRepository _repository;
  final TranslationContentBlocParams params;
  final List<StreamSubscription> toDispose = [];
  // Сокет может прислать контент, собранный до записи, поэтому выбор держится поверх него до ответа на запрос.
  ObsSceneMapping? _serverObsScenes;
  ObsSceneMapping? _pendingObsScenes;

  TranslationControlBloc({
    required this.params,
    required TranslationRepository repository,
  })  : _repository = repository,
        super(
          const TranslationContentState(),
        ) {
    on<TranslationControlEventStateReceived>(_onStateReceived);
    on<TranslationControlEventChangeRole>(_onRoleChanged);
    on<TranslationControlEventChangeStatus>(_onStatusChanged);
    on<TranslationControlEventSelectGame>(_onGameSelected);
    on<TranslationControlEventChangeBroadcastPhase>(_onBroadcastPhaseChanged);
    on<TranslationControlEventChangeObsScenes>(_onObsScenesChanged);
    on<TranslationControlEventPageOpened>(_onPageOpened);
  }

  void _onPageOpened(
    TranslationControlEventPageOpened event,
    Emitter emit,
  ) {
    for (var element in toDispose) {
      element.cancel();
    }

    _socket?.dispose();
    final socket = _socket = TournamentContentSocket(
      tournamentId: params.tournamentId,
      table: params.table,
    )..connect();

    toDispose.add(
      socket.stream.listen((event) {
        add(
          TranslationControlEvent.stateReceived(
            event: SeatingContent.fromBuffer(event),
          ),
        );
      }),
    );
  }

  Future<dynamic> _onGameSelected(TranslationControlEventSelectGame event, Emitter emit) {
    return _repository.selectGame(
      gameIndex: event.gameIndex,
      table: params.table,
      tournamentId: params.tournamentId,
      key: params.key,
    );
  }

  Future<dynamic> _onStatusChanged(TranslationControlEventChangeStatus event, Emitter emit) {
    return _repository.changeStatus(
      playerIndex: event.index,
      status: event.status,
      table: params.table,
      tournamentId: params.tournamentId,
      key: params.key,
    );
  }

  Future<dynamic> _onRoleChanged(TranslationControlEventChangeRole event, Emitter emit) {
    return _repository.changeRole(
      playerIndex: event.index,
      role: event.role,
      table: params.table,
      tournamentId: params.tournamentId,
      key: params.key,
    );
  }

  Future<dynamic> _onBroadcastPhaseChanged(TranslationControlEventChangeBroadcastPhase event, Emitter emit) {
    return _repository.changeBroadcastPhase(
      phase: event.phase,
      table: params.table,
      tournamentId: params.tournamentId,
      key: params.key,
    );
  }

  Future<void> _onObsScenesChanged(
    TranslationControlEventChangeObsScenes event,
    Emitter<TranslationContentState> emit,
  ) async {
    _pendingObsScenes = event.mapping;
    emit(state.copyWith(obsScenes: event.mapping));
    try {
      await _repository.changeObsScenes(
        mapping: event.mapping,
        table: params.table,
        tournamentId: params.tournamentId,
        key: params.key,
      );
      if (identical(_pendingObsScenes, event.mapping)) {
        _pendingObsScenes = null;
        _serverObsScenes = event.mapping;
        emit(state.copyWith(obsScenes: event.mapping));
      }
    } catch (_) {
      if (identical(_pendingObsScenes, event.mapping)) {
        _pendingObsScenes = null;
        emit(state.copyWith(obsScenes: _serverObsScenes));
      }
      rethrow;
    }
  }

  void _onStateReceived(TranslationControlEventStateReceived event, Emitter emit) {
    final content = event.event;
    _serverObsScenes = content.hasObsScenes() ? content.obsScenes : null;
    emit(
      TranslationContentState(
        roles: content.roles,
        statuses: content.status,
        images: content.images,
        nicknames: content.names,
        game: content.game,
        totalGames: content.totalGames,
        broadcastPhase: content.broadcastPhase,
        obsScenes: _pendingObsScenes ?? _serverObsScenes,
        obs: content.hasObs() ? content.obs : null,
      ),
    );
  }

  @override
  Future<void> close() {
    for (final e in toDispose) {
      e.cancel();
    }
    _socket?.dispose();
    return super.close();
  }
}
