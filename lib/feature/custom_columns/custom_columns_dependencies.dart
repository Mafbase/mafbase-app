import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/feature/custom_columns/data/repository/custom_columns_repository_impl.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/repository/custom_columns_repository.dart';

extension CustomColumnsDependencies on DependencyScope {
  CustomColumnsRepository get customColumnsRepository =>
      resolve<CustomColumnsRepository>(() => CustomColumnsRepositoryImpl(client));
}
