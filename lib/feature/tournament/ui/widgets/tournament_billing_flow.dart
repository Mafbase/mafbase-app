import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_billing_dialog.dart';

/// Открывает [TournamentBillingDialog] по текущему состоянию турнира и отправляет выбор в [TournamentPageBloc].
Future<void> openTournamentBilling(BuildContext context, {bool preselectTranslation = false}) async {
  if (!context.mounted) return;

  final bloc = context.read<TournamentPageBloc>();
  final result = await TournamentBillingDialog.open(
    context: context,
    billedPlayers: bloc.state.billedPlayers,
    hasTranslation: bloc.state.billedTranslation,
    preselectTranslation: preselectTranslation,
  );
  if (result == null) return;

  bloc.add(
    TournamentPageEvent.bill(
      playersCount: result.billedPlayers,
      billedTranlsation: result.billedTranslation,
    ),
  );
}

/// Аккаунтам с hideBilling оплату не показываем.
bool isTournamentBillingVisible(BuildContext context) =>
    context.read<AuthNotifier?>()?.value.mapOrNull(authorized: (model) => !model.hideBilling) ?? true;
