import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/app/assembly.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AppRouter(AppAssembly()),
        ),
        Provider<MyTheme>(
          create: (context) => MyTheme.light(),
        )
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          onGenerateRoute: context.read<AppRouter>().onGenerateRoute,
          initialRoute: AppRoutes.loginPageRoute,
        );
      }),
    );
  }
}
