import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/storage_factory.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/repositories/auth_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/cannot_meet_tournament_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/club_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/info_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/owners_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/players_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/purchase_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/tournament_edit_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/tournament_result_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/tournaments_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/translation_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/domain/repositories/cannot_meet_tournament_repository.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/domain/repositories/info_repository.dart';
import 'package:seating_generator_web/domain/repositories/owners_repository.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/domain/repositories/purchase_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournament_result_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournaments_repository.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/feature/custom_columns/data/repository/custom_columns_repository_impl.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/repository/custom_columns_repository.dart';
import 'package:seating_generator_web/feature/fantasy/data/fantasy_repository_impl.dart';
import 'package:seating_generator_web/feature/fantasy/domain/fantasy_repository.dart';
import 'package:seating_generator_web/feature/info_table_description/data/info_table_description_repository_impl.dart';
import 'package:seating_generator_web/feature/info_table_description/domain/info_table_description_repository.dart';
import 'package:seating_generator_web/feature/photo_themes/data/photo_theme_repository_impl.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/photo_theme_repository.dart';
import 'package:seating_generator_web/feature/player_statistics/data/repository/player_statistics_repository_impl.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/repository/player_statistics_repository.dart';
import 'package:seating_generator_web/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:seating_generator_web/feature/profile/domain/repository/profile_repository.dart';

class RepositoryFactory {
  final MyHttpClient client;
  final StorageFactory _storageFactory;

  RepositoryFactory(this.client, this._storageFactory);

  static RepositoryFactory of(BuildContext context) =>
      DependencyScope.of(context).repositoryFactory;

  // Existing repositories
  late final ProfileRepository profileRepository =
      ProfileRepositoryImpl(client);

  late final ClubRepository clubRepository = ClubRepositoryImpl(client);

  late final OwnersRepository ownersRepository = OwnersRepositoryImpl(client);

  late final CustomColumnsRepository customColumnsRepository =
      CustomColumnsRepositoryImpl(client);

  late final PlayerStatisticsRepository playerStatisticsRepository =
      PlayerStatisticsRepositoryImpl(client);

  late final PhotoThemeRepository photoThemeRepository =
      PhotoThemeRepositoryImpl(client);

  late final AuthRepository authRepository =
      AuthRepositoryImpl(client, _storageFactory.tokenStorage);

  late final TournamentsRepository tournamentsRepository =
      TournamentsRepositoryImpl(client);

  late final PlayersRepository playersRepository =
      PlayersRepositoryImpl(client);

  late final TranslationRepository translationRepository =
      TranslationRepositoryImpl(client);

  late final CannotMeetTournamentRepository cannotMeetTournamentRepository =
      CannotMeetTournamentRepositoryImpl(client);

  late final TournamentEditRepository tournamentEditRepository =
      TournamentEditRepositoryImpl(client);

  late final TournamentResultRepository tournamentResultRepository =
      TournamentResultRepositoryImpl(client);

  late final PurchaseRepository purchaseRepository =
      PurchaseRepositoryImpl(client);

  late final InfoRepository infoRepository = InfoRepositoryImpl(client);

  late final InfoTableDescriptionRepository infoTableDescriptionRepository =
      InfoTableDescriptionRepositoryImpl(client);

  late final FantasyRepository fantasyRepository =
      FantasyRepositoryImpl(client);
}
