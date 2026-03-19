import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/bloc_observer.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/splash_manager.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:seating_generator_web/firebase_options.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => super.dragDevices.toSet()..add(PointerDeviceKind.mouse);
}

void main() async {
  if (!kDebugMode) {
    runZonedGuarded(
      () async {
        await SentryFlutter.init(
          (options) {
            options.dsn = sentryUrl;
            options.tracesSampleRate = 1.0;
          },
          appRunner: _startApp,
        );
      },
      (error, stack) async {
        Sentry.captureException(error, stackTrace: stack);
      },
    );
  } else {
    _startApp();
  }
}

extension LocationPathExt on RemoteMessage {
  String? get location {
    final pushLocation = data['location'] as String?;
    final initUri = pushLocation == null ? null : Uri.parse(pushLocation);
    final initPath = initUri == null ? null : initUri.path + initUri.query;
    return initPath;
  }
}

void _startApp() async {
  WidgetsBinding? binding;
  setPathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  if (!kIsWeb) {
    binding = WidgetsFlutterBinding.ensureInitialized();
    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  final initPush = await FirebaseMessaging.instance.getInitialMessage().onError((_, __) => null);
  SplashManager.deferSplash(
    binding ??= WidgetsFlutterBinding.ensureInitialized(),
  );

  Bloc.observer = AppBlocObserver();

  final scope = DependencyScope();

  runApp(
    MafbaseApp(
      scope: scope,
      initLocation: initPush?.location ?? '/',
    ),
  );
}

class MafbaseApp extends StatefulWidget {
  final String initLocation;
  final DependencyScope scope;

  const MafbaseApp({
    super.key,
    this.initLocation = '/',
    required this.scope,
  });

  @override
  State<MafbaseApp> createState() => _MafbaseAppState();
}

class _MafbaseAppState extends State<MafbaseApp> {
  late final router = AppRouter(widget.initLocation, widget.scope);
  StreamSubscription? subscription;

  @override
  void initState() {
    subscription = FirebaseMessaging.onMessageOpenedApp.map((e) => e.location).whereNotNull().listen(router.router.go);
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    widget.scope.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DependencyScopeWidget(
        scope: widget.scope,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => widget.scope.authNotifier),
            Provider.value(value: router),
          ],
          child: Builder(
            builder: (context) {
              return MaterialApp.router(
                scrollBehavior: MyCustomScrollBehavior(),
                title: 'Mafbase',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light(isMobile: context.isMobile),
                darkTheme: AppTheme.dark(isMobile: context.isMobile),
                themeMode: ThemeMode.light,
                routerDelegate: context.read<AppRouter>().router.routerDelegate,
                routeInformationProvider: context.read<AppRouter>().router.routeInformationProvider,
                routeInformationParser: context.read<AppRouter>().router.routeInformationParser,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.noScaling,
                    boldText: false,
                  ),
                  child: child ?? const SizedBox.shrink(),
                ),
              );
            },
          ),
        ),
      );
}

