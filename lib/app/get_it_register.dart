import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage_impl.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/domain/interactors/insert_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository_mock.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository_mock.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository_mock.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_router.dart';

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
    ..registerFactoryParam<LoginPageRouter, BuildContext, dynamic>(
      (context, _) => LoginPageRouterImpl(context),
    )
    ..registerFactoryParam<MainPageRouter, BuildContext, dynamic>(
      (context, _) => MainPageRouterImpl(context),
    )
    ..registerFactoryParam<SeatingInsertingRouter, BuildContext, dynamic>(
      (context, _) => SeatingInsertingRouterImpl(context),
    )
    ..registerLazySingleton<TournamentsRepository>(
      () => TournamentsRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<TranslationRepository>(
      () => TranslationRepositoryImpl(getIt()),
    );
  _registerSharedGetIt();
}

@visibleForTesting
void registerGetItTest() {
  getIt
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryMock())
    ..registerFactory<LoginPageRouter>(() => LoginPageRouterMock())
    ..registerFactory<MainPageRouter>(() => MainPageRouterMock())
    ..registerLazySingleton<TranslationRepository>(
      () => TranslationRepositoryMock(),
    )
    ..registerLazySingleton<TournamentsRepository>(
      () => TournamentsRepositoryMock(),
    )
    ..registerFactory<SeatingInsertingRouter>(
      () => SeatingInsertingRouterMock(),
    );
  _registerSharedGetIt();
}

void _registerSharedGetIt() {
  getIt
    ..registerLazySingleton<LoginInteractor>(() => LoginInteractor(getIt()))
    ..registerLazySingleton<SignUpInteractor>(() => SignUpInteractor(getIt()))
    ..registerLazySingleton<InsertSeatingInteractor>(
      () => InsertSeatingInteractor(getIt()),
    )
    ..registerLazySingleton<GetTournamentsInteractor>(
      () => GetTournamentsInteractor(getIt()),
    )
    ..registerFactoryParam<LoginBloc, BuildContext?, dynamic>(
      (context, _) => LoginBloc(
        getIt(),
        getIt(),
        getIt.call(param1: context),
        context,
      ),
    )
    ..registerFactoryParam<MainBloc, BuildContext?, dynamic>(
      (context, _) => MainBloc(
        getIt.get<MainPageRouter>(param1: context),
      ),
    )
    ..registerFactoryParam<TournamentsBloc, BuildContext, dynamic>(
      (context, _) => TournamentsBloc(
        getIt(),
        context,
      ),
    )
    ..registerFactoryParam<SeatingInsertingBloc, BuildContext?, dynamic>(
      (context, _) => SeatingInsertingBloc(
        getIt.get<SeatingInsertingRouter>(param1: context),
        getIt(),
      ),
    );
}
