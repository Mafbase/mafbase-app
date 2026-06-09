import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/data/sockets/club_content_socket.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/domain/repositories/club_translation_repository.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/photo_theme_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/club_translation_control_event.dart';

class ClubTranslationControlBlocParams {
  final int clubId;
  final int table;
  final String key;

  ClubTranslationControlBlocParams({required this.clubId, required this.table, required this.key});
}

class ClubTranslationControlBloc extends Bloc<ClubTranslationControlEvent, TranslationContentState> {
  final ClubTranslationRepository _repository;
  final ClubRepository _clubRepository;
  final PhotoThemeRepository _photoThemeRepository;
  final ClubTranslationControlBlocParams params;
  final List<StreamSubscription> _subscriptions = [];
  ClubContentSocket? _socket;

  ClubTranslationControlBloc({
    required this.params,
    required ClubTranslationRepository repository,
    required ClubRepository clubRepository,
    required PhotoThemeRepository photoThemeRepository,
  })  : _repository = repository,
        _clubRepository = clubRepository,
        _photoThemeRepository = photoThemeRepository,
        super(const TranslationContentState()) {
    on<ClubTranslationControlEventPageOpened>(_onPageOpened);
    on<ClubTranslationControlEventStateReceived>(_onStateReceived);
    on<ClubTranslationControlEventChangeRole>(_onChangeRole);
    on<ClubTranslationControlEventChangeStatus>(_onChangeStatus);
    on<ClubTranslationControlEventChangeBroadcastPhase>(_onChangeBroadcastPhase);
    on<ClubTranslationControlEventChangePlayer>(_onChangePlayer);
    on<ClubTranslationControlEventStartEditingPlayer>(_onStartEditingPlayer);
    on<ClubTranslationControlEventSetActivePhotoTheme>(_onSetActivePhotoTheme);
  }

  Future<void> _onPageOpened(
    ClubTranslationControlEventPageOpened event,
    Emitter<TranslationContentState> emit,
  ) async {
    for (final element in _subscriptions) {
      element.cancel();
    }
    _subscriptions.clear();

    _socket?.dispose();
    final socket = _socket = ClubContentSocket(clubId: params.clubId, table: params.table)..connect();

    _subscriptions.add(
      socket.stream.listen((bytes) {
        add(ClubTranslationControlEvent.stateReceived(content: ClubSeatingContent.fromBuffer(bytes)));
      }),
    );

    await Future.wait([
      _clubRepository
          .getClub(id: params.clubId)
          .then((club) => emit(state.copyWith(activePhotoThemeId: club.photoThemeId)))
          .onError((_, __) {}),
      _photoThemeRepository
          .getThemes()
          .then((themes) => emit(state.copyWith(availableThemes: themes)))
          .onError((_, __) {}),
    ]);
  }

  void _onStateReceived(ClubTranslationControlEventStateReceived event, Emitter<TranslationContentState> emit) {
    final content = event.content;
    final nicknames = content.names;
    // Preserve editingSlots for filled slots where the swap is still in progress.
    // Remove a slot from editingSlots only when its nickname changes (player was successfully swapped).
    final prevNicknames = state.nicknames;
    final editingSlots = state.editingSlots.where((i) {
      if (i >= nicknames.length) return false;
      if (prevNicknames != null && i < prevNicknames.length && prevNicknames[i] != nicknames[i]) return false;
      return true;
    }).toSet();
    emit(
      state.copyWith(
        roles: content.roles,
        statuses: content.status,
        images: content.images,
        nicknames: nicknames,
        broadcastPhase: content.broadcastPhase,
        editingSlots: editingSlots,
      ),
    );
  }

  Future<void> _onChangeRole(ClubTranslationControlEventChangeRole event, Emitter<TranslationContentState> emit) {
    return _repository.changeRole(
      playerIndex: event.index,
      role: event.role,
      clubId: params.clubId,
      table: params.table,
      key: params.key,
    );
  }

  Future<void> _onChangeStatus(ClubTranslationControlEventChangeStatus event, Emitter<TranslationContentState> emit) {
    return _repository.changeStatus(
      playerIndex: event.index,
      status: event.status,
      clubId: params.clubId,
      table: params.table,
      key: params.key,
    );
  }

  Future<void> _onChangeBroadcastPhase(
    ClubTranslationControlEventChangeBroadcastPhase event,
    Emitter<TranslationContentState> emit,
  ) {
    return _repository.changeBroadcastPhase(
      phase: event.phase,
      clubId: params.clubId,
      table: params.table,
      key: params.key,
    );
  }

  Future<void> _onChangePlayer(ClubTranslationControlEventChangePlayer event, Emitter<TranslationContentState> emit) {
    return _repository.changePlayer(
      playerIndex: event.index,
      playerId: event.playerId,
      clubId: params.clubId,
      table: params.table,
      key: params.key,
    );
  }

  void _onStartEditingPlayer(
    ClubTranslationControlEventStartEditingPlayer event,
    Emitter<TranslationContentState> emit,
  ) {
    emit(state.copyWith(editingSlots: {...state.editingSlots, event.index}));
  }

  Future<void> _onSetActivePhotoTheme(
    ClubTranslationControlEventSetActivePhotoTheme event,
    Emitter<TranslationContentState> emit,
  ) async {
    await _photoThemeRepository.setClubPhotoTheme(params.clubId, event.themeId);
    emit(state.copyWith(activePhotoThemeId: event.themeId));
  }

  @override
  Future<void> close() {
    for (final s in _subscriptions) {
      s.cancel();
    }
    _socket?.dispose();
    return super.close();
  }
}
