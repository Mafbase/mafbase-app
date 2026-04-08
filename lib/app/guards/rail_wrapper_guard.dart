import 'package:auto_route/auto_route.dart';
import 'package:seating_generator_web/app/router.dart';

class RailWrapperGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.name == RailWrapperRoute.name) {
      return resolver.next(true);
    }

    final hasRailWrapper = router.stackData.any((route) {
      return route.name == RailWrapperRoute.name ||
          (route.route.children?.any((r) => r.name == RailWrapperRoute.name) ?? false);
    });
    if (!hasRailWrapper) {
      router.replaceAll([
        const RailWrapperRoute(),
        resolver.route.toPageRouteInfo(),
      ]);
      resolver.next(false);
    } else {
      resolver.next(true);
    }
  }
}
