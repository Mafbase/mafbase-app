import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_info_sheet.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_obs_links.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_stream_method_options.dart';
import 'package:seating_generator_web/feature/streams/ui/widgets/broadcast_app_required_view.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_billing_dialog.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_billing_flow.dart';
import 'package:seating_generator_web/feature/translation_links/translation_table_links.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/link_actions.dart';

/// Наполнение листа пункта по ключу: полная справка и картинки добавляются в [body].
class OrganizerChecklistItemContent {
  final BuildContext context;
  final int tournamentId;
  final ChecklistItemModel item;
  final OrganizerChecklistModel? checklist;

  const OrganizerChecklistItemContent(
    this.context, {
    required this.tournamentId,
    required this.item,
    this.checklist,
  });

  AppLocalizations get _locale => context.locale;

  bool get _isFsm => checklist?.isFsm ?? false;

  List<Widget> body() {
    final locale = _locale;

    return switch (item.key) {
      ChecklistKey.gamesCount => [
          Text(locale.checklistSheetGamesCountAbout),
          Text(locale.checklistSheetGamesCountSettings),
        ],
      ChecklistKey.players => [
          Text(locale.checklistSheetPlayersAbout),
          Text(_isFsm ? locale.checklistSheetPlayersFsm : locale.checklistSheetPlayersManual),
        ],
      ChecklistKey.seating => [
          Text(locale.checklistSheetSeatingAbout),
          Text(_isFsm ? locale.checklistSheetSeatingFsm : locale.checklistSheetSeatingGenerate),
        ],
      ChecklistKey.billing => [
          Text(locale.checklistSheetBillingAbout),
          Text(locale.checklistLockedNotificationsBilling),
        ],
      ChecklistKey.notifyCoverage => _notifyCoverageBody(),
      ChecklistKey.tableDescriptions => [
          Text(locale.checklistSheetTableDescriptionsAbout),
          if (item.isLocked)
            Text(locale.checklistLockedNotificationsBilling)
          else if (item.unavailable)
            Text(locale.checklistSheetUnavailable),
        ],
      ChecklistKey.streamMethod => [
          Text(locale.checklistSheetStreamMethodAbout),
          Text(locale.checklistSheetStreamMethodCommon),
          _streamMethodOptions(),
        ],
      ChecklistKey.translationBilling => [
          Text(locale.checklistLockedTranslationAbout),
          Text(locale.checklistLockedTranslationWays),
          Text(locale.checklistLockedTranslationSeating),
          if (!item.isDone && isTournamentBillingVisible(context)) Text(_translationPrice()),
        ],
      ChecklistKey.obsWidget => [
          Text(locale.checklistSheetObsWidgetAbout),
          Text(locale.checklistSheetObsWidgetScenes),
          if (item.status == ChecklistStatus.warning) Text(locale.checklistSheetObsWidgetWarning),
          if (item.isLocked)
            Text(locale.checklistSheetTranslationLocked)
          else ...[
            Text(locale.checklistSheetObsWidgetDone),
            _obsLinks(),
          ],
        ],
      ChecklistKey.obsScenes => [
          Text(locale.checklistSheetObsScenesAbout),
          Text(locale.checklistSheetObsScenesRights),
          if (item.isLocked) Text(locale.checklistSheetTranslationLocked),
        ],
      ChecklistKey.phoneStream => [
          Text(locale.streamsPhoneGuideStepCreate),
          Text(locale.checklistSheetPhoneWithoutBilling),
        ],
      ChecklistKey.phoneOperator => [
          Text(locale.checklistSheetPhoneOperatorSend),
          Text(locale.checklistSheetPhoneOperatorApp),
          Wrap(
            spacing: 8,
            children: [
              TextButton.icon(
                onPressed: () => openLinkInNewTab(mafbaseAppStoreUrl),
                icon: const Icon(Icons.open_in_new, size: 18),
                label: Text(locale.broadcastAppStore),
              ),
              TextButton.icon(
                onPressed: () => openLinkInNewTab(mafbaseRuStoreUrl),
                icon: const Icon(Icons.open_in_new, size: 18),
                label: Text(locale.broadcastRuStore),
              ),
            ],
          ),
          Text(locale.checklistSheetPhoneOperatorSelf),
        ],
    };
  }

  /// У заблокированного пункта вместо «Сделать» — оплата, которая его откроет.
  OrganizerChecklistInfoSheetAction? primaryAction() {
    final canPay = isTournamentBillingVisible(context);
    if (item.isLocked) {
      return canPay ? _pay(preselectTranslation: item.key.group == ChecklistGroup.translation) : null;
    }

    return switch (item.key) {
      ChecklistKey.gamesCount => _open(TournamentSettingsRoute(tournamentId: tournamentId)),
      ChecklistKey.players when _isFsm => _open(SeatingRoute(tournamentId: tournamentId, gomafia: 1)),
      ChecklistKey.players => _addPlayers(),
      ChecklistKey.seating => _open(SeatingRoute(tournamentId: tournamentId, gomafia: _isFsm ? 1 : null)),
      ChecklistKey.billing => canPay ? _pay() : null,
      ChecklistKey.notifyCoverage => _open(NotificationCoverageRoute(tournamentId: tournamentId)),
      ChecklistKey.tableDescriptions => _open(InfoTableDescriptionRoute(tournamentId: tournamentId)),
      ChecklistKey.translationBilling => canPay && !item.isDone ? _pay(preselectTranslation: true) : null,
      ChecklistKey.obsScenes => _openControlPage(),
      ChecklistKey.phoneStream || ChecklistKey.phoneOperator => _open(StreamsRoute(tournamentId: tournamentId)),
      ChecklistKey.streamMethod || ChecklistKey.obsWidget => null,
    };
  }

  OrganizerChecklistInfoSheetAction? dismissAction() {
    if (!item.key.canDismiss || item.isDismissed) return null;

    final bloc = context.read<OrganizerChecklistBloc>();
    final enough = item.key == ChecklistKey.notifyCoverage && !item.isLocked;
    return OrganizerChecklistInfoSheetAction(
      text: enough ? _locale.checklistSheetEnough : _locale.checklistSheetNotNeeded,
      onTap: () => bloc.add(OrganizerChecklistEventSetDismissed(keys: [item.key], dismissed: true)),
    );
  }

  List<Widget> _notifyCoverageBody() {
    final locale = _locale;
    if (item.isLocked) {
      return [
        Text(locale.checklistLockedNotificationsAbout),
        Text(locale.checklistLockedNotificationsChannels),
        Text(locale.checklistLockedNotificationsBilling),
      ];
    }

    return [
      Text(locale.checklistLockedNotificationsChannels),
      if (item.unavailable)
        Text(locale.checklistSheetUnavailable)
      else if ((item.current, item.total) case (final current?, final total?) when total > 0) ...[
        Text(locale.checklistSheetNotifyCoverageCount(current, total)),
        if (current < total) Text(locale.checklistSheetNotifyCoverageInvite),
      ],
    ];
  }

  Widget _streamMethodOptions() {
    final bloc = context.read<OrganizerChecklistBloc>();
    return OrganizerChecklistStreamMethodOptions(
      selected: checklist?.streamMethod,
      onSelect: (method) => bloc.add(OrganizerChecklistEventSelectStreamMethod(method)),
    );
  }

  String _translationPrice() {
    final billedPlayers = context.read<TournamentPageBloc>().state.billedPlayers;
    final price = calculatePrice(billedPlayers, true) - calculatePrice(billedPlayers, false);
    return _locale.checklistLockedTranslationPrice(billedPlayers, price);
  }

  Widget _obsLinks() {
    final players = context.read<TournamentPageBloc>().state.tournamentPlayers.length;
    return BlocProvider<SeatingPageBloc>.value(
      value: context.read<SeatingPageBloc>(),
      child: OrganizerChecklistObsLinks(
        tournamentId: tournamentId,
        tablesCount: item.total ?? players ~/ 10,
        onGoToSeating: () {
          if (context.mounted) context.router.navigate(SeatingRoute(tournamentId: tournamentId));
        },
      ),
    );
  }

  OrganizerChecklistInfoSheetAction _action(VoidCallback onTap) =>
      OrganizerChecklistInfoSheetAction(text: _locale.checklistSheetDo, onTap: onTap);

  OrganizerChecklistInfoSheetAction _open(PageRouteInfo route) => _action(() {
        if (context.mounted) context.router.push(route);
      });

  OrganizerChecklistInfoSheetAction _addPlayers() {
    final bloc = context.read<TournamentPageBloc>();
    return _action(() => bloc.add(const TournamentPageEvent.addPlayerTapped()));
  }

  OrganizerChecklistInfoSheetAction _pay({bool preselectTranslation = false}) => OrganizerChecklistInfoSheetAction(
        text: _locale.checklistSheetPay,
        onTap: () => openTournamentBilling(context, preselectTranslation: preselectTranslation),
      );

  /// Ключ запрашивается при открытии листа: в браузере новая вкладка должна открыться прямо по нажатию.
  OrganizerChecklistInfoSheetAction _openControlPage() {
    final keyFuture = RepositoryFactory.of(context).translationRepository.getKey(tournamentId: tournamentId);
    keyFuture.ignore();
    return _action(
      () => keyFuture.then(
        (key) {
          if (!context.mounted) return;
          openTranslationControl(
            context,
            TranslationTableLinks.tournament(tournamentId: tournamentId, table: 1, key: key.key),
          );
        },
        onError: (Object _) {},
      ),
    );
  }
}
