import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices =>
      super.dragDevices.toSet()..add(PointerDeviceKind.mouse);
}

void main() async {
  if (!kDebugMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn = sentryUrl;
        options.tracesSampleRate = 1.0;
      },
      appRunner: _startApp,
    );
  } else {
    _startApp();
  }
}

void _startApp() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    Hive.init(Directory.current.path);
  }

  registerGetIt();

  runApp(const App());
}

class App extends StatelessWidget {
  final String initLocation;

  const App({Key? key, this.initLocation = '/'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AppRouter(initLocation),
        ),
        Provider<MyTheme>(
          create: (context) => MyTheme.light(),
        )
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            scrollBehavior: MyCustomScrollBehavior(),
            title: 'Mafbase',
            theme: ThemeData.light(useMaterial3: true).copyWith(
              scaffoldBackgroundColor: context.theme.background2,
              navigationBarTheme: NavigationBarThemeData(
                indicatorColor: context.theme.darkBlueColor,
                backgroundColor: context.theme.darkGreyColor,
                labelTextStyle: MaterialStatePropertyAll(
                  const TextStyle().copyWith(color: context.theme.background1),
                ),
                iconTheme: MaterialStateProperty.all(
                  const IconThemeData(
                    color: Colors.white,
                  ),
                ),
              ),
              colorScheme:
                  ThemeData.light(useMaterial3: true).colorScheme.copyWith(
                        primary: MyTheme.of(context).darkGreyColor,
                        primaryContainer: MyTheme.of(context).darkBlueColor,
                        secondary: MyTheme.of(context).redColor,
                        secondaryContainer: MyTheme.of(context).redColor,
                      ),
              iconTheme: IconThemeData(
                color: context.theme.darkBlueColor,
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
