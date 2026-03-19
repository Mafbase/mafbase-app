import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/feature/administration_page/administration_page.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_page.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_page.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/feature/tournament/ui/models/tournament_menu_models.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_settings_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/custom_text_info_form.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/start_game_info_form.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_billing_dialog.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/translation_panel.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentMenuBuilder {
  static List<TournamentMenuSection> buildSections(
    BuildContext context,
    TournamentPageState state,
    int tournamentId,
  ) {
    final locale = context.locale;
    final currentPath = GoRouterState.of(context).uri.path;
    final basePath = '/tournament/$tournamentId';
    final showBill = context.read<AuthNotifier>().value.mapOrNull(
              authorized: (model) => !model.hideBilling,
            ) ??
        true;

    bool isActive(String? routeSegment, {bool isDefault = false}) {
      if (routeSegment != null) {
        return currentPath.contains(routeSegment);
      }
      if (isDefault) {
        return currentPath == basePath || currentPath == '$basePath/';
      }
      return false;
    }

    final sections = <TournamentMenuSection>[];

    final mainItems = <TournamentMenuItemModel>[
      TournamentMenuTapItem(
        text: locale.tournamentPageListOfPlayers,
        icon: Icons.people_outline,
        selected: isActive(null, isDefault: true),
        onTap: () {
          context.read<TournamentPageBloc>().add(
                const TournamentPageEvent.playersListTapped(),
              );
        },
      ),
      if (state.isMyTournament)
        TournamentMenuTapItem(
          text: AppLocalizations.of(context)!.addPlayer,
          icon: Icons.person_add_outlined,
          onTap: () {
            context.read<TournamentPageBloc>().add(
                  const TournamentPageEvent.addPlayerTapped(),
                );
          },
        ),
      TournamentMenuTapItem(
        text: locale.seating,
        icon: Icons.grid_view_outlined,
        routeSegment: 'editSeating',
        selected: isActive('editSeating'),
        onTap: () {
          context.read<TournamentPageBloc>().add(
                const TournamentPageEvent.openSeatingPage(),
              );
        },
      ),
      TournamentMenuTapItem(
        text: locale.tournamentMenuTable,
        icon: Icons.table_chart_outlined,
        routeSegment: 'rating',
        selected: isActive('rating'),
        onTap: () {
          context.read<TournamentPageBloc>().add(
                const TournamentPageEvent.openRating(),
              );
        },
      ),
    ];
    sections.add(
      TournamentMenuSection(
        title: locale.tournamentMenuSectionMain,
        items: mainItems,
      ),
    );

    // УПРАВЛЕНИЕ
    final managementItems = <TournamentMenuItemModel>[
      if (state.isMyTournament && !state.isLoading)
        TournamentMenuTapItem(
          text: locale.tournamentSettingsTitle,
          icon: Icons.settings_outlined,
          routeSegment: 'settings',
          selected: isActive('settings'),
          onTap: () {
            context.go(
              TournamentSettingsPage.createLocation(
                tournamentId: tournamentId,
                context: context,
              ),
            );
          },
        ),
      if (state.isMyTournament)
        TournamentMenuTapItem(
          text: locale.tournamentMenuAdmins,
          icon: Icons.admin_panel_settings_outlined,
          routeSegment: 'administration',
          selected: isActive('administration'),
          onTap: () {
            context.go(
              AdministrationPage.createTournamentLocation(
                tournamentId: context.read<TournamentPageBloc>().tournamentId,
                context: context,
              ),
            );
          },
        ),
      if (state.isMyTournament && showBill && !state.isLoading)
        TournamentMenuTapItem(
          text: locale.tournamentMenuPayment,
          icon: Icons.payment_outlined,
          onTap: () async {
            final bloc = context.read<TournamentPageBloc>();
            final result = await TournamentBillingDialog.open(
              context: context,
              billedPlayers: state.billedPlayers,
              hasTranslation: state.billedTranslation,
            );
            if (result != null && context.mounted) {
              bloc.add(
                TournamentPageEvent.bill(
                  playersCount: result.billedPlayers,
                  billedTranlsation: result.billedTranslation,
                ),
              );
            }
          },
        ),
    ];
    if (managementItems.isNotEmpty) {
      sections.add(
        TournamentMenuSection(
          title: locale.tournamentMenuSectionManagement,
          items: managementItems,
        ),
      );
    }

    // ФУНКЦИИ
    final featureItems = <TournamentMenuItemModel>[
      if (!state.isLoading &&
          state.settings.fantasyStatus != null &&
          state.settings.fantasyStatus != FantasyStatus.disabled)
        TournamentMenuTapItem(
          text: locale.fantasy,
          icon: Icons.casino_outlined,
          routeSegment: 'fantasy',
          selected: isActive('fantasy'),
          onTap: () {
            context.go(
              FantasyPage.createTournamentLocation(
                tournamentId: tournamentId,
                context: context,
              ),
            );
          },
        ),
      if (state.billedTranslation && state.isMyTournament && !state.isLoading)
        TournamentMenuExpandableItem(
          text: locale.translationDialogTitle,
          icon: Icons.live_tv_outlined,
          contentBuilder: (onCollapse) => TranslationPanel(
            tournamentId: tournamentId,
            tablesCount: (state.tournamentPlayers.length / 10).floor(),
          ),
        ),
      if (state.isMyTournament)
        TournamentMenuTapItem(
          text: locale.photoThemesTitle,
          icon: Icons.photo_library_outlined,
          routeSegment: 'photo-themes',
          selected: isActive('photo-themes'),
          onTap: () {
            context.go(
              PhotoThemesPage.createTournamentLocation(
                tournamentId: tournamentId,
                context: context,
              ),
            );
          },
        ),
    ];
    if (featureItems.isNotEmpty) {
      sections.add(
        TournamentMenuSection(
          title: locale.tournamentMenuSectionFeatures,
          items: featureItems,
        ),
      );
    }

    // ОПОВЕЩЕНИЯ
    final totalGames = context.read<TournamentPageBloc>().state.settings.totalGames;
    final seatingLoading = context.read<SeatingPageBloc>().state.isLoading;
    if (totalGames > 0 && state.isMyTournament && state.notificationEnabled && !seatingLoading) {
      final notificationItems = <TournamentMenuItemModel>[
        TournamentMenuExpandableItem(
          text: locale.tournamentMenuGameNotification,
          icon: Icons.notifications_outlined,
          contentBuilder: (onCollapse) => StartGameInfoForm(
            maxGame: totalGames,
            onCollapse: onCollapse,
          ),
        ),
        TournamentMenuExpandableItem(
          text: locale.tournamentMenuTextNotification,
          icon: Icons.message_outlined,
          contentBuilder: (onCollapse) => CustomTextInfoForm(
            onCollapse: onCollapse,
          ),
        ),
      ];
      sections.add(
        TournamentMenuSection(
          title: locale.tournamentMenuSectionNotifications,
          items: notificationItems,
        ),
      );
    }

    return sections;
  }
}
