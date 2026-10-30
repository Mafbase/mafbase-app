import 'package:auto_route/auto_route.dart';

extension FreshStackNavigation on StackRouter {
  /// В отличие от [navigatePath], не переиспользует уже открытые экраны: стек для [path] строится заново,
  /// и экраны вместе со своими блоками загружают данные с нуля.
  Future<void> navigatePathWithFreshStack(String path) {
    final matches = root.matcher.match(path, includePrefixMatches: true);
    if (matches == null) {
      return navigatePath(path, includePrefixMatches: true);
    }
    return root.replaceAll(
      matches.map(PageRouteInfo.fromMatch).toList(),
      updateExistingRoutes: false,
    );
  }
}
