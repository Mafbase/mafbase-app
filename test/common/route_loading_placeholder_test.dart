import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/common/widgets/route_loading_placeholder.dart';

const _sidebarKey = Key('sidebar');

class _TestRouter extends RootStackRouter {
  _TestRouter({required this.loader, required this.nested});

  final LibraryLoader loader;
  final bool nested;

  late final _deferredPage = PageInfo(
    'DeferredRoute',
    builder: (_) => DeferredWidget(loader, _loadedPage),
  );

  static Widget _loadedPage() => const Text('loaded');

  @override
  List<AutoRoute> get routes => [
        if (nested)
          AutoRoute(
            page: PageInfo(
              'ShellRoute',
              builder: (_) => const Row(
                children: [
                  SizedBox(key: _sidebarKey, width: 100),
                  Expanded(child: AutoRouter(placeholder: RouteLoadingPlaceholder.builder)),
                ],
              ),
            ),
            path: '/',
            children: [AutoRoute(page: _deferredPage, path: '')],
          )
        else
          AutoRoute(page: _deferredPage, path: '/'),
      ];
}

Future<Completer<void>> _pumpApp(WidgetTester tester, {required bool nested}) async {
  final completer = Completer<void>();
  final router = _TestRouter(loader: () => completer.future, nested: nested);
  await tester.pumpWidget(
    MaterialApp.router(
      theme: AppTheme.light(isMobile: false),
      routerConfig: router.config(placeholder: RouteLoadingPlaceholder.builder),
    ),
  );
  await tester.pump();
  return completer;
}

void main() {
  testWidgets('shows the app loading indicator while a deferred page is loading', (tester) async {
    final completer = await _pumpApp(tester, nested: false);

    expect(find.byType(RouteLoadingPlaceholder), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(DeferredLoadingPlaceholder), findsNothing);
    final background = tester.widget<ColoredBox>(
      find.descendant(of: find.byType(RouteLoadingPlaceholder), matching: find.byType(ColoredBox)),
    );
    expect(background.color, AppTheme.light(isMobile: false).scaffoldBackgroundColor);

    completer.complete();
    await tester.pumpAndSettle();

    expect(find.text('loaded'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('keeps the surrounding shell visible while a nested deferred page is loading', (tester) async {
    final completer = await _pumpApp(tester, nested: true);

    expect(find.byKey(_sidebarKey), findsOneWidget);
    expect(
      find.descendant(of: find.byType(Expanded), matching: find.byType(CircularProgressIndicator)),
      findsOneWidget,
    );
    expect(find.byType(Scaffold), findsNothing);

    completer.complete();
    await tester.pumpAndSettle();

    expect(find.text('loaded'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
