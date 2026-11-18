import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/guards/auth_guard.dart';
import 'package:seating_generator_web/app/guards/rail_wrapper_guard.dart';
import 'package:seating_generator_web/app/router.gr.dart';
import 'package:seating_generator_web/utils.dart';

export 'package:seating_generator_web/app/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Body|Screen,Route', deferredLoading: true)
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;
  final RailWrapperGuard railWrapperGuard;

  AppRouter({
    required this.authGuard,
    required this.railWrapperGuard,
    required this.navigatorKey,
  });

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  List<AutoRouteGuard> get guards => [authGuard];

  @override
  List<AutoRoute> get routes => [
        // Standalone routes (no shell)
        AutoRoute(page: TempRoute.page, path: '/temp'),
        AutoRoute(page: TranslationControlRoute.page, path: '/translationControl'),
        // Публичный резолвер диплинка оператора трансляции (без guards).
        AutoRoute(page: BroadcastRoute.page, path: '/broadcast'),
        AutoRoute(page: WebViewRoute.page, path: '/web-view'),
        AutoRoute(page: PaymentWaitingRoute.page, path: '/payment-waiting'),

        // Redirect fragment-based deep links (/#/club → /club)
        RedirectRoute(path: '/', redirectTo: '/club'),

        // Shell route with auth guard
        AutoRoute(
          page: AppShellRoute.page,
          path: '/',
          children: [
            AutoRoute(page: LoginPageRoute.page, path: 'auth'),
            AutoRoute(page: SignUpPageRoute.page, path: 'auth/signUp'),
            AutoRoute(page: VerificationPageRoute.page, path: 'auth/verification/:id'),
            AutoRoute(page: ForgotPasswordPageRoute.page, path: 'auth/forgotPassword'),
            AutoRoute(page: ResetPasswordPageRoute.page, path: 'auth/resetPassword'),

            AutoRoute(page: ProfileRoute.page, path: 'profile'),
            AutoRoute(page: ContactsRoute.page, path: 'contacts'),
            AutoRoute(page: PlayerStatsRoute.page, path: 'player/:playerId/statistics'),
            // PhotoThemesPage reused at top-level (profile context) and under tournament
            AutoRoute(page: PhotoThemesRoute.page, path: 'photo-themes'),

            // RailWrapper (tabs: tournaments + clubs)
            AutoRoute(
              page: RailWrapperRoute.page,
              path: '',
              guards: [railWrapperGuard],
              children: [
                AutoRoute(page: TournamentsRoute.page, path: 'tournament'),
                AutoRoute(page: ClubsRoute.page, path: 'club'),
              ],
            ),

            AutoRoute(page: AddClubRoute.page, path: 'club/add'),
            AutoRoute(page: ClubRoute.page, path: 'club/:clubId'),
            AutoRoute(page: NewClubGameRoute.page, path: 'club/:clubId/addGame'),
            AutoRoute(page: ClubGameDetailRoute.page, path: 'club/:clubId/game/:gameId'),
            AutoRoute(page: ClubGamesRoute.page, path: 'club/:clubId/games'),
            AutoRoute(page: CustomColumnsEditorRoute.page, path: 'club/:clubId/custom-columns'),
            AutoRoute(page: ClubRatingRoute.page, path: 'club/:clubId/rating'),
            AutoRoute(page: ClubStreamsRoute.page, path: 'club/:clubId/streams'),

            // Tournament detail with sub-routes
            AutoRoute(
              page: TournamentRoute.page,
              path: 'tournament/:id',
              children: [
                AutoRoute(page: TournamentPlayersRoute.page, path: ''),
                AutoRoute(page: SeatingRoute.page, path: 'editSeating'),
                AutoRoute(page: EditSeatingRoute.page, path: 'editSeating/manual'),
                AutoRoute(page: TournamentGameDetailRoute.page, path: 'editGame/:gameId'),
                AutoRoute(page: TournamentRatingRoute.page, path: 'rating'),
                AutoRoute(page: AdministrationRoute.page, path: 'administration'),
                AutoRoute(page: TournamentSettingsRoute.page, path: 'settings'),
                AutoRoute(page: FantasyRoute.page, path: 'fantasy'),
                AutoRoute(page: PhotoThemesTournamentRoute.page, path: 'photo-themes'),
                AutoRoute(page: InfoTableDescriptionRoute.page, path: 'table-descriptions'),
                AutoRoute(page: RefereeRoute.page, path: 'referees'),
                AutoRoute(page: StreamsRoute.page, path: 'streams'),
                AutoRoute(page: OrganizerChecklistRoute.page, path: 'checklist'),
                AutoRoute(page: NotificationCoverageRoute.page, path: 'notification-coverage'),
              ],
            ),
          ],
        ),
      ];
}

// ignore: avoid_classes_with_only_static_members
class AppRouterHelper {
  static void showErrorDialog(BuildContext context, String message) {
    if (message.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.locale.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.locale.cancel),
          ),
        ],
      ),
    );
  }
}

enum MainPageTab { clubs, tournaments }
