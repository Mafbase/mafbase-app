import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/shared/billing/data/purchase_repository_impl.dart';
import 'package:seating_generator_web/shared/billing/domain/purchase_repository.dart';

extension PurchaseRepositoryDependency on DependencyScope {
  PurchaseRepository get purchaseRepository => resolve<PurchaseRepository>(() => PurchaseRepositoryImpl(client));
}
