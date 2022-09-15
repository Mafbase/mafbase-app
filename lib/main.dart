import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
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
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateRoute: context.read<AppRouter>().onGenerateRoute,
            initialRoute: AppRoutes.loginPageRoute,
          );
        },
      ),
    );
  }
}
