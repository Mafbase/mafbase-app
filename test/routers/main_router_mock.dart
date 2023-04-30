import 'dart:async';

import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';

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
  void dispose() {
    _openedTabController.close();
  }

  @override
  Stream<String?> get routesStream => const Stream.empty();

  @override
  void initState() {}

  @override
  bool get canPop => false;

  @override
  void openDefaultPage() {}

  @override
  void openAuthPage() {}

  @override
  void openProfilePage() {}
}
