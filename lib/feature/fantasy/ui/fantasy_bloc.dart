import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/fantasy/domain/fantasy_repository.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_event.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_state.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

class FantasyBloc extends CustomBloc<FantasyEvent, FantasyState> {
  final FantasyRepository _repository;
  int? _currentUserId;

  FantasyBloc(super.initialState, this._repository) {
    on<FantasyEventInit>(_onInit);
    on<FantasyEventRefresh>(_onRefresh);
    on<FantasyEventSetPrediction>(_onSetPrediction);
    on<FantasyEventAddParticipant>(_onAddParticipant);
    on<FantasyEventRemoveParticipant>(_onRemoveParticipant);
    on<FantasyEventLoadParticipants>(_onLoadParticipants);
  }

  Future<void> _onInit(
    FantasyEventInit event,
    Emitter<FantasyState> emit,
  ) async {
    _currentUserId = event.userId;
    emit(state.copyWith(isLoading: true, isOwner: event.isOwner));
    await _loadData(event.tournamentId, emit);
    if (event.isOwner) {
      await _loadParticipants(event.tournamentId, emit);
    }
  }

  Future<void> _onRefresh(
    FantasyEventRefresh event,
    Emitter<FantasyState> emit,
  ) async {
    await _loadData(event.tournamentId, emit);
    if (state.isOwner) {
      await _loadParticipants(event.tournamentId, emit);
    }
  }

  Future<void> _onSetPrediction(
    FantasyEventSetPrediction event,
    Emitter<FantasyState> emit,
  ) async {
    final currentGameInfo = state.currentGameInfo;
    if (currentGameInfo != null && !currentGameInfo.canParticipate) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.setPrediction(event.tournamentId, event.prediction);
      emit(state.copyWith(selectedPrediction: event.prediction));
      await _loadData(event.tournamentId, emit);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _onAddParticipant(
    FantasyEventAddParticipant event,
    Emitter<FantasyState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.addParticipant(event.tournamentId, event.email);
      await _loadParticipants(event.tournamentId, emit);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _onRemoveParticipant(
    FantasyEventRemoveParticipant event,
    Emitter<FantasyState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.removeParticipant(event.tournamentId, event.userId);
      await _loadParticipants(event.tournamentId, emit);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _onLoadParticipants(
    FantasyEventLoadParticipants event,
    Emitter<FantasyState> emit,
  ) async {
    await _loadParticipants(event.tournamentId, emit);
  }

  Future<void> _loadData(int tournamentId, Emitter<FantasyState> emit) async {
    try {
      final rating = await _repository.getRating(tournamentId);
      final currentGameInfo = await _repository.getCurrentGameInfo(tournamentId);
      
      // Находим предсказание текущего пользователя по userId
      GameWin? userPrediction;
      if (_currentUserId != null && rating.rows.isNotEmpty && currentGameInfo != null) {
        try {
          final userRow = rating.rows.firstWhere(
            (row) => row.playerId == _currentUserId,
          );
          
          final prediction = userRow.predictions.firstWhere(
            (p) => p.gameNumber == currentGameInfo.gameNumber && p.prediction != null,
          );
          
          userPrediction = prediction.prediction;
        } catch (_) {
          // Пользователь не найден в рейтинге или нет предсказания для текущей игры
        }
      }
      
      emit(
        state.copyWith(
          isLoading: false,
          rating: rating,
          currentGameInfo: currentGameInfo,
          selectedPrediction: userPrediction,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  Future<void> _loadParticipants(int tournamentId, Emitter<FantasyState> emit) async {
    try {
      final participants = await _repository.getParticipants(tournamentId);
      emit(state.copyWith(participants: participants, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  @override
  void emitOnError(Emitter<FantasyState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
