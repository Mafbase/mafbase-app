import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/add_separation_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_separation_interactor.dart';
import 'package:seating_generator_web/domain/interactors/generate_final_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_separations_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_players_interactor.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_effect.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_router.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';

class SeatingPageBloc extends Bloc<SeatingPageEvent, SeatingPageState>
    with EffectEmitter<SeatingPageEffect, SeatingPageState> {
  late int tournamentId;
  final RepositoryFactory _repos;
  late final GetSeparationInteractor _getSeparationInteractor =
      GetSeparationInteractor(_repos.tournamentEditRepository);
  late final GetTournamentsPlayersInteractor _getTournamentsPlayersInteractor =
      GetTournamentsPlayersInteractor(_repos.playersRepository);
  late final AddSeparationInteractor _addSeparationInteractor =
      AddSeparationInteractor(_repos.tournamentEditRepository);
  late final DeleteSeparationInteractor _deleteSeparationInteractor =
      DeleteSeparationInteractor(_repos.tournamentEditRepository);
  late final CreateSeatingInteractor _createSeatingInteractor = CreateSeatingInteractor(_repos.tournamentsRepository);
  late final GetSeatingInteractor _getSeatingInteractor = GetSeatingInteractor(_repos.tournamentEditRepository);
  late final GenerateFinalSeatingInteractor _generateFinalSeatingInteractor =
      GenerateFinalSeatingInteractor(_repos.tournamentEditRepository);
  final SeatingPageRouter router;

  SeatingPageBloc({
    required RepositoryFactory repos,
    required this.router,
  })  : _repos = repos,
        super(const SeatingPageState()) {
    on<SeatingPageEventPageOpened>(_onPageOpened);
    on<SeatingPageEventDeletePair>(_onDeletePair);
    on<SeatingPageEventAddPair>(_onAddPair);
    on<SeatingPageEventCreateSeating>(_onCreateSeating);
    on<SeatingPageEventGameEditing>(_onOpenGameEditing);
    on<SeatingPageEventCreateFinalSeating>(_onGenerateFinalSeating);
    on<SeatingPageEventCreateSwissGame>(_onSwissGameCreate);
    on<SeatingPageEventAutoFsmSeating>(_autoFsmSeating);
    on<SeatingPageEventGetPlayersSeating>(_downloadPlayersSeating);
    on<SeatingPageEventGetTablesSeating>(_downloadTablesSeating);
    on<SeatingPageEventGetCrossStats>(_downloadCrossStats);
  }

  Future<void> _downloadPlayersSeating(
    SeatingPageEventGetPlayersSeating event,
    Emitter emit,
  ) async =>
      _repos.tournamentEditRepository.downloadPlayersSeating(
        tournamentId: tournamentId,
      );

  Future<void> _downloadTablesSeating(
    SeatingPageEventGetTablesSeating event,
    Emitter emit,
  ) async =>
      _repos.tournamentEditRepository.downloadTablesSeating(
        tournamentId: tournamentId,
      );

  Future<void> _downloadCrossStats(
    SeatingPageEventGetCrossStats event,
    Emitter emit,
  ) async =>
      _repos.tournamentEditRepository.downloadCrossStats(tournamentId: tournamentId);

  Future<void> _autoFsmSeating(
    SeatingPageEventAutoFsmSeating event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final notFound = await _repos.tournamentEditRepository.getGomafiaSeating(
      tournamentId: tournamentId,
      gomafiaId: event.gomafiaId,
    );

    event.completer?.complete();

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
    await _repos.tournamentEditRepository.generateSwissGame(
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

  _onAddPair(SeatingPageEventAddPair event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    final players = await _getTournamentsPlayersInteractor.run(
      tournamentId: tournamentId,
    );
    final newPair = await router.openSeparationDialog(availablePlayers: players);
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
}
