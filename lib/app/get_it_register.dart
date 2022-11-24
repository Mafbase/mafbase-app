import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage_impl.dart';
import 'package:seating_generator_web/domain/interactors/add_club_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/add_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/insert_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/domain/interactors/verification_interactor.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository_mock.dart';
import 'package:seating_generator_web/domain/repositories/cannot_meet_tournament_repository.dart';
import 'package:seating_generator_web/domain/repositories/cannot_meet_tournament_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/cannot_meet_tournament_repository_mock.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/domain/repositories/club_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/club_repository_mock.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/domain/repositories/players_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/players_repository_mock.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository_mock.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository_mock.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_bloc.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_bloc.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_router.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_bloc.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_router.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_router.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_router.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';

GetIt getIt = GetIt.instance;

void registerGetIt() {
  getIt
    ..registerLazySingleton<TokenStorage>(() => TokenStorageImpl())
    ..registerLazySingleton<MyHttpClient>(
      () => kReleaseMode
          ? MyHttpClient.autoForWeb(getIt())
          : MyHttpClient.withDefaultUrl(getIt()),
    )
    ..registerFactoryParam<RatingRouter, BuildContext, void>(
      (context, _) => RatingRouterImpl(context),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()),
    )
    ..registerFactoryParam<LoginPageRouter, BuildContext, dynamic>(
      (context, _) => LoginPageRouterImpl(context),
    )
    ..registerFactoryParam<VerificationPageRouter, BuildContext, dynamic>(
        (context, _) => VerificationPageRouterImpl(context))
    ..registerFactoryParam<MainPageRouter, BuildContext, dynamic>(
      (context, _) => MainPageRouterImpl(context),
    )
    ..registerFactoryParam<SignUpPageRouter, BuildContext, dynamic>(
      (context, _) => SignUpPageRouterImpl(context),
    )
    ..registerFactoryParam<SeatingInsertingRouter, BuildContext, dynamic>(
      (context, _) => SeatingInsertingRouterImpl(context),
    )
    ..registerFactoryParam<TournamentPageRouter, BuildContext, dynamic>(
      (context, _) => TournamentPageRouterImpl(context),
    )
    ..registerLazySingleton<TournamentsRepository>(
      () => TournamentsRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<TranslationRepository>(
      () => TranslationRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<CannotMeetTournamentRepository>(
      () => CannotMeetTournamentRepositoryImpl(getIt()),
    )
    ..registerFactoryParam<AddClubGameRouter, BuildContext, dynamic>(
      (context, _) => AddClubGameRouterImpl(context),
    )
    ..registerLazySingleton<PlayersRepository>(
      () => PlayersRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<ClubRepository>(() => ClubRepositoryImpl(getIt()));
  _registerSharedGetIt();
}

@visibleForTesting
void registerGetItTest() {
  getIt
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryMock())
    ..registerFactory<LoginPageRouter>(() => LoginPageRouterMock())
    ..registerLazySingleton<ClubRepository>(() => ClubRepositoryMock())
    ..registerFactory<SignUpPageRouter>(() => SignUpPageRouterMock())
    ..registerFactory<MainPageRouter>(() => MainPageRouterMock())
    ..registerFactory<VerificationPageRouter>(
        () => VerificationPageRouterMock())
    ..registerLazySingleton<TranslationRepository>(
      () => TranslationRepositoryMock(),
    )
    ..registerLazySingleton<TournamentsRepository>(
      () => TournamentsRepositoryMock(),
    )
    ..registerFactory<SeatingInsertingRouter>(
      () => SeatingInsertingRouterMock(),
    )
    ..registerLazySingleton<CannotMeetTournamentRepository>(
      () => CannotMeetTournamentRepositoryMock(),
    )
    ..registerLazySingleton<PlayersRepository>(
      () => PlayersRepositoryMock(),
    );
  _registerSharedGetIt();
}

void _registerSharedGetIt() {
  getIt
    ..registerLazySingleton<LoginInteractor>(() => LoginInteractor(getIt()))
    ..registerLazySingleton<SignUpInteractor>(() => SignUpInteractor(getIt()))
    ..registerLazySingleton<AddClubGameInteractor>(
      () => AddClubGameInteractor(),
    )
    ..registerLazySingleton<VerificationInteractor>(
      () => VerificationInteractor(getIt()),
    )
    ..registerLazySingleton<GetAllPlayersInteractor>(
      () => GetAllPlayersInteractor(getIt()),
    )
    ..registerLazySingleton<DeletePlayerInteractor>(
      () => DeletePlayerInteractor(getIt()),
    )
    ..registerLazySingleton<GetTournamentsPlayersInteractor>(
      () => GetTournamentsPlayersInteractor(getIt()),
    )
    ..registerLazySingleton<AddPlayerInteractor>(
      () => AddPlayerInteractor(getIt()),
    )
    ..registerLazySingleton<InsertSeatingInteractor>(
      () => InsertSeatingInteractor(getIt()),
    )
    ..registerLazySingleton<GetTournamentsInteractor>(
      () => GetTournamentsInteractor(getIt()),
    )
    ..registerFactoryParam<LoginBloc, BuildContext?, dynamic>(
      (context, _) => LoginBloc(
        getIt(),
        getIt.call(param1: context),
        context,
      ),
    )
    ..registerFactoryParam<TranslationContentBloc, BuildContext?,
        TranslationContentBlocParams>(
      (context, params) => TranslationContentBloc(params, context),
    )
    ..registerFactoryParam<VerificationBloc, BuildContext?, int>(
      (context, id) {
        try {
          return VerificationBloc(getIt(param1: context), getIt(), id, context);
        } catch(e, stacktrace) {
          debugPrint(e.toString());
          debugPrintStack(stackTrace: stacktrace);
          rethrow;
        }
      },
    )
    ..registerFactoryParam<SignUpBloc, BuildContext?, dynamic>(
      (context, _) => SignUpBloc(
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
    ..registerFactoryParam<TournamentsBloc, BuildContext?, dynamic>(
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
    )
    ..registerFactoryParam<TournamentPageBloc, BuildContext?, int>(
      (context, tournamentId) => TournamentPageBloc(
        tournamentId: tournamentId,
        context: context,
      ),
    )
    ..registerFactoryParam<RatingBloc, BuildContext?, dynamic>(
      (context, _) => RatingBloc(context),
    );
}
