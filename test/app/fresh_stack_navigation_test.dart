@Timeout(Duration(seconds: 10))
library;

import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/app/fresh_stack_navigation.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_bloc.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_effect.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_page.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';

final _initCounts = <String, int>{};

class _CountedPage extends StatefulWidget {
  const _CountedPage(this.name, {this.child});

  final String name;
  final Widget? child;

  @override
  State<_CountedPage> createState() => _CountedPageState();
}

class _CountedPageState extends State<_CountedPage> {
  @override
  void initState() {
    super.initState();
    _initCounts.update(widget.name, (count) => count + 1, ifAbsent: () => 1);
  }

  @override
  Widget build(BuildContext context) => widget.child ?? Text(widget.name);
}

PageInfo _page(String name, {Widget? child}) => PageInfo(name, builder: (_) => _CountedPage(name, child: child));

/// Повторяет форму AppRouter: корневые webview и waiting, редирект '/', shell с профилем, rail-вкладками и турниром.
class _TestRouter extends RootStackRouter {
  _TestRouter({this.profile});

  final Widget? profile;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: _page('WebViewRoute'), path: '/web-view'),
        AutoRoute(page: _page('PaymentWaitingRoute'), path: '/payment-waiting'),
        RedirectRoute(path: '/', redirectTo: '/tournament'),
        AutoRoute(
          page: _page('AppShellRoute', child: const AutoRouter()),
          path: '/',
          children: [
            AutoRoute(page: _page('ProfileRoute', child: profile), path: 'profile'),
            AutoRoute(
              page: _page(
                'RailWrapperRoute',
                child: AutoTabsRouter(
                  routes: const [PageRouteInfo('TournamentsRoute'), PageRouteInfo('ClubsRoute')],
                  builder: (context, child) => child,
                ),
              ),
              path: '',
              children: [
                AutoRoute(page: _page('TournamentsRoute'), path: 'tournament'),
                AutoRoute(page: _page('ClubsRoute'), path: 'club'),
              ],
            ),
            AutoRoute(
              page: _page('TournamentRoute', child: const AutoRouter()),
              path: 'tournament/:id',
              children: [
                AutoRoute(page: _page('TournamentPlayersRoute'), path: ''),
              ],
            ),
          ],
        ),
      ];
}

List<String> _stackNames(StackRouter router) => router.stack.map((page) => page.routeData.name).toList();

StackRouter _shell(_TestRouter router) => router.innerRouterOf<StackRouter>('AppShellRoute')!;

Future<_TestRouter> _pumpRouter(WidgetTester tester, {Widget? profile}) async {
  _initCounts.clear();
  final router = _TestRouter(profile: profile);
  await tester.pumpWidget(
    MaterialApp.router(
      theme: AppTheme.light(isMobile: true),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router.config(),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

class _MockProfileBloc extends MockBloc<ProfileEvent, ProfileState> implements ProfileBloc {
  @override
  Stream<ProfileEffect> get effectsStream => const Stream.empty();
}

Widget _profilePage() {
  final bloc = _MockProfileBloc();
  whenListen(bloc, const Stream<ProfileState>.empty(), initialState: const ProfileState());
  final authNotifier = AuthNotifier()..value = const AuthNotifierModel.authorized(userId: 1, hideBilling: true);
  addTearDown(bloc.close);
  addTearDown(authNotifier.dispose);
  return MultiProvider(
    providers: [
      BlocProvider<ProfileBloc>.value(value: bloc),
      ChangeNotifierProvider<AuthNotifier>.value(value: authNotifier),
    ],
    child: const ProfilePage(),
  );
}

void main() {
  testWidgets('rebuilds the shell and the target page after returning from payment', (tester) async {
    final router = await _pumpRouter(tester);
    _shell(router).push(const PageRouteInfo('TournamentRoute', rawPathParams: {'id': 1}));
    await tester.pumpAndSettle();
    router.navigatePath('/payment-waiting?nextPath=%2Ftournament%2F1&purchaseId=5');
    await tester.pumpAndSettle();

    router.navigatePathWithFreshStack('/tournament/1');
    await tester.pumpAndSettle();

    expect(_initCounts['AppShellRoute'], 2);
    expect(_initCounts['TournamentRoute'], 2);
    expect(_stackNames(router), ['AppShellRoute']);
    expect(_stackNames(_shell(router)), ['RailWrapperRoute', 'TournamentRoute']);
    expect(router.currentUrl, '/tournament/1');
  });

  testWidgets('follows redirects', (tester) async {
    final router = await _pumpRouter(tester);

    router.navigatePathWithFreshStack('/');
    await tester.pumpAndSettle();

    expect(_initCounts['AppShellRoute'], 2);
    expect(_stackNames(_shell(router)), ['RailWrapperRoute']);
    expect(router.currentUrl, '/tournament');
  });

  group('ProfilePage back button', () {
    testWidgets('pops to the page below', (tester) async {
      final router = await _pumpRouter(tester, profile: _profilePage());
      _shell(router).push(const PageRouteInfo('ProfileRoute'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(_stackNames(_shell(router)), ['RailWrapperRoute']);
      expect(router.currentUrl, '/tournament');
    });

    testWidgets('opens clubs when the profile is the only page after payment', (tester) async {
      final router = await _pumpRouter(tester, profile: _profilePage());
      router.navigatePathWithFreshStack('/profile');
      await tester.pumpAndSettle();
      expect(_stackNames(_shell(router)), ['ProfileRoute']);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(_stackNames(_shell(router)), ['RailWrapperRoute']);
      expect(router.currentUrl, '/club');
    });
  });
}
