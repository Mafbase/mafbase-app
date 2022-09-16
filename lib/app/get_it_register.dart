import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage_impl.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository_mock.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository_mock.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';

GetIt getIt = GetIt.instance;

void registerGetIt() {
  getIt
    ..registerLazySingleton<TokenStorage>(() => TokenStorageImpl())
    ..registerLazySingleton<MyHttpClient>(
      () => MyHttpClient.withDefaultUrl(
        getIt(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()),
    )
    ..registerFactoryParam<LoginPageRouter, BuildContext, dynamic>(
      (context, _) => LoginPageRouterImpl(context),
    )
    ..registerFactoryParam<MainPageRouter, BuildContext, dynamic>(
      (context, _) => MainPageRouterImpl(context),
    )
    ..registerLazySingleton<TournamentsRepository>(
        () => TournamentsRepositoryImpl(getIt()));
  _registerSharedGetIt();
}

@visibleForTesting
void registerGetItTest() {
  getIt
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryMock())
    ..registerFactory<LoginPageRouter>(() => LoginPageRouterMock())
    ..registerFactory<MainPageRouter>(() => MainPageRouterMock())
    ..registerLazySingleton<TournamentsRepository>(
      () => TournamentsRepositoryMock(),
    );
  _registerSharedGetIt();
}

void _registerSharedGetIt() {
  getIt
    ..registerLazySingleton<LoginInteractor>(() => LoginInteractor(getIt()))
    ..registerLazySingleton<SignUpInteractor>(() => SignUpInteractor(getIt()))
    ..registerLazySingleton<GetTournamentsInteractor>(
      () => GetTournamentsInteractor(getIt()),
    )
    ..registerFactoryParam<LoginBloc, BuildContext?, dynamic>(
      (context, _) => LoginBloc(
        getIt(),
        getIt(),
        getIt.call(param1: context),
      ),
    )
    ..registerFactoryParam<MainBloc, BuildContext?, dynamic>(
      (context, _) => MainBloc(
        getIt.get<MainPageRouter>(param1: context),
        getIt(),
      ),
    );
}
