import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/shared/translation/data/translation_repository_impl.dart';
import 'package:seating_generator_web/shared/translation/domain/translation_repository.dart';

extension TranslationRepositoryDependency on DependencyScope {
  TranslationRepository get translationRepository =>
      resolve<TranslationRepository>(() => TranslationRepositoryImpl(client));
}
