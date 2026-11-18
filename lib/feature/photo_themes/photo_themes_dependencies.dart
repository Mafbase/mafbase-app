import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/feature/photo_themes/data/photo_theme_repository_impl.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/photo_theme_repository.dart';

extension PhotoThemesDependencies on DependencyScope {
  PhotoThemeRepository get photoThemeRepository =>
      resolve<PhotoThemeRepository>(() => PhotoThemeRepositoryImpl(client));
}
