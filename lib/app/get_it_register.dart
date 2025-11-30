import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/repositories/auth_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/cannot_meet_tournament_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/club_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/info_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/players_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/purchase_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/tournament_edit_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/tournament_result_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/tournaments_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/translation_repository_impl.dart';
import 'package:seating_generator_web/data/storages/credential_secure_storage_impl.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/data/storages/token_in_memory_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage_hive_impl.dart';
import 'package:seating_generator_web/data/storages/token_storage_impl.dart';
import 'package:seating_generator_web/domain/interactors/add_club_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/add_photo_interactor.dart';
import 'package:seating_generator_web/domain/interactors/add_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/add_separation_interactor.dart';
import 'package:seating_generator_web/domain/interactors/bill_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/bill_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/check_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/custom_text_info_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_separation_interactor.dart';
import 'package:seating_generator_web/domain/interactors/download_rating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/edit_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/edit_tournament_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/generate_final_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_ci_schemes_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_clubs_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_final_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_my_tournaments_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_rating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_separations_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_settings_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournament_game_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournament_rating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/insert_seating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/domain/interactors/set_final_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/domain/interactors/start_game_info_interactor.dart';
import 'package:seating_generator_web/domain/interactors/tournament_check_interactor.dart';
import 'package:seating_generator_web/domain/interactors/update_settings_interactor.dart';
import 'package:seating_generator_web/domain/interactors/verification_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/domain/repositories/cannot_meet_tournament_repository.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/domain/repositories/info_repository.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/domain/repositories/purchase_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournament_result_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/feature/info_table_description/data/info_table_description_repository_impl.dart';
import 'package:seating_generator_web/feature/info_table_description/domain/info_table_description_repository.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_bloc.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_bloc.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_router.dart';
import 'package:seating_generator_web/ui/main/club_page/club_bloc.dart';
import 'package:seating_generator_web/ui/main/club_page/club_router.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_bloc.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_router.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_bloc.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_router.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_state.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_router.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_router.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_router.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog_bloc.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog_router.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_router.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_bloc.dart';

GetIt getIt = GetIt.instance;
const _useHiveStorage = true;

void registerGetIt({bool isIntegrationTest = false}) {
  getIt
    ..registerLazySingleton<TokenStorage>(
      () =>
          isIntegrationTest ? TokenInMemoryStorage() : (_useHiveStorage ? TokenStorageHiveImpl() : TokenStorageImpl()),
    )
    ..registerLazySingleton<CredentialStorage>(
      () => CredentialSecureStorageImpl(),
    )
    ..registerLazySingleton<MyHttpClient>(
      () => kReleaseMode && kIsWeb
          ? MyHttpClient.autoForWeb(getIt(), getIt())
          : MyHttpClient.withDefaultUrl(getIt(), getIt()),
    )
    ..registerFactoryParam<RatingRouter, BuildContext, void>(
      (context, _) => RatingRouterImpl(context),
    )
    ..registerLazySingleton<InfoRepository>(() => InfoRepositoryImpl(getIt()))
    ..registerLazySingleton<StartGameInfoInteractor>(
      () => StartGameInfoInteractor(getIt()),
    )
    ..registerLazySingleton<CustomTextInfoInteractor>(
      () => CustomTextInfoInteractor(getIt()),
    )
    ..registerLazySingleton<EditTournamentGameInteractor>(
      () => EditTournamentGameInteractor(
        getIt(),
      ),
    )
    ..registerLazySingleton<TournamentResultRepository>(
      () => TournamentResultRepositoryImpl(
        getIt(),
      ),
    )
    ..registerLazySingleton<GetTournamentGameInteractor>(
      () => GetTournamentGameInteractor(
        getIt(),
      ),
    )
    ..registerLazySingleton<GetTournamentRatingInteractor>(
      () => GetTournamentRatingInteractor(getIt()),
    )
    ..registerLazySingleton<TournamentEditRepository>(
      () => TournamentEditRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<PurchaseRepository>(
      () => PurchaseRepositoryImpl(getIt()),
    )
    ..registerFactoryParam<BillTournamentInteractor, BuildContext, dynamic>(
      (context, _) => BillTournamentInteractor(getIt(), context),
    )
    ..registerLazySingleton<GetTournamentInteractor>(
      () => GetTournamentInteractor(getIt()),
    )
    ..registerFactoryParam<ClubsRouter, BuildContext, dynamic>(
      (context, _) => ClubsRouterImpl(context),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()),
    )
    ..registerFactoryParam<ClubRouter, BuildContext, dynamic>(
      (context, _) => ClubRouterImpl(context),
    )
    ..registerFactoryParam<LoginPageRouter, BuildContext, String?>(
      (context, nextPath) => LoginPageRouterImpl(context, nextPath),
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
    ..registerFactoryParam<TournamentsRouter, BuildContext, dynamic>(
      (context, _) => TournamentsRouterImpl(context),
    )
    ..registerLazySingleton<ClubRepository>(
      () => ClubRepositoryImpl(getIt()),
    );
  registerSharedGetIt();
}

@visibleForTesting
void registerSharedGetIt() {
  getIt
    ..registerLazySingleton<GetSeparationInteractor>(
      () => GetSeparationInteractor(getIt()),
    )
    ..registerLazySingleton<LoginInteractor>(
      () => LoginInteractor(
        getIt(),
        getIt(),
      ),
    )
    ..registerLazySingleton<SetFinalPlayersInteractor>(
      () => SetFinalPlayersInteractor(getIt()),
    )
    ..registerLazySingleton<GetFinalPlayersInteractor>(
      () => GetFinalPlayersInteractor(getIt()),
    )
    ..registerLazySingleton<GenerateFinalSeatingInteractor>(
      () => GenerateFinalSeatingInteractor(getIt()),
    )
    ..registerLazySingleton<CheckClubInteractor>(
      () => CheckClubInteractor(getIt()),
    )
    ..registerFactoryParam<ClubBloc, BuildContext?, ClubBlocArgs>(
      (context, args) => ClubBloc(
        getClubInteractor: getIt(),
        billClubInteractor: getIt(),
        checkClubInteractor: getIt(),
        clubRepository: getIt(),
        router: getIt(param1: context),
        args: args,
        context: context,
      ),
    )
    ..registerFactoryParam<ClubsBloc, BuildContext?, dynamic>(
      (context, _) => ClubsBloc(
        context: context,
        getClubsInteractor: getIt(),
        router: getIt(param1: context),
      ),
    )
    ..registerLazySingleton<SignUpInteractor>(() => SignUpInteractor(getIt()))
    ..registerLazySingleton<CreatePlayerInteractor>(
      () => CreatePlayerInteractor(getIt()),
    )
    ..registerLazySingleton<GetSeatingInteractor>(
      () => GetSeatingInteractor(getIt()),
    )
    ..registerLazySingleton<GetClubInteractor>(() => GetClubInteractor(getIt()))
    ..registerLazySingleton<AddClubGameInteractor>(
      () => AddClubGameInteractor(),
    )
    ..registerLazySingleton<VerificationInteractor>(
      () => VerificationInteractor(getIt()),
    )
    ..registerLazySingleton<GetMyTournamentsInteractor>(
      () => GetMyTournamentsInteractor(getIt()),
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
    ..registerLazySingleton<TournamentCheckInteractor>(
      () => TournamentCheckInteractor(getIt()),
    )
    ..registerFactoryParam<LoginBloc, BuildContext?, String?>(
      (context, nextPath) => LoginBloc(
        getIt(),
        getIt.call(param1: context, param2: nextPath),
        context,
      ),
    )
    ..registerFactoryParam<SeatingPageBloc, BuildContext?, dynamic>(
      (context, _) => SeatingPageBloc(
        context,
      ),
    )
    ..registerFactoryParam<TranslationContentBloc, BuildContext?, TranslationContentBlocParams>(
      (context, params) => TranslationContentBloc(params, context),
    )
    ..registerFactoryParam<ProfileDialogBloc, BuildContext?, PlayerModel>(
      (context, player) => ProfileDialogBloc(player, context),
    )
    ..registerFactoryParam<SeatingPageDialogBloc, List<String>, BuildContext?>(
      (param1, param2) => SeatingPageDialogBloc(
        SeatingPageDialogState(notFound: param1),
        getIt(),
        param2,
      ),
    )
    ..registerLazySingleton<DownloadRatingInteractor>(
      () => DownloadRatingInteractor(getIt()),
    )
    ..registerLazySingleton<GetRatingInteractor>(
      () => GetRatingInteractor(getIt()),
    )
    ..registerLazySingleton<LogoutInteractor>(
      () => LogoutInteractor(
        getIt<TokenStorage>(),
        getIt<AuthNotifier>(),
        getIt<CredentialStorage>(),
      ),
    )
    ..registerLazySingleton(() => AuthNotifier())
    ..registerLazySingleton<GetClubsInteractor>(
      () => GetClubsInteractor(getIt()),
    )
    ..registerLazySingleton<EditPlayerInteractor>(
      () => EditPlayerInteractor(getIt()),
    )
    ..registerLazySingleton<AddPhotoInteractor>(
      () => AddPhotoInteractor(getIt()),
    )
    ..registerLazySingleton<BillClubInteractor>(
      () => BillClubInteractor(
        getIt(),
      ),
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
      (context, tab) => MainBloc(
        getIt.get<MainPageRouter>(param1: context),
        context,
      ),
    )
    ..registerFactoryParam<TranslationControlBloc, BuildContext?, TranslationContentBlocParams>(
      (context, params) => TranslationControlBloc(params),
    )
    ..registerFactoryParam<TournamentsBloc, BuildContext?, dynamic>(
      (context, _) => TournamentsBloc(
        getIt(),
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
    ..registerFactoryParam<TournamentPageBloc, BuildContext?, int>(
      (context, tournamentId) => TournamentPageBloc(
        context: context,
        tournamentId: tournamentId,
      ),
    )
    ..registerFactoryParam<RatingBloc, BuildContext?, dynamic>((context, _) => RatingBloc(context))
    ..registerLazySingleton<GetSettingsInteractor>(() => GetSettingsInteractor(getIt()))
    ..registerLazySingleton<UpdateSettingsInteractor>(() => UpdateSettingsInteractor(getIt()))
    ..registerLazySingleton<InfoTableDescriptionRepository>(() => InfoTableDescriptionRepositoryImpl(getIt()));
}
