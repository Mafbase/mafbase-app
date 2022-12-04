import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/add_club_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_effect.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_event.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_router.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_state.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/add_player_dialog.dart';

class AddClubGameBloc extends CustomBloc<AddClubGameEvent, AddClubGameState>
    with EffectEmitter<AddClubGameEffect, AddClubGameState> {
  final GetAllPlayersInteractor _getAllPlayersInteractor = getIt();
  final AddClubGameInteractor _addClubGameInteractor = getIt();
  final ClubRepository _repository = getIt();
  final int clubId;
  late final AddClubGameRouter router = getIt(param1: context);
  final CreatePlayerInteractor _createPlayerInteractor = getIt();

  AddClubGameBloc(this.clubId, [BuildContext? context])
      : super(const AddClubGameState(), context) {
    on<AddClubGameEventPageOpened>(_onPageOpened);
    on<AddClubGameEventSubmit>(_onSubmit);
    on<AddClubGameEventPageEdit>(_onEdit);
    on<AddClubGameEventNewPlayer>(_onNewPlayer);
  }

  _onNewPlayer(AddClubGameEventNewPlayer event, Emitter emit) async {
    if (context == null) {
      return;
    }

    final newPlayer = await AddPlayerDialog.open(
      context: context!,
      availablePlayers: state.players,
      initValue: event.nickname,
    );

    if (newPlayer == null) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final id = await _createPlayerInteractor.run(playerModel: newPlayer);
    final players = await _getAllPlayersInteractor.run();
    emit(state.copyWith(players: players));
    emitEffect(
      AddClubGameEffect.setPlayer(
        index: event.index,
        player: players.firstWhere(
          (element) => element.id == id,
        ),
      ),
    );
    emit(state.copyWith(isLoading: false));
  }

  _onEdit(AddClubGameEventPageEdit event, Emitter emit) {
    router.editPage(clubId, event.gameId);
  }

  _onSubmit(
    AddClubGameEventSubmit event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    if (event.gameId == null) {
      await _addClubGameInteractor.run(
          clubId: clubId, result: event.gameResult);
    } else {
      await _repository.editGame(event.gameResult, clubId, event.gameId!);
    }
    // TODO: add result
    emit(state.copyWith(isLoading: false));
  }

  _onPageOpened(
    AddClubGameEventPageOpened event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final players = await _getAllPlayersInteractor.run();
    final isOwner = await _repository.isOwner(clubId);
    emit(
      state.copyWith(
        isLoading: event.gameId != null,
        players: players,
        canEdit: isOwner,
      ),
    );
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
