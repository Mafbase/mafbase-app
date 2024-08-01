import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/splash_manager.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices =>
      super.dragDevices.toSet()..add(PointerDeviceKind.mouse);
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

void _startApp() async {
  WidgetsBinding? binding;
  setPathUrlStrategy();
  if (!kIsWeb) {
    binding = WidgetsFlutterBinding.ensureInitialized();
    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
  }
  registerGetIt();
  SplashManager.deferSplash(
    binding ?? WidgetsFlutterBinding.ensureInitialized(),
  );
  runApp(const MafbaseApp());
}

class MafbaseApp extends StatelessWidget {
  final String initLocation;

  const MafbaseApp({Key? key, this.initLocation = '/'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<AuthNotifier>(),
        ),
        Provider(
          create: (context) => AppRouter(initLocation),
        ),
        Provider<MyTheme>(
          create: (context) => MyTheme.light(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            scrollBehavior: MyCustomScrollBehavior(),
            title: 'Mafbase',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(useMaterial3: true).copyWith(
              scaffoldBackgroundColor: context.theme.background2,
              dividerTheme: const DividerThemeData(
                color: Color(0xFFCAC4D0),
                thickness: 1,
                space: 0,
                indent: 0,
                endIndent: 0,
              ),
              colorScheme:
                  ThemeData.light(useMaterial3: true).colorScheme.copyWith(
                        primary: MyTheme.of(context).darkGreyColor,
                        primaryContainer: MyTheme.of(context).darkBlueColor,
                        secondary: MyTheme.of(context).redColor,
                        secondaryContainer: MyTheme.of(context).redColor,
                      ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: context.theme.darkGreyColor,
                elevation: 5,
                backgroundColor: context.theme.darkBlueColor,
                selectedLabelStyle: const TextStyle().copyWith(
                  color: Colors.white,
                ),
                unselectedLabelStyle: const TextStyle().copyWith(
                  color: Colors.white,
                ),
                selectedIconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                unselectedIconTheme: const IconThemeData(
                  color: Colors.white60,
                ),
              ),
              iconTheme: IconThemeData(
                color: context.theme.darkGreyColor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return context.theme.btnTextStyle.copyWith(
                          color: context.theme.btnTextColor.withOpacity(
                            0.5,
                          ),
                        );
                      }

                      return context.theme.btnTextStyle;
                    },
                  ),
                ),
              ),
            ),
            routerDelegate: context.read<AppRouter>().router.routerDelegate,
            routeInformationProvider:
                context.read<AppRouter>().router.routeInformationProvider,
            routeInformationParser:
                context.read<AppRouter>().router.routeInformationParser,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
