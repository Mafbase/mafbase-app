import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/shimmer.dart';
import 'package:seating_generator_web/feature/profile/domain/model/tournament_subscription_plan_model.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_bloc.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';
import 'package:seating_generator_web/common/widgets/bill_plan_dialog.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentSubscriptionSection extends StatelessWidget {
  const TournamentSubscriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.isLoadingSubscription) {
          return _buildSkeletonCard(context);
        }

        if (state.subscriptionError != null) {
          return _buildErrorCard(context);
        }

        final plan = state.subscriptionPlan;
        if (plan == null) return const SizedBox.shrink();

        return _buildDataCard(context, plan, state.isBilling);
      },
    );
  }

  Widget _buildSkeletonCard(BuildContext context) {
    return Shimmer(
      linearGradient: shimmerGradient,
      child: ShimmerLoading(
        isLoading: true,
        child: Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.redColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.redColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: theme.redColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  locale.profileSubscriptionErrorMessage,
                  style: theme.defaultTextStyle.copyWith(
                    color: theme.redColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => context.read<ProfileBloc>().add(const ProfileEvent.loadSubscription()),
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.redColor,
              side: BorderSide(color: theme.redColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(locale.profileSubscriptionRetryButton),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard(
    BuildContext context,
    TournamentSubscriptionPlanModel plan,
    bool isBilling,
  ) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    final localeCode = Localizations.localeOf(context).languageCode;
    const divider = Divider(height: 1);

    final isExpired = plan.billedFor != null && plan.billedFor!.isBefore(DateTime.now()) && !plan.isActive;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.background2,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.cardShadowColor,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 10),
            child: Row(
              children: [
                Icon(Icons.card_membership, size: 18, color: theme.darkBlueColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    locale.profileTournamentSubscriptionTitle,
                    style: theme.defaultTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _showInfoDialog(context),
                  icon: Icon(
                    Icons.info_outline,
                    size: 20,
                    color: theme.darkGreyColor,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: locale.profileTournamentSubscriptionInfoTitle,
                ),
              ],
            ),
          ),
          divider,

          // Status row
          _buildRow(
            context,
            label: locale.profileSubscriptionStatusLabel,
            child: _StatusBadge(isActive: plan.isActive),
          ),
          divider,

          // Tariff row
          _buildRow(
            context,
            label: locale.profileSubscriptionTariffLabel,
            child: Text(
              plan.subscriptionType != null ? _resolveTypeText(context, plan.subscriptionType!) : '—',
              style: theme.defaultTextStyle.copyWith(
                color: theme.darkBlueColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          divider,

          // Billed for row
          if (plan.billedFor != null) ...[
            _buildRow(
              context,
              label: isExpired ? locale.profileSubscriptionExpiredLabel : locale.profileSubscriptionBilledForLabel,
              child: Text(
                DateFormat('dd MMMM yyyy', localeCode).format(plan.billedFor!),
                style: theme.defaultTextStyle.copyWith(
                  color: isExpired ? theme.redColor : theme.darkBlueColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            divider,
          ],

          // Action button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isBilling ? null : () => _onBillPressed(context, plan),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.darkBlueColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: theme.buttonDisabledColor,
                  minimumSize: const Size(0, 44),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isBilling
                      ? locale.profileTournamentSubscriptionLoading
                      : plan.subscriptionType != null
                          ? locale.profileSubscriptionRenewButton
                          : locale.profileSubscriptionPayButton,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required String label,
    required Widget child,
  }) {
    final theme = MyTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(
            label,
            style: theme.defaultTextStyle.copyWith(
              color: theme.darkGreyColor,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          child,
        ],
      ),
    );
  }

  String _resolveTypeText(
    BuildContext context,
    TournamentSubscriptionTypeModel type,
  ) {
    switch (type) {
      case TournamentSubscriptionTypeModel.unknownTournamentSubscriptionType:
        return context.locale.profileTournamentSubscriptionTypeUnknown;
      case TournamentSubscriptionTypeModel.tournamentWithAllAddons10Players:
        return context.locale.profileTournamentSubscriptionTypeTournamentWithAllAddons10Players;
    }
  }

  Future<void> _onBillPressed(
    BuildContext context,
    TournamentSubscriptionPlanModel plan,
  ) async {
    final days = await BillPlanDialog.open(
      context: context,
      title: context.locale.profileBillDialogTitle,
      subtitle: context.locale.profileBillDialogSubtitle,
    );

    if (!context.mounted || days == null) return;

    final redirectPath = GoRouterState.of(context).uri.toString();
    context.read<ProfileBloc>().add(
          ProfileEvent.billSubscription(days, redirectPath),
        );
  }

  void _showInfoDialog(BuildContext context) {
    final locale = context.locale;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale.profileTournamentSubscriptionInfoTitle),
        content: Text(locale.profileTournamentSubscriptionInfoDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(locale.ok),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isActive;

  const _StatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final theme = MyTheme.of(context);
    final color = isActive ? theme.successColor : theme.redColor;
    final bgColor = isActive ? theme.successColor.withValues(alpha: 0.12) : theme.redColor.withValues(alpha: 0.1);
    final text = isActive
        ? locale.profileTournamentSubscriptionStatusActive
        : locale.profileTournamentSubscriptionStatusInactive;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
