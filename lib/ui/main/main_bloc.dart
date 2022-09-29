import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainPageRouter _router;

  MainBloc(
    this._router,
  ) : super(
          const MainState(
            isLoading: false,
          ),
        ) {
    on<MainEventSwitchTab>(_onSwitchTab);
    on<MainEventBackButtonPressed>(_onBackButtonPressed);
  }

  Future _onBackButtonPressed(
    MainEventBackButtonPressed event,
    Emitter<MainState> emit,
  ) async {
    _router.pop();
  }

  Future _onSwitchTab(
    MainEventSwitchTab event,
    Emitter<MainState> emit,
  ) async {
    _router.switchTabTo(event.tab);
  }
}

abstract class MainPageRouter {
  void switchTabTo(MainPageTab tab);

  void pop();
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
}

class MainPageRouterMock implements MainPageRouter {
  final _openedTabController = StreamController<MainPageTab?>();

  Stream<MainPageTab?> get openedTab => _openedTabController.stream;

  @override
  void switchTabTo(MainPageTab tab) {
    _openedTabController.add(tab);
  }

  @override
  void pop() {
    _openedTabController.add(null);
  }
}
