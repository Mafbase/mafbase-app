import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/feature/tournament/ui/models/tournament_menu_models.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/custom_text_info_form.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/start_game_info_form.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_billing_dialog.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/translation_panel.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

import 'package:seating_generator_web/utils.dart';

class TournamentMenuBuilder {
  static List<TournamentMenuSection> buildSections(
    BuildContext context,
    TournamentPageState state,
    int tournamentId, {
    required bool showBill,
    required bool seatingLoading,
  }) {
    final locale = context.locale;
    final currentPath = context.router.currentUrl;
    final basePath = '/tournament/$tournamentId';

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
            context.router.navigateNamed('/tournament/$tournamentId/settings');
          },
        ),
      if (state.isMyTournament)
        TournamentMenuTapItem(
          text: locale.tournamentMenuAdmins,
          icon: Icons.admin_panel_settings_outlined,
          routeSegment: 'administration',
          selected: isActive('administration'),
          onTap: () {
            context.router.navigateNamed('/tournament/$tournamentId/administration');
          },
        ),
      if (state.isMyTournament)
        TournamentMenuTapItem(
          text: locale.referees,
          icon: Icons.gavel_outlined,
          routeSegment: 'referees',
          selected: isActive('referees'),
          onTap: () => context.router.navigateNamed('/tournament/$tournamentId/referees'),
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

            if (result != null) {
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
            context.router.navigateNamed('/tournament/$tournamentId/fantasy');
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
            context.router.navigateNamed('/tournament/$tournamentId/photo-themes');
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
    final totalGames = state.settings.totalGames;
    if (state.isMyTournament && state.notificationEnabled && !seatingLoading) {
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
        TournamentMenuTapItem(
          text: locale.tableDescriptionsTitle,
          icon: Icons.location_on_outlined,
          routeSegment: 'table-descriptions',
          selected: isActive('table-descriptions'),
          onTap: () => context.router.navigateNamed('/tournament/$tournamentId/table-descriptions'),
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
