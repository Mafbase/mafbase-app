import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';

void main() {
  registerGetItTest();
  group('Main bloc', () {
    test('test init state', () {
      final bloc = getIt<MainBloc>();
      expect(
        bloc.state,
        const MainState(isLoading: false),
      );
    });

    test('test switching tab', () async {
      final bloc = getIt<MainBloc>();
      final router = bloc.router as MainPageRouterMock;

      var tab = router.openedTab.first;

      bloc.add(const MainEvent.switchTab(tab: MainPageTab.profileSettings));
      expect(await tab, MainPageTab.profileSettings);

      tab = router.openedTab.first;

      bloc.add(const MainEvent.backButtonPressed());
      expect(await tab, null);
    });

    test('open creation dialog', () async {
      final bloc = getIt<MainBloc>();
      final router = bloc.router as MainPageRouterMock;
      final opened = router.dialogOpened.first;
      bloc.add(const MainEvent.switchTab(tab: MainPageTab.addTournament));
      expect(await opened, true);
    });
  });
}
