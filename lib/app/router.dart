import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/login_page.dart';

class AppRouter {
  AppRouter();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginPageRoute:
        return _createBaseRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<LoginBloc>(param1: context),
            child: const LoginPage(),
          ),
        );
      default:
        return _createBaseRoute(
          builder: (context) => Container(),
        ); // TODO: create error route
    }
  }

  Route _createBaseRoute({required WidgetBuilder builder}) {
    return MaterialPageRoute(builder: builder);
  }
}

class AppRoutes {
  static const loginPageRoute = '/login';
}
