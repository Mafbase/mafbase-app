import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  @visibleForTesting
  final MainPageRouter router;

  MainBloc(
    this.router,
  ) : super(
          const MainState(
            isLoading: false,
          ),
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
    router.switchTabTo(event.tab);
  }
}

abstract class MainPageRouter {
  void switchTabTo(MainPageTab tab);

  void pop();

  void openTournament(int id);
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
}

class MainPageRouterMock implements MainPageRouter {
  final _openedTabController = StreamController<MainPageTab?>.broadcast();
  final _openedTournament = StreamController<bool>.broadcast();

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
}
