import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:seating_generator_web/utils/platform.dart';

/// Убирает разовый query-параметр из адреса в браузере, чтобы обновление страницы не повторило действие.
/// Страница и открытые поверх неё окна остаются на месте.
void removeQueryParameterFromBrowserUrl(BuildContext context, String name) {
  if (!isWebPlatform) return;

  final urlState = context.router.urlState;
  final uri = urlState.uri;
  if (!uri.queryParameters.containsKey(name)) return;

  final query = Map.of(uri.queryParametersAll)..remove(name);
  // Замена маршрута в роутере пересоздала бы страницу и закрыла открытый диалог. Здесь меняется только адрес
  // текущей записи истории браузера; маршрут при следующем переходе сам сбросит query-параметры.
  SystemNavigator.routeInformationUpdated(
    uri: Uri(
      path: uri.path,
      queryParameters: query.isEmpty ? null : query,
      fragment: uri.fragment.isEmpty ? null : uri.fragment,
    ),
    state: urlState.pathState,
    replace: true,
  );
}
