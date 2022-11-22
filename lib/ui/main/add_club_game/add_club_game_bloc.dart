import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/add_club_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_event.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_state.dart';

class AddClubGameBloc extends CustomBloc<AddClubGameEvent, AddClubGameState> {
  final GetAllPlayersInteractor _getAllPlayersInteractor = getIt();
  final AddClubGameInteractor _addClubGameInteractor = getIt();
  final int clubId;

  AddClubGameBloc(this.clubId, [BuildContext? context]) : super(const AddClubGameState(), context) {
    on<AddClubGameEventPageOpened>(_onPageOpened);
    on<AddClubGameEventSubmit>(_onSubmit);
  }

  _onSubmit(AddClubGameEventSubmit event, Emitter emit,) async {
    debugPrint(event.toString());
    emit(state.copyWith(isLoading: true));
    await _addClubGameInteractor.run(clubId: clubId, result: event.gameResult);
    // TODO: add result
    emit(state.copyWith(isLoading: false));
  }

  _onPageOpened(AddClubGameEventPageOpened event,
      Emitter emit,) async {
    emit(state.copyWith(isLoading: true));
    final players = await _getAllPlayersInteractor.run();
    emit(state.copyWith(isLoading: false, players: players));
  }

  @override
  void emitOnError(Emitter emit) {
    emit(state.copyWith(isLoading: false));
  }
}
