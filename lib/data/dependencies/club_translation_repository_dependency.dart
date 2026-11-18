import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/repositories/club_translation_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/club_translation_repository.dart';

extension ClubTranslationRepositoryDependency on DependencyScope {
  ClubTranslationRepository get clubTranslationRepository =>
      resolve<ClubTranslationRepository>(() => ClubTranslationRepositoryImpl(client));
}
