import 'dart:async';

import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/widgets/create_tournament_dialog.dart';

class MainPageRouterMock implements MainPageRouter {
  final _openedTabController = StreamController<MainPageTab?>.broadcast();
  final _openedTournament = StreamController<bool>.broadcast();
  final _dialogOpened = StreamController<bool>.broadcast();

  Stream<MainPageTab?> get openedTab => _openedTabController.stream;
  Stream<bool> get dialogOpened => _dialogOpened.stream;

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
