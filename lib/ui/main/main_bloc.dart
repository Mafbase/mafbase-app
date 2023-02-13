import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/create_tournament_interactor.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_page.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page.dart';
import 'package:seating_generator_web/ui/main/widgets/create_tournament_dialog.dart';

class MainBloc extends CustomBloc<MainEvent, MainState> {
  @visibleForTesting
  final MainPageRouter router;

  MainBloc(this.router, [BuildContext? context])
      : super(
          const MainState(
            isLoading: false,
            selectedTab: MainPageTab.tournaments,
            hasBackButton: false,
          ),
          context,
        ) {
    on<MainEventSwitchTab>(_onSwitchTab);
    on<MainEventBackButtonPressed>(_onBackButtonPressed);
    on<MainEventTournamentSelected>(_onTournamentSelected);
    on<MainEventPageOpened>(_onPageOpened);
    on<MainEventTitleTapped>(_onTitleTapped);
    router.routesStream.listen((route) {
      if (route == null) {
        return;
      }
      final hasBackButton = router.canPop;
      if (route.startsWith('/club')) {
        add(
          MainEvent.switchTab(
            tab: MainPageTab.clubs,
            disableNavigate: true,
            hasBackButton: hasBackButton,
          ),
        );
      } else {
        add(
          MainEvent.switchTab(
            tab: MainPageTab.tournaments,
            disableNavigate: true,
            hasBackButton: hasBackButton,
          ),
        );
      }
    });
  }

  _onTitleTapped(MainEventTitleTapped event, Emitter emit) {
    router.openDefaultPage();
  }

  _onPageOpened(MainEventPageOpened event, Emitter emit) {
    router.initState();
  }

  @override
  Future<void> close() {
    router.dispose();
    return super.close();
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
    emit(
      state.copyWith(
        selectedTab: event.tab,
        hasBackButton: event.hasBackButton,
      ),
    );
    if (!event.disableNavigate) {
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

  Stream<String?> get routesStream;

  void dispose();

  void initState();

  void openDefaultPage();

  bool get canPop;
}

class MainPageRouterImpl implements MainPageRouter {
  final BuildContext context;
  GoRouter? _goRouter;
  final StreamController<String?> controller = StreamController.broadcast();

  MainPageRouterImpl(this.context);

  @override
  void initState() {
    _goRouter = GoRouter.of(context)..addListener(routeListener);
  }

  @override
  void dispose() {
    _goRouter?.removeListener(routeListener);
  }

  void routeListener() {
    controller
        .add(GoRouter.of(context).routeInformationProvider.value.location);
  }

  @override
  void switchTabTo(MainPageTab tab) {
    switch (tab) {
      case MainPageTab.clubs:
        context.go(ClubsPage.createLocation(context));
        break;
      case MainPageTab.tournaments:
        context.go('/'); // TODO: replace
        break;
    }
  }

  @override
  void pop() {
    GoRouter.of(context).go("/");
  }

  @override
  void openTournament(int id) {
    GoRouter.of(context).go(
      TournamentPage.createLocation(
        context: context,
        tournamentId: id,
      ),
    );
  }

  @override
  Stream<String?> get routesStream => controller.stream;

  @override
  void openDefaultPage() {
    GoRouter.of(context).go('/');
  }

  @override
  bool get canPop => GoRouter.of(context).location.split("/").length > 2;
}
