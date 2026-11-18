import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/repositories/purchase_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/purchase_repository.dart';

extension PurchaseRepositoryDependency on DependencyScope {
  PurchaseRepository get purchaseRepository => resolve<PurchaseRepository>(() => PurchaseRepositoryImpl(client));
}
