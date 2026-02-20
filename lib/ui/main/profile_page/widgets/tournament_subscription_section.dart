import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/feature/profile/domain/model/tournament_subscription_plan_model.dart';
import 'package:seating_generator_web/feature/profile/domain/repository/profile_repository.dart';
import 'package:seating_generator_web/feature/webview/web_view_screen.dart';
import 'package:seating_generator_web/ui/main/profile_page/widgets/tournament_subscription_bill_dialog.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class TournamentSubscriptionSection extends StatefulWidget {
  final ProfileRepository repository;

  const TournamentSubscriptionSection({
    super.key,
    required this.repository,
  });

  @override
  State<TournamentSubscriptionSection> createState() =>
      _TournamentSubscriptionSectionState();
}

class _TournamentSubscriptionSectionState
    extends State<TournamentSubscriptionSection> {
  TournamentSubscriptionPlanModel? _plan;
  String? _errorMessage;
  bool _isLoadingPlan = true;
  bool _isBilling = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentPlan();
  }

  Future<void> _loadCurrentPlan() async {
    setState(() {
      _isLoadingPlan = true;
      _errorMessage = null;
    });

    try {
      final plan =
          await widget.repository.getTournamentSubscriptionCurrentPlan();
      if (!mounted) return;
      setState(() {
        _plan = plan;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _errorMessage = _mapError(error);
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingPlan = false;
        });
      }
    }
  }

  Future<void> _billSubscription() async {
    final plan = _plan;
    final isRenew = plan?.subscriptionType != null;

    final days = await TournamentSubscriptionBillDialog.open(
      context: context,
      isRenew: isRenew,
    );

    if (!mounted || days == null) {
      return;
    }

    setState(() {
      _isBilling = true;
    });

    try {
      final redirectLink = await widget.repository.billTournamentSubscription(
        subscriptionType:
            TournamentSubscriptionTypeModel.tournamentWithAllAddons10Players,
        days: days,
        redirectPath: GoRouterState.of(context).uri.toString(),
      );

      if (!mounted) return;
      final uri = Uri.parse(redirectLink);
      if (kIsWeb) {
        await launchUrl(uri, webOnlyWindowName: '_self');
      } else {
        context.push(
          WebViewScreen.createLocation(
            url: redirectLink,
            title: context.locale.profilePaymentTitle,
            context: context,
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_mapError(error)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isBilling = false;
        });
      }
    }
  }

  String _mapError(Object error) {
    if (error is RequestError && error.message?.isNotEmpty == true) {
      return error.message!;
    }

    return context.locale.profileTournamentSubscriptionErrorGeneric;
  }

  String _resolveTypeText(TournamentSubscriptionTypeModel type) {
    switch (type) {
      case TournamentSubscriptionTypeModel.unknownTournamentSubscriptionType:
        return context.locale.profileTournamentSubscriptionTypeUnknown;
      case TournamentSubscriptionTypeModel.tournamentWithAllAddons10Players:
        return context.locale
            .profileTournamentSubscriptionTypeTournamentWithAllAddons10Players;
    }
  }

  String _resolveActionText() {
    final hasSubscription = _plan?.subscriptionType != null;
    if (_isBilling) {
      return context.locale.profileTournamentSubscriptionLoading;
    }
    return hasSubscription
        ? context.locale.profileTournamentSubscriptionRenew
        : context.locale.profileTournamentSubscriptionCreate;
  }

  @override
  Widget build(BuildContext context) {
    final plan = _plan;
    final localeCode = Localizations.localeOf(context).languageCode;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.locale.profileTournamentSubscriptionTitle,
                    style: MyTheme.of(context).fieldTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: _showSubscriptionInfoDialog,
                  icon: const Icon(Icons.info_outline),
                  tooltip:
                      context.locale.profileTournamentSubscriptionInfoTitle,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_isLoadingPlan)
              const Center(child: CircularProgressIndicator())
            else if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: MyTheme.of(context).fieldTextStyle.copyWith(
                      color: MyTheme.of(context).redColor,
                    ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _loadCurrentPlan,
                child: Text(context.locale.profileTournamentSubscriptionReload),
              ),
            ] else if (plan != null) ...[
              Text(
                context.locale.profileTournamentSubscriptionStatus(
                  plan.isActive
                      ? context.locale.profileTournamentSubscriptionStatusActive
                      : context
                          .locale.profileTournamentSubscriptionStatusInactive,
                ),
                style: MyTheme.of(context).fieldTextStyle,
              ),
              const SizedBox(height: 6),
              if (plan.subscriptionType != null)
                Text(
                  context.locale.profileTournamentSubscriptionPlan(
                    _resolveTypeText(plan.subscriptionType!),
                  ),
                  style: MyTheme.of(context).fieldTextStyle,
                )
              else
                Text(
                  context.locale.profileTournamentSubscriptionPlanUnavailable,
                  style: MyTheme.of(context).fieldTextStyle,
                ),
              if (plan.billedFor != null) ...[
                const SizedBox(height: 6),
                Text(
                  context.locale.billedFor(
                    DateFormat('dd MMMM yyyy', localeCode).format(
                      plan.billedFor!,
                    ),
                  ),
                  style: MyTheme.of(context).fieldTextStyle,
                ),
              ],
              const SizedBox(height: 16),
              CustomButton(
                text: _resolveActionText(),
                disabled: _isBilling,
                onTap: _billSubscription,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showSubscriptionInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.locale.profileTournamentSubscriptionInfoTitle),
        content: Text(
          context.locale.profileTournamentSubscriptionInfoDescription,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.locale.ok),
          ),
        ],
      ),
    );
  }
}
