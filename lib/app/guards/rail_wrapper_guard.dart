import 'package:auto_route/auto_route.dart';
import 'package:seating_generator_web/app/router.dart';

class RailWrapperGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final hasRailWrapper = router.stack.any(
      (entry) => entry.routeData.name == RailWrapperRoute.name,
    );
    if (!hasRailWrapper) {
      router.navigate(const RailWrapperRoute());
    }
    resolver.next(true);
  }
}
