import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/domain/repositories/cannot_meet_tournament_repository.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/ui/login/login_bloc.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_bloc.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_bloc.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_router.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_router.dart';
import 'repositories/auth_repository_mock.mocks.dart';
import 'repositories/cannot_meet_tournament_repository_mock.mocks.dart';
import 'repositories/club_repository_mock.dart';
import 'repositories/players_repository_mock.dart';
import 'repositories/tournament_edit_repository_mock.dart';
import 'repositories/tournaments_repository_mock.dart';
import 'repositories/translation_repository_mock.dart';
import 'routers/login_router_mock.dart';
import 'routers/main_router_mock.dart';
import 'routers/seating_inserting_router_mock.dart';
import 'routers/sign_up_router_mock.dart';
import 'routers/tournaments_router_mock.dart';
import 'routers/verification_router_mock.dart';
import 'storages/credential_storage_mock.dart';

void registerGetItTest() {
  getIt
    ..registerLazySingleton<AuthRepository>(() => MockAuthRepository())
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
    ..registerFactory<TournamentsRouter>(() => TournamentsRouterMock())
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
      () => MockCannotMeetTournamentRepository(),
    )
    ..registerLazySingleton<PlayersRepository>(
      () => PlayersRepositoryMock(),
    )
    ..registerLazySingleton<CredentialStorage>(
      () => CredentialStorageMock(),
    );
  registerSharedGetIt();
}
