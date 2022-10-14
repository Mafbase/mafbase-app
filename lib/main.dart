import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  if (!kDebugMode) {
    await SentryFlutter.init(
          (options) {
        options.dsn =
        'https://9d5e563b2cf94d10b64bff4708a169dc@o4503907503570944.ingest.sentry.io/4503907504685056';
        options.tracesSampleRate = 1.0;
      },
      appRunner: _startApp,
    );
  } else {
    _startApp();
  }
}

void _startApp() {
  registerGetIt();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AppRouter(),
        ),
        Provider<MyTheme>(
          create: (context) => MyTheme.light(),
        )
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
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
