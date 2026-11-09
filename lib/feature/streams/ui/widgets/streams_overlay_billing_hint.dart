import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_billing_flow.dart';
import 'package:seating_generator_web/utils.dart';

/// Напоминание на «Трансляциях» турнира: без оплаченных плашек стрим идёт без них.
class StreamsOverlayBillingHint extends StatelessWidget {
  const StreamsOverlayBillingHint({super.key});

  static bool _isVisible(TournamentPageState state, bool showBill) =>
      showBill && state.isMyTournament && state.isBillingLoaded && !state.billedTranslation;

  @override
  Widget build(BuildContext context) {
    final showBill = context.read<AuthNotifier>().value.mapOrNull(
              authorized: (model) => !model.hideBilling,
            ) ??
        true;

    return BlocBuilder<TournamentPageBloc, TournamentPageState>(
      buildWhen: (previous, current) => _isVisible(previous, showBill) != _isVisible(current, showBill),
      builder: (context, state) {
        if (!_isVisible(state, showBill)) return const SizedBox.shrink();

        final theme = MyTheme.of(context);
        final locale = context.locale;

        return Card(
          margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: Row(
              children: [
                Icon(Icons.layers_outlined, color: theme.darkGreyColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(locale.streamsOverlaysNotPaid, style: theme.defaultTextStyle),
                ),
                const SizedBox(width: 8),
                CustomButton(
                  text: locale.streamsOverlaysPay,
                  minimize: true,
                  expand: false,
                  onTap: () => openTournamentBilling(context, preselectTranslation: true),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
