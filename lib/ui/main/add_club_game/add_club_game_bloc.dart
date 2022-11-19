import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/add_club_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_effect.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_event.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_state.dart';

class AddClubGameBloc extends CustomBloc<AddClubGameEvent, AddClubGameState>
    with EffectEmitter<AddClubGameEffect, AddClubGameState> {
  final GetAllPlayersInteractor _getAllPlayersInteractor = getIt();
  final AddClubGameInteractor _addClubGameInteractor = getIt();
  final ClubRepository _repository = getIt();
  final int clubId;

  AddClubGameBloc(this.clubId, [BuildContext? context])
      : super(const AddClubGameState(), context) {
    on<AddClubGameEventPageOpened>(_onPageOpened);
    on<AddClubGameEventSubmit>(_onSubmit);
  }

  _onSubmit(
    AddClubGameEventSubmit event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _addClubGameInteractor.run(clubId: clubId, result: event.gameResult);
    // TODO: add result
    emit(state.copyWith(isLoading: false));
  }

  _onPageOpened(
    AddClubGameEventPageOpened event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final players = await _getAllPlayersInteractor.run();
    emit(state.copyWith(isLoading: event.gameId != null, players: players));
    if (event.gameId != null) {
      final game = await _repository.getGame(event.gameId!, clubId);
      emitEffect(
        AddClubGameEffect.setValues(
          players: game.players
              .map(
                (e) =>
                    players.firstWhere((element) => element.id == e).nickname,
              )
              .toList(),
          addScore: game.addScore.map((e) => e / 100).toList(),
          roles: List.generate(
            10,
            (index) {
              if (game.sheriff == index) {
                return PlayerRole.sheriff;
              }
              if (game.don == index) {
                return PlayerRole.don;
              }
              if (game.mafia1 == index || game.mafia2 == index) {
                return PlayerRole.mafia;
              }
              return PlayerRole.citizen;
            },
          ),
          win: game.win,
          bestMove: game.bestMove,
          referee: players
              .firstWhere((element) => element.id == game.referee)
              .nickname,
          died: game.firstDie,
          date: DateTime.parse(game.date),
        ),
      );
      emit(state.copyWith(isLoading: false));
    }
  }

  @override
  void emitOnError(Emitter emit) {
    emit(state.copyWith(isLoading: false));
  }
}
