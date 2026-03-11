import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/data/sockets/tournament_content_socket.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_event.dart';

class TranslationControlBloc
    extends Bloc<TranslationControlEvent, TranslationContentState> {
  TournamentContentSocket? _socket;
  final TranslationRepository _repository;
  final TranslationContentBlocParams params;
  final List<StreamSubscription> toDispose = [];

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

  _onGameSelected(TranslationControlEventSelectGame event, Emitter emit) {
    return _repository.selectGame(
      gameIndex: event.gameIndex,
      table: params.table,
      tournamentId: params.tournamentId,
      key: params.key,
    );
  }

  _onStatusChanged(TranslationControlEventChangeStatus event, Emitter emit) {
    return _repository.changeStatus(
      playerIndex: event.index,
      status: event.status,
      table: params.table,
      tournamentId: params.tournamentId,
      key: params.key,
    );
  }

  _onRoleChanged(TranslationControlEventChangeRole event, Emitter emit) {
    return _repository.changeRole(
      playerIndex: event.index,
      role: event.role,
      table: params.table,
      tournamentId: params.tournamentId,
      key: params.key,
    );
  }

  _onStateReceived(TranslationControlEventStateReceived event, Emitter emit) {
    emit(
      TranslationContentState(
        roles: event.event.roles,
        statuses: event.event.status,
        images: event.event.images,
        nicknames: event.event.names,
        game: event.event.game,
        totalGames: event.event.totalGames,
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
