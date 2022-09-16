import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainPageRouter _router;

  MainBloc(
    this._router,
  ) : super(
          const MainState.tournaments(
            isLoading: true,
            tournaments: [],
          ),
        );
}

abstract class MainPageRouter {}

class MainPageRouterImpl implements MainPageRouter {
  final BuildContext context;

  MainPageRouterImpl(this.context);
}

class MainPageRouterMock implements MainPageRouter {}
