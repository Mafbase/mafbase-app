import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/create_tournament_interactor.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';
import 'package:seating_generator_web/ui/main/widgets/create_tournament_dialog.dart';

class MainBloc extends CustomBloc<MainEvent, MainState> {
  @visibleForTesting
  final MainPageRouter router;
  final CreateTournamentInteractor _createTournamentInteractor = getIt();

  MainBloc(this.router, [BuildContext? context])
      : super(
          const MainState(
            isLoading: false,
          ),
          context,
        ) {
    on<MainEventSwitchTab>(_onSwitchTab);
    on<MainEventBackButtonPressed>(_onBackButtonPressed);
    on<MainEventTournamentSelected>(_onTournamentSelected);
  }

  Future _onTournamentSelected(
    MainEventTournamentSelected event,
    Emitter<MainState> emit,
  ) async {
    router.openTournament(event.tournamentId);
  }

  Future _onBackButtonPressed(
    MainEventBackButtonPressed event,
    Emitter<MainState> emit,
  ) async {
    router.pop();
  }

  Future _onSwitchTab(
    MainEventSwitchTab event,
    Emitter<MainState> emit,
  ) async {
    if (event.tab == MainPageTab.addTournament) {
      final data = await router.openCreateTournamentDialog();
      if (data != null) {
        emit(state.copyWith(isLoading: true));
        final id = await _createTournamentInteractor.run(
          name: data.name,
          range: data.range,
        );

        router.openTournament(id);
        emit(state.copyWith(isLoading: false));
      }
    } else {
      router.switchTabTo(event.tab);
    }
  }

  @override
  void emitOnError(Emitter<MainState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}

abstract class MainPageRouter {
  void switchTabTo(MainPageTab tab);

  void pop();

  void openTournament(int id);

  Future<CreateTournamentData?> openCreateTournamentDialog();
}

class MainPageRouterImpl implements MainPageRouter {
  final BuildContext context;

  MainPageRouterImpl(this.context);

  @override
  void switchTabTo(MainPageTab tab) {
    GoRouter.of(context).go("/${tab.name}");
  }

  @override
  void pop() {
    GoRouter.of(context).go("/");
  }

  @override
  void openTournament(int id) {
    GoRouter.of(context).go(AppRoutes.tournamentPlayersListRouteWithId(id));
  }

  @override
  Future<CreateTournamentData?> openCreateTournamentDialog() {
    return CreateTournamentDialog.open(context);
  }
}

class MainPageRouterMock implements MainPageRouter {
  final _openedTabController = StreamController<MainPageTab?>.broadcast();
  final _openedTournament = StreamController<bool>.broadcast();
  final _dialogOpened = StreamController<bool>.broadcast();

  Stream<MainPageTab?> get openedTab => _openedTabController.stream;

  @override
  void switchTabTo(MainPageTab tab) {
    _openedTabController.add(tab);
  }

  @override
  void pop() {
    _openedTabController.add(null);
  }

  @override
  void openTournament(int id) {
    _openedTournament.add(true);
  }

  @override
  Future<CreateTournamentData?> openCreateTournamentDialog() {
    _dialogOpened.add(true);
    return Future.value(null);
  }
}
