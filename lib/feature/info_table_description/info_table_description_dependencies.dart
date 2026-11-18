import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/feature/info_table_description/data/info_table_description_repository_impl.dart';
import 'package:seating_generator_web/feature/info_table_description/domain/info_table_description_repository.dart';

extension InfoTableDescriptionDependencies on DependencyScope {
  InfoTableDescriptionRepository get infoTableDescriptionRepository =>
      resolve<InfoTableDescriptionRepository>(() => InfoTableDescriptionRepositoryImpl(client));
}
