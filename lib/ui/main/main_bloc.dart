import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  @visibleForTesting
  final MainPageRouter router;

  MainBloc(
    this.router, [
    BuildContext? context,
  ]) : super(
          const MainState(
            isLoading: false,
            hasBackButton: false,
          ),
        ) {
    on<MainEventSwitchTab>(_onSwitchTab);
    on<MainEventBackButtonPressed>(_onBackButtonPressed);
    on<MainEventTournamentSelected>(_onTournamentSelected);
    on<MainEventTitleTapped>(_onTitleTapped);
    on<MainEventEnterPressed>(_onEnterPressed);
    on<MainEventProfilePressed>(_onProfilePressed);
    on<MainEventOpenContacts>(_onOpenContacts);
  }

  void _onOpenContacts(MainEventOpenContacts event, Emitter emit) {
    router.openContactsPage();
  }

  void _onProfilePressed(MainEventProfilePressed event, Emitter emit) {
    router.openProfilePage();
  }

  void _onEnterPressed(MainEventEnterPressed event, Emitter emit) {
    router.openAuthPage();
  }

  void _onTitleTapped(MainEventTitleTapped event, Emitter emit) {
    router.openDefaultPage();
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
        hasBackButton: event.hasBackButton,
      ),
    );
    if (!event.disableNavigate) {
      router.switchTabTo(event.tab);
    }
  }
}

abstract class MainPageRouter {
  void switchTabTo(MainPageTab tab);

  void pop();

  void openTournament(int id);

  void openDefaultPage();

  void openAuthPage();

  void openProfilePage();

  void openContactsPage();

  bool get canPop;
}

class MainPageRouterImpl implements MainPageRouter {
  final BuildContext context;
  final controller = BehaviorSubject<String?>.seeded(null);

  MainPageRouterImpl(this.context);

  @override
  void switchTabTo(MainPageTab tab) {
    switch (tab) {
      case MainPageTab.clubs:
        context.router.navigate(const ClubsRoute());
        break;
      case MainPageTab.tournaments:
        context.router.navigate(const TournamentsRoute());
        break;
    }
  }

  @override
  void pop() {
    context.router.navigate(const ClubsRoute());
  }

  @override
  void openTournament(int id) {
    context.router.push(TournamentRoute(tournamentId: id));
  }

  @override
  void openDefaultPage() {
    context.router.navigate(const ClubsRoute());
  }

  @override
  bool get canPop {
    try {
      return context.router.canPop();
    } catch (_) {
      return false;
    }
  }

  @override
  void openAuthPage() {
    context.router.push(const LoginPageRoute());
  }

  @override
  void openProfilePage() {
    context.router.push(const ProfileRoute());
  }

  @override
  void openContactsPage() {
    context.router.push(const ContactsRoute());
  }
}
