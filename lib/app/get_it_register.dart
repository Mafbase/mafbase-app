import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage_impl.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository_mock.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';

GetIt getIt = GetIt.instance;

void registerGetIt() {
  getIt
    ..registerLazySingleton<TokenStorage>(() => TokenStorageImpl())
    ..registerLazySingleton<MyHttpClient>(
      () => MyHttpClient.autoForWeb(
        getIt(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()),
    )
    ..registerFactoryParam<LoginBlocNavigation, BuildContext, dynamic>(
      (context, _) => LoginBlocNavigationImpl(context),
    );
  _registerSharedGetIt();
}

@visibleForTesting
void registerGetItTest() {
  getIt
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryMock())
    ..registerFactory<LoginBlocNavigation>(() => LoginBlocNavigationMock());
  _registerSharedGetIt();
}

void _registerSharedGetIt() {
  getIt
    ..registerLazySingleton<LoginInteractor>(() => LoginInteractor(getIt()))
    ..registerLazySingleton<SignUpInteractor>(() => SignUpInteractor(getIt()))
    ..registerFactoryParam<LoginBloc, BuildContext?, dynamic>(
      (context, _) => LoginBloc(
        getIt(),
        getIt(),
        getIt.call(param1: context),
      ),
    );
}
