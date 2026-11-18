import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/data/dependencies/players_repository_dependency.dart';
import 'package:seating_generator_web/data/dependencies/stream_repository_dependency.dart';
import 'package:seating_generator_web/data/dependencies/tournament_edit_repository_dependency.dart';
import 'package:seating_generator_web/data/dependencies/tournaments_repository_dependency.dart';
import 'package:seating_generator_web/domain/interactors/add_separation_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_separation_interactor.dart';
import 'package:seating_generator_web/domain/interactors/generate_final_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_separations_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_settings_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_players_interactor.dart';
import 'package:seating_generator_web/feature/referee_assignments/referee_assignments_dependencies.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_effect.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_router.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';

class SeatingPageBloc extends Bloc<SeatingPageEvent, SeatingPageState>
    with EffectEmitter<SeatingPageEffect, SeatingPageState> {
  late int tournamentId;
  RatingScheme? _ratingScheme;
  final DependencyScope _scope;
  late final GetSeparationInteractor _getSeparationInteractor = GetSeparationInteractor(
    _scope.tournamentEditRepository,
  );
  late final GetTournamentsPlayersInteractor _getTournamentsPlayersInteractor = GetTournamentsPlayersInteractor(
    _scope.playersRepository,
  );
  late final AddSeparationInteractor _addSeparationInteractor = AddSeparationInteractor(
    _scope.tournamentEditRepository,
  );
  late final DeleteSeparationInteractor _deleteSeparationInteractor = DeleteSeparationInteractor(
    _scope.tournamentEditRepository,
  );
  late final CreateSeatingInteractor _createSeatingInteractor = CreateSeatingInteractor(_scope.tournamentsRepository);
  late final GetSeatingInteractor _getSeatingInteractor = GetSeatingInteractor(_scope.tournamentEditRepository);
  late final GetSettingsInteractor _getSettingsInteractor = GetSettingsInteractor(_scope.tournamentEditRepository);
  late final GenerateFinalSeatingInteractor _generateFinalSeatingInteractor = GenerateFinalSeatingInteractor(
    _scope.tournamentEditRepository,
  );
  final SeatingPageRouter router;

  SeatingPageBloc({required DependencyScope scope, required this.router})
    : _scope = scope,
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

  Future<void> _downloadPlayersSeating(SeatingPageEventGetPlayersSeating event, Emitter emit) async =>
      _scope.tournamentEditRepository.downloadPlayersSeating(tournamentId: tournamentId);

  Future<void> _downloadTablesSeating(SeatingPageEventGetTablesSeating event, Emitter emit) async =>
      _scope.tournamentEditRepository.downloadTablesSeating(tournamentId: tournamentId);

  Future<void> _downloadCrossStats(SeatingPageEventGetCrossStats event, Emitter emit) async =>
      _scope.tournamentEditRepository.downloadCrossStats(tournamentId: tournamentId);

  Future<void> _autoFsmSeating(SeatingPageEventAutoFsmSeating event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    var success = false;
    try {
      final notFound = await _scope.tournamentEditRepository.getGomafiaSeating(
        tournamentId: tournamentId,
        gomafiaId: event.gomafiaId,
      );

      if (notFound.isEmpty) {
        await _onPageOpened(SeatingPageEventPageOpened(tournamentId: tournamentId), emit);
      } else {
        emitEffect(SeatingPageEffect.fixPlayers(notFound, event.gomafiaId));
      }
      success = true;
    } finally {
      if (!emit.isDone) emit(state.copyWith(isLoading: false));
      final completer = event.completer;
      if (completer != null && !completer.isCompleted) completer.complete(success);
    }
  }

  Future<void> _onSwissGameCreate(SeatingPageEventCreateSwissGame event, Emitter emit) async {
    await _scope.tournamentEditRepository.generateSwissGame(tournamentId: tournamentId, game: event.game);

    return _updateSeating(emit);
  }

  Future<void> _onGenerateFinalSeating(SeatingPageEventCreateFinalSeating event, Emitter emit) async {
    await _generateFinalSeatingInteractor(tournamentId: tournamentId);
    await _updateSeating(emit);
  }

  void _onOpenGameEditing(SeatingPageEventGameEditing event, Emitter emit) {
    router
        .openGameEditing(gameId: event.gameId, tournamentId: tournamentId)
        .then((value) => add(SeatingPageEvent.pageOpened(tournamentId: tournamentId)));
  }

  Future<void> _updateSeating(Emitter emit) async {
    final seating = await _getSeatingInteractor.run(tournamentId: tournamentId, ratingScheme: _ratingScheme);
    emit(state.copyWith(isLoading: false, games: seating));
  }

  Future<void> _onCreateSeating(SeatingPageEventCreateSeating event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _createSeatingInteractor.run(tournamentId: tournamentId);
      await _updateSeating(emit);
    } finally {
      if (!emit.isDone) emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onAddPair(SeatingPageEventAddPair event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final players = await _getTournamentsPlayersInteractor.run(tournamentId: tournamentId);
      final refereeAssignments = await _scope.refereeRepository.getReferees(tournamentId);
      final referees = refereeAssignments.map((e) => e.referee).toList();
      final allParticipants = [...players, ...referees.where((r) => players.every((p) => p.id != r.id))];
      final newPair = await router.openSeparationDialog(availablePlayers: allParticipants);
      if (newPair != null) {
        await _addSeparationInteractor.run(first: newPair.first, second: newPair.second, tournamentId: tournamentId);
        final newPairs = await _getSeparationInteractor.run(tournamentId: tournamentId);
        emit(state.copyWith(cannotMeet: newPairs));
      }
    } finally {
      if (!emit.isDone) emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onDeletePair(SeatingPageEventDeletePair event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _deleteSeparationInteractor.run(first: event.first, second: event.second, tournamentId: tournamentId);
      final newPairs = await _getSeparationInteractor.run(tournamentId: tournamentId);
      emit(state.copyWith(cannotMeet: newPairs));
    } finally {
      if (!emit.isDone) emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onPageOpened(SeatingPageEventPageOpened event, Emitter emit) async {
    tournamentId = event.tournamentId;
    final pairs = await _getSeparationInteractor.run(tournamentId: tournamentId);
    final settings = await _getSettingsInteractor.run(tournamentId: tournamentId);
    _ratingScheme = settings.ratingScheme;
    final seating = await _getSeatingInteractor.run(tournamentId: tournamentId, ratingScheme: _ratingScheme);

    List<GameStream> streams;
    try {
      streams = await _scope.streamRepository.getStreams(tournamentId: tournamentId);
    } catch (_) {
      streams = [];
    }

    emit(state.copyWith(isLoading: false, cannotMeet: pairs, games: seating, streams: streams));
  }
}
