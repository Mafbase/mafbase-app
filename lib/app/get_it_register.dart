import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage_impl.dart';
import 'package:seating_generator_web/domain/interactors/add_club_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/add_photo_interactor.dart';
import 'package:seating_generator_web/domain/interactors/add_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/add_separation_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_separation_interactor.dart';
import 'package:seating_generator_web/domain/interactors/download_rating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/edit_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_ci_schemes_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_rating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_separations_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/insert_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/domain/interactors/verification_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
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
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository_mock.dart';
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
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_router.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_router.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog_bloc.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog_router.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_router.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_bloc.dart';

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
    ..registerLazySingleton<TournamentEditRepository>(
      () => TournamentEditRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()),
    )
    ..registerFactoryParam<LoginPageRouter, BuildContext, dynamic>(
      (context, _) => LoginPageRouterImpl(context),
    )
    ..registerFactoryParam<VerificationPageRouter, BuildContext, dynamic>(
      (context, _) => VerificationPageRouterImpl(context),
    )
    ..registerFactoryParam<MainPageRouter, BuildContext, dynamic>(
      (context, _) => MainPageRouterImpl(context),
    )
    ..registerFactoryParam<SignUpPageRouter, BuildContext, dynamic>(
      (context, _) => SignUpPageRouterImpl(context),
    )
    ..registerFactoryParam<SeatingPageRouter, BuildContext, dynamic>(
      (context, _) => SeatingPageRouterImpl(context),
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
    ..registerFactoryParam<ProfileDialogRouter, BuildContext, dynamic>(
      (context, _) => ProfileDialogRouterImpl(context),
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
    ..registerLazySingleton<TournamentEditRepository>(
      () => TournamentEditRepositoryMock(),
    )
    ..registerFactory<VerificationPageRouter>(
      () => VerificationPageRouterMock(),
    )
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
    ..registerLazySingleton<GetSeparationInteractor>(
      () => GetSeparationInteractor(getIt()),
    )
    ..registerLazySingleton<LoginInteractor>(() => LoginInteractor(getIt()))
    ..registerLazySingleton<SignUpInteractor>(() => SignUpInteractor(getIt()))
    ..registerLazySingleton<CreatePlayerInteractor>(
      () => CreatePlayerInteractor(getIt()),
    )
    ..registerLazySingleton<GetClubInteractor>(() => GetClubInteractor(getIt()))
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
    ..registerLazySingleton<CreateSeatingInteractor>(
      () => CreateSeatingInteractor(getIt()),
    )
    ..registerLazySingleton<GetTournamentsPlayersInteractor>(
      () => GetTournamentsPlayersInteractor(getIt()),
    )
    ..registerLazySingleton<AddTournamentPlayerInteractor>(
      () => AddTournamentPlayerInteractor(getIt()),
    )
    ..registerLazySingleton<InsertSeatingInteractor>(
      () => InsertSeatingInteractor(getIt()),
    )
    ..registerLazySingleton<GetTournamentsInteractor>(
      () => GetTournamentsInteractor(getIt()),
    )
    ..registerLazySingleton<AddSeparationInteractor>(
      () => AddSeparationInteractor(getIt()),
    )
    ..registerLazySingleton<DeleteSeparationInteractor>(
      () => DeleteSeparationInteractor(getIt()),
    )
    ..registerLazySingleton<GetCiSchemesInteractor>(
      () => GetCiSchemesInteractor(getIt()),
    )
    ..registerLazySingleton<CreateTournamentInteractor>(
      () => CreateTournamentInteractor(getIt()),
    )
    ..registerFactoryParam<LoginBloc, BuildContext?, dynamic>(
      (context, _) => LoginBloc(
        getIt(),
        getIt.call(param1: context),
        context,
      ),
    )
    ..registerFactoryParam<SeatingPageBloc, BuildContext?, dynamic>(
      (context, _) => SeatingPageBloc(
        context,
      ),
    )
    ..registerFactoryParam<TranslationContentBloc, BuildContext?,
        TranslationContentBlocParams>(
      (context, params) => TranslationContentBloc(params, context),
    )
    ..registerFactoryParam<ProfileDialogBloc, BuildContext?, PlayerModel>(
      (context, player) => ProfileDialogBloc(player, context),
    )
    ..registerLazySingleton<DownloadRatingInteractor>(
      () => DownloadRatingInteractor(getIt()),
    )
    ..registerLazySingleton<GetRatingInteractor>(
      () => GetRatingInteractor(getIt()),
    )
    ..registerLazySingleton<EditPlayerInteractor>(
      () => EditPlayerInteractor(getIt()),
    )
    ..registerLazySingleton<AddPhotoInteractor>(
      () => AddPhotoInteractor(getIt()),
    )
    ..registerFactoryParam<VerificationBloc, BuildContext?, int>(
      (context, id) {
        return VerificationBloc(getIt(param1: context), getIt(), id, context);
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
        context,
      ),
    )
    ..registerFactoryParam<TranslationControlBloc, BuildContext?,
        TranslationContentBlocParams>(
      (context, params) => TranslationControlBloc(params),
    )
    ..registerFactoryParam<TournamentsBloc, BuildContext?, dynamic>(
      (context, _) => TournamentsBloc(
        getIt(),
        context,
      ),
    )
    ..registerFactoryParam<SeatingInsertingBloc, BuildContext?, int>(
      (context, id) => SeatingInsertingBloc(
        getIt.get<SeatingInsertingRouter>(param1: context),
        id,
        context,
      ),
    )
    ..registerFactoryParam<TournamentPageBloc, BuildContext?, dynamic>(
      (context, _) => TournamentPageBloc(
        context: context,
      ),
    )
    ..registerFactoryParam<RatingBloc, BuildContext?, dynamic>(
      (context, _) => RatingBloc(context),
    );
}
