import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/feature/payment_waiting/data/repository/payment_waiting_repository_impl.dart';
import 'package:seating_generator_web/feature/payment_waiting/domain/repository/payment_waiting_repository.dart';

extension PaymentWaitingDependencies on DependencyScope {
  PaymentWaitingRepository get paymentWaitingRepository =>
      resolve<PaymentWaitingRepository>(() => PaymentWaitingRepositoryImpl(client));
}
