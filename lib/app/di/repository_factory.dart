import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/repositories/club_repository_impl.dart';
import 'package:seating_generator_web/data/repositories/owners_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/domain/repositories/owners_repository.dart';
import 'package:seating_generator_web/feature/custom_columns/data/repository/custom_columns_repository_impl.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/repository/custom_columns_repository.dart';
import 'package:seating_generator_web/feature/player_statistics/data/repository/player_statistics_repository_impl.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/repository/player_statistics_repository.dart';
import 'package:seating_generator_web/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:seating_generator_web/feature/profile/domain/repository/profile_repository.dart';

class RepositoryFactory {
  final MyHttpClient client;

  RepositoryFactory(this.client);

  static RepositoryFactory of(BuildContext context) =>
      DependencyScope.of(context).repositoryFactory;

  late final ProfileRepository profileRepository =
      ProfileRepositoryImpl(client);

  late final ClubRepository clubRepository = ClubRepositoryImpl(client);

  late final OwnersRepository ownersRepository = OwnersRepositoryImpl(client);

  late final CustomColumnsRepository customColumnsRepository =
      CustomColumnsRepositoryImpl(client);

  late final PlayerStatisticsRepository playerStatisticsRepository =
      PlayerStatisticsRepositoryImpl(client);
}
