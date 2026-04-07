import 'package:auto_route/auto_route.dart';
import 'package:seating_generator_web/app/guards/auth_guard.dart';
import 'package:seating_generator_web/app/guards/rail_wrapper_guard.dart';
import 'package:seating_generator_web/feature/administration_page/administration_page.dart';
import 'package:seating_generator_web/feature/club_games/club_games_page.dart';
import 'package:seating_generator_web/feature/custom_columns/ui/custom_columns_editor_page.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/edit_seating_page.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_page.dart';
import 'package:seating_generator_web/feature/info_table_description/ui/info_table_description_page.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_page.dart';
import 'package:seating_generator_web/feature/player_statistics/ui/player_stats_page.dart';
import 'package:seating_generator_web/feature/referee_assignments/ui/referee_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_settings_page.dart';
import 'package:seating_generator_web/feature/webview/web_view_screen.dart';
import 'package:seating_generator_web/ui/app_shell/app_shell.dart';
import 'package:seating_generator_web/ui/contacts/contacts_page.dart';
import 'package:seating_generator_web/ui/login/forgot_password_body/forgot_password_page_body.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/login/reset_password_body/reset_password_page_body.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_page_body.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_page_body.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/club_page/club_page.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_page.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_page.dart';
import 'package:seating_generator_web/ui/rail_wrapper/rail_wrapper.dart';
import 'package:seating_generator_web/ui/temp/temp_page.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Body|Screen,Route')
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;
  final RailWrapperGuard railWrapperGuard;

  AppRouter({required this.authGuard, required this.railWrapperGuard});

  @override
  List<AutoRoute> get routes => [
        // Standalone routes (no shell)
        AutoRoute(page: TempRoute.page, path: '/temp'),
        AutoRoute(page: TranslationControlRoute.page, path: '/translationControl'),
        AutoRoute(page: WebViewRoute.page, path: '/web-view'),

        // Redirect fragment-based deep links (/#/club → /club)
        RedirectRoute(path: '/', redirectTo: '/club'),

        // Shell route with auth guard
        AutoRoute(
          page: AppShellRoute.page,
          path: '',
          guards: [authGuard],
          children: [
            // Login route with sub-routes
            // LoginPageBody → LoginPageRoute (replaceInRouteName replaces 'Body' suffix)
            AutoRoute(
              page: LoginPageRoute.page,
              path: '/auth',
              children: [
                AutoRoute(page: SignUpPageRoute.page, path: 'signUp'),
                AutoRoute(page: VerificationPageRoute.page, path: 'verification/:id'),
                AutoRoute(page: ForgotPasswordPageRoute.page, path: 'forgotPassword'),
                AutoRoute(page: ResetPasswordPageRoute.page, path: 'resetPassword'),
              ],
            ),

            AutoRoute(page: ProfileRoute.page, path: '/profile'),
            AutoRoute(page: ContactsRoute.page, path: '/contacts'),
            AutoRoute(page: PlayerStatsRoute.page, path: '/player/:playerId/statistics'),
            // PhotoThemesPage reused at top-level (profile context) and under tournament
            AutoRoute(page: PhotoThemesRoute.page, path: '/photo-themes'),

            // RailWrapper (tabs: tournaments + clubs)
            AutoRoute(
              page: RailWrapperRoute.page,
              path: '',
              guards: [railWrapperGuard],
              children: [
                AutoRoute(page: TournamentsRoute.page, path: '/tournament'),
                AutoRoute(page: ClubsRoute.page, path: '/club'),
              ],
            ),

            // Club detail with sub-routes
            AutoRoute(
              page: ClubRoute.page,
              path: '/club/:clubId',
              children: [
                AutoRoute(page: AddClubGameRoute.page, path: 'addGame'),
                AutoRoute(page: AddClubGameRoute.page, path: 'game/:gameId'),
                AutoRoute(page: ClubGamesRoute.page, path: 'games'),
                AutoRoute(page: CustomColumnsEditorRoute.page, path: 'custom-columns'),
                // RatingPage reused for club rating and tournament rating
                AutoRoute(page: RatingRoute.page, path: 'rating'),
              ],
            ),

            // Tournament detail with sub-routes
            AutoRoute(
              page: TournamentRoute.page,
              path: '/tournament/:id',
              children: [
                AutoRoute(
                  page: SeatingRoute.page,
                  path: 'editSeating',
                  children: [
                    AutoRoute(page: EditSeatingRoute.page, path: 'manual'),
                  ],
                ),
                AutoRoute(page: AddClubGameRoute.page, path: 'editGame/:gameId'),
                // RatingPage reused for tournament rating
                AutoRoute(page: RatingRoute.page, path: 'rating'),
                AutoRoute(page: AdministrationRoute.page, path: 'administration'),
                AutoRoute(page: TournamentSettingsRoute.page, path: 'settings'),
                AutoRoute(page: FantasyRoute.page, path: 'fantasy'),
                AutoRoute(page: PhotoThemesRoute.page, path: 'photo-themes'),
                AutoRoute(page: InfoTableDescriptionRoute.page, path: 'table-descriptions'),
                AutoRoute(page: RefereeRoute.page, path: 'referees'),
              ],
            ),
          ],
        ),
      ];
}

enum MainPageTab { clubs, tournaments }
