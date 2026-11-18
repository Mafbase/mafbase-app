import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/repositories/translation_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';

extension TranslationRepositoryDependency on DependencyScope {
  TranslationRepository get translationRepository =>
      resolve<TranslationRepository>(() => TranslationRepositoryImpl(client));
}
