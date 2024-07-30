import 'package:flutter/cupertino.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/add_separation_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_separation_interactor.dart';
import 'package:seating_generator_web/domain/interactors/generate_final_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_separations_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_players_interactor.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_effect.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_router.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';

class SeatingPageBloc extends CustomBloc<SeatingPageEvent, SeatingPageState>
    with EffectEmitter<SeatingPageEffect, SeatingPageState> {
  late int tournamentId;
  final GetSeparationInteractor _getSeparationInteractor = getIt();
  final GetTournamentsPlayersInteractor _getTournamentsPlayersInteractor =
      getIt();
  final AddSeparationInteractor _addSeparationInteractor = getIt();
  final DeleteSeparationInteractor _deleteSeparationInteractor = getIt();
  final CreateSeatingInteractor _createSeatingInteractor = getIt();
  final GetSeatingInteractor _getSeatingInteractor = getIt();
  final GenerateFinalSeatingInteractor _generateFinalSeatingInteractor =
      getIt();
  final TournamentEditRepository _tournamentEditRepository = getIt();
  late final SeatingPageRouter router = getIt(param1: context);

  SeatingPageBloc([BuildContext? context])
      : super(const SeatingPageState(), context) {
    on<SeatingPageEventPageOpened>(_onPageOpened);
    on<SeatingPageEventDeletePair>(_onDeletePair);
    on<SeatingPageEventAddPair>(_onAddPair);
    on<SeatingPageEventFsmSeatingTapped>(_onFsm);
    on<SeatingPageEventCreateSeating>(_onCreateSeating);
    on<SeatingPageEventGameEditing>(_onOpenGameEditing);
    on<SeatingPageEventCreateFinalSeating>(_onGenerateFinalSeating);
    on<SeatingPageEventCreateSwissGame>(_onSwissGameCreate);
    on<SeatingPageEventAutoFsmSeating>(_autoFsmSeating);
  }

  Future<void> _autoFsmSeating(
    SeatingPageEventAutoFsmSeating event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final notFound = await _tournamentEditRepository.getGomafiaSeating(
      tournamentId: tournamentId,
      gomafiaId: event.gomafiaId,
    );

    if (notFound.isEmpty) {
      add(SeatingPageEvent.pageOpened(tournamentId: tournamentId));
      return;
    }

    emitEffect(SeatingPageEffect.fixPlayers(notFound, event.gomafiaId));
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onSwissGameCreate(
    SeatingPageEventCreateSwissGame event,
    Emitter emit,
  ) async {
    await _tournamentEditRepository.generateSwissGame(
      tournamentId: tournamentId,
      game: event.game,
    );

    return _updateSeating(emit);
  }

  _onGenerateFinalSeating(
    SeatingPageEventCreateFinalSeating event,
    Emitter emit,
  ) async {
    await _generateFinalSeatingInteractor(tournamentId: tournamentId);
    await _updateSeating(emit);
  }

  _onOpenGameEditing(SeatingPageEventGameEditing event, Emitter emit) {
    router
        .openGameEditing(
          gameId: event.gameId,
          tournamentId: tournamentId,
        )
        .then(
          (value) => add(
            SeatingPageEvent.pageOpened(tournamentId: tournamentId),
          ),
        );
  }

  _updateSeating(Emitter emit) async {
    final seating = await _getSeatingInteractor.run(tournamentId: tournamentId);
    emit(state.copyWith(isLoading: false, games: seating));
  }

  _onCreateSeating(
    SeatingPageEventCreateSeating event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _createSeatingInteractor.run(tournamentId: tournamentId);
    await _updateSeating(emit);
  }

  _onFsm(SeatingPageEventFsmSeatingTapped event, Emitter emit) {
    router.openFsmSeatingPage(id: tournamentId);
  }

  _onAddPair(SeatingPageEventAddPair event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    final players = await _getTournamentsPlayersInteractor.run(
      tournamentId: tournamentId,
    );
    final newPair =
        await router.openSeparationDialog(availablePlayers: players);
    if (newPair != null) {
      await _addSeparationInteractor.run(
        first: newPair.first,
        second: newPair.second,
        tournamentId: tournamentId,
      );
      final newPairs = await _getSeparationInteractor.run(
        tournamentId: tournamentId,
      );
      emit(state.copyWith(cannotMeet: newPairs));
    }
    emit(state.copyWith(isLoading: false));
  }

  _onDeletePair(SeatingPageEventDeletePair event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    await _deleteSeparationInteractor.run(
      first: event.first,
      second: event.second,
      tournamentId: tournamentId,
    );
    final newPairs = await _getSeparationInteractor.run(
      tournamentId: tournamentId,
    );
    emit(state.copyWith(isLoading: false, cannotMeet: newPairs));
  }

  _onPageOpened(
    SeatingPageEventPageOpened event,
    Emitter emit,
  ) async {
    tournamentId = event.tournamentId;
    final pairs = await _getSeparationInteractor.run(
      tournamentId: tournamentId,
    );
    final seating = await _getSeatingInteractor.run(tournamentId: tournamentId);

    emit(state.copyWith(isLoading: false, cannotMeet: pairs, games: seating));
  }

  @override
  void emitOnError(Emitter<SeatingPageState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
