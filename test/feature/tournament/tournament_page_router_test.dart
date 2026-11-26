@Timeout(Duration(seconds: 10))
library;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/app/localization_delegates.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_router.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

final _initCounts = <String, int>{};
BuildContext? _tournamentContext;

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

/// Повторяет форму AppRouter: shell с rail-вкладками и турниром со своим вложенным роутером.
class _TestRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: _page('AppShellRoute', child: const AutoRouter()),
          path: '/',
          children: [
            AutoRoute(
              page: _page(
                RailWrapperRoute.name,
                child: AutoTabsRouter(
                  routes: const [TournamentsRoute(), ClubsRoute()],
                  builder: (context, child) => child,
                ),
              ),
              path: '',
              children: [
                AutoRoute(page: _page(TournamentsRoute.name), path: 'tournament'),
                AutoRoute(page: _page(ClubsRoute.name), path: 'club'),
              ],
            ),
            AutoRoute(
              page: _page(
                TournamentRoute.name,
                child: Builder(
                  builder: (context) {
                    _tournamentContext = context;
                    return const AutoRouter();
                  },
                ),
              ),
              path: 'tournament/:id',
              children: [
                AutoRoute(page: _page(TournamentPlayersRoute.name), path: ''),
                AutoRoute(page: _page(TournamentSettingsRoute.name), path: 'settings'),
              ],
            ),
          ],
        ),
      ];
}

List<String> _stackNames(StackRouter router) => router.stack.map((page) => page.routeData.name).toList();

StackRouter _shell(_TestRouter router) => router.innerRouterOf<StackRouter>('AppShellRoute')!;

Future<_TestRouter> _pumpRouter(WidgetTester tester, String initialPath) async {
  _initCounts.clear();
  _tournamentContext = null;
  final router = _TestRouter();
  await tester.pumpWidget(
    MaterialApp.router(
      theme: AppTheme.light(isMobile: true),
      localizationsDelegates: appLocalizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router.config(deepLinkBuilder: (_) => DeepLink.path(initialPath)),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

void main() {
  testWidgets('returns to the tournaments list the tournament was opened from', (tester) async {
    final router = await _pumpRouter(tester, '/tournament');
    _shell(router).push(TournamentRoute(tournamentId: 5, children: [TournamentSettingsRoute(tournamentId: 5)]));
    await tester.pumpAndSettle();
    expect(_stackNames(_shell(router)), [RailWrapperRoute.name, TournamentRoute.name]);

    TournamentPageRouterImpl(_tournamentContext!).openTournamentsList();
    await tester.pumpAndSettle();

    expect(_stackNames(_shell(router)), [RailWrapperRoute.name]);
    expect(router.currentUrl, '/tournament');
    expect(find.text(TournamentsRoute.name), findsOneWidget);
    expect(_initCounts[TournamentsRoute.name], 1, reason: 'the list keeps its state and drops the tournament itself');
  });

  testWidgets('a tournament without the list below it does not stay in the stack', (tester) async {
    final router = await _pumpRouter(tester, '/club');
    _shell(router).navigate(TournamentRoute(tournamentId: 5, children: [TournamentSettingsRoute(tournamentId: 5)]));
    await tester.pumpAndSettle();
    _shell(router).removeWhere((route) => route.name == RailWrapperRoute.name);
    await tester.pumpAndSettle();
    expect(_stackNames(_shell(router)), [TournamentRoute.name]);

    TournamentPageRouterImpl(_tournamentContext!).openTournamentsList();
    await tester.pumpAndSettle();

    expect(_stackNames(_shell(router)), [RailWrapperRoute.name]);
    expect(router.currentUrl, '/tournament');
    expect(find.text(TournamentsRoute.name), findsOneWidget);
  });
}
