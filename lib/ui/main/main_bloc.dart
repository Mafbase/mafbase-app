import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/ui/contacts/contacts_page.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_page.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_page.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_page.dart';

class MainBloc extends CustomBloc<MainEvent, MainState> {
  @visibleForTesting
  final MainPageRouter router;

  MainBloc(this.router, MainPageTab tab, [BuildContext? context])
      : super(
          MainState(
            isLoading: false,
            selectedTab: tab,
            hasBackButton: false,
          ),
          context,
        ) {
    on<MainEventSwitchTab>(_onSwitchTab);
    on<MainEventBackButtonPressed>(_onBackButtonPressed);
    on<MainEventTournamentSelected>(_onTournamentSelected);
    on<MainEventPageOpened>(_onPageOpened);
    on<MainEventTitleTapped>(_onTitleTapped);
    on<MainEventEnterPressed>(_onEnterPressed);
    on<MainEventProfilePressed>(_onProfilePressed);
    on<MainEventOpenContacts>(_onOpenContacts);
    router.routesStream.listen((route) {
      final hasBackButton = router.canPop;
      final tab = MainPageTab.values.firstWhereOrNull(
        (element) => route?.startsWith('/${element.name}') == true,
      );
      add(
        MainEvent.switchTab(
          tab: tab ?? state.selectedTab,
          disableNavigate: true,
          hasBackButton: hasBackButton,
        ),
      );
    });
  }

  _onOpenContacts(MainEventOpenContacts event, Emitter emit) {
    router.openContactsPage();
  }

  _onProfilePressed(MainEventProfilePressed event, Emitter emit) {
    router.openProfilePage();
  }

  _onEnterPressed(MainEventEnterPressed event, Emitter emit) {
    router.openAuthPage();
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

  void openAuthPage();

  void openProfilePage();

  void openContactsPage();

  bool get canPop;
}

class MainPageRouterImpl implements MainPageRouter {
  final BuildContext context;
  GoRouter? _goRouter;
  final controller = BehaviorSubject<String?>.seeded(null);

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
    Future.delayed(
      const Duration(milliseconds: 50),
      () => controller
          .add(GoRouter.of(context).routeInformationProvider.value.uri.toString()),
    );
  }

  @override
  void switchTabTo(MainPageTab tab) {
    switch (tab) {
      case MainPageTab.clubs:
        context.go(ClubsPage.createLocation(context));
        break;
      case MainPageTab.tournaments:
        context.go(TournamentsPage.createLocation(context));
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
  bool get canPop {
    try {
      return GoRouter.of(context).canPop();
    } catch (_) {
      return false;
    }
  }

  @override
  void openAuthPage() {
    context.push(
      LoginPageBody.createLocation(
        context: context,
        nextPath: GoRouter.of(context).location,
      ),
    );
  }

  @override
  void openProfilePage() {
    context.push(ProfilePage.createLocation(context));
  }

  @override
  void openContactsPage() {
    context.push(ContactsPage.createLocation(context));
  }
}
