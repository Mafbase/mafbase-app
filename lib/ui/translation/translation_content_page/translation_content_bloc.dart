import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/data/sockets/tournament_content_socket.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_event.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';

class TranslationContentBloc extends Bloc<TranslationContentEvent, TranslationContentState> {
  final TranslationContentBlocParams params;
  late final _socket = TournamentContentSocket(
    table: params.table,
    tournamentId: params.tournamentId,
  );

  TranslationContentBloc(this.params, [BuildContext? context])
      : super(
          const TranslationContentState(),
        ) {
    on<TranslationContentEventStateReceived>(_onStateReceived);
    on<TranslationContentEventPageOpened>(_onPageOpened);
    _socket.stream.listen((event) {
      add(
        TranslationContentEvent.stateReceived(
          content: SeatingContent.fromBuffer(event),
        ),
      );
    });
  }

  void _onPageOpened(TranslationContentEventPageOpened event, Emitter emit) {
    _socket.connect();
  }

  void _onStateReceived(
    TranslationContentEventStateReceived event,
    Emitter emit,
  ) {
    final content = event.content;
    emit(
      TranslationContentState(
        roles: content.roles,
        statuses: content.status,
        images: content.images,
        nicknames: content.names,
      ),
    );
  }

  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }
}

class TranslationContentBlocParams {
  final int tournamentId;
  final int table;
  final String key;

  TranslationContentBlocParams({
    required this.tournamentId,
    required this.table,
    required this.key,
  });
}
