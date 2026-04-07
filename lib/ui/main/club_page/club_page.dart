import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/widgets/bill_plan_dialog.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/domain/interactors/bill_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/check_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_club_interactor.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/ui/main/club_page/club_bloc.dart';
import 'package:seating_generator_web/ui/main/club_page/club_event.dart';
import 'package:seating_generator_web/ui/main/club_page/club_router.dart';
import 'package:seating_generator_web/ui/main/club_page/club_state.dart';
import 'package:seating_generator_web/ui/main/club_page/widgets/club_actions_section.dart';
import 'package:seating_generator_web/ui/main/club_page/widgets/club_bottom_bar.dart';
import 'package:seating_generator_web/ui/main/club_page/widgets/club_description_card.dart';
import 'package:seating_generator_web/ui/main/club_page/widgets/club_description_edit_dialog.dart';
import 'package:seating_generator_web/ui/main/club_page/widgets/club_hero_card.dart';
import 'package:seating_generator_web/ui/main/club_page/widgets/club_owners_bottom_sheet.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage()
class ClubPage extends StatelessWidget {
  @PathParam('clubId')
  final int clubId;
  final ClubModel? cachedModel;

  const ClubPage({
    super.key,
    required this.clubId,
    this.cachedModel,
  });

  @override
  Widget build(BuildContext context) {
    final repos = RepositoryFactory.of(context);
    return BlocProvider<ClubBloc>(
      create: (context) {
        final args = ClubBlocArgs(
          clubId: clubId,
          cachedModel: cachedModel,
        );
        return ClubBloc(
          router: ClubRouterImpl(context),
          args: args,
          getClubInteractor: GetClubInteractor(repos.clubRepository),
          billClubInteractor: BillClubInteractor(repos.purchaseRepository),
          checkClubInteractor: CheckClubInteractor(repos.clubRepository),
          clubRepository: repos.clubRepository,
        );
      },
      child: Container(
        color: context.theme.background1,
        child: _ClubPageContent(clubId: clubId),
      ),
    );
  }
}

class _ClubPageContent extends StatefulWidget {
  final int clubId;

  const _ClubPageContent({required this.clubId});

  @override
  State<_ClubPageContent> createState() => _ClubPageContentState();
}

class _ClubPageContentState extends CustomState<_ClubPageContent> {
  @override
  void initState() {
    context.read<ClubBloc>().add(const ClubEvent.pageOpened());
    super.initState();
  }

  @override
  Widget? buildMobile(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(context.locale.clubPageTitle),
          actions: [
            BlocBuilder<ClubBloc, ClubState>(
              builder: (context, state) {
                if (!state.isOwner) return const SizedBox.shrink();
                return IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: _editOwners,
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ClubBloc, ClubState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final model = state.model;
            if (model == null) return const SizedBox.shrink();

            final showBill = !(context.watch<AuthNotifier>().value.mapOrNull(
                      authorized: (m) => m.hideBilling,
                    ) ??
                false);

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClubHeroCard(
                          clubModel: model,
                          isOwner: state.isOwner,
                          onEditPhoto: state.isOwner ? _editPhoto : null,
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ClubDescriptionCard(
                            description: model.description,
                            onEditDescription: state.isOwner ? _editDescription : null,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ClubActionsSection(
                            isOwner: state.isOwner,
                            billedFor: model.billedFor,
                            onOpenRating: _openRating,
                            onAddGame: state.isOwner ? _addNewGame : null,
                            onRenewSubscription: state.isOwner && showBill ? _bill : null,
                            onCustomColumns: state.isOwner ? _editCustomColumns : null,
                            onHideRating: state.isOwner ? _changeHideDate : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                ClubBottomBar(onOpenRating: _openRating),
              ],
            );
          },
        ),
      );

  @override
  Widget buildDesktop(BuildContext context) {
    final showBill = !(context.watch<AuthNotifier>().value.mapOrNull(
              authorized: (model) => model.hideBilling,
            ) ??
        false);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(context.locale.clubPageTitle),
        actions: [
          BlocBuilder<ClubBloc, ClubState>(
            builder: (context, state) {
              if (!state.isOwner) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: _editOwners,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ClubBloc, ClubState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final model = state.model;
          if (model == null) return const SizedBox.shrink();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClubHeroCard(
                      clubModel: model,
                      isOwner: state.isOwner,
                      onEditPhoto: state.isOwner ? _editPhoto : null,
                    ),
                    const SizedBox(height: 24),
                    ClubDescriptionCard(
                      description: model.description,
                      onEditDescription: state.isOwner ? _editDescription : null,
                    ),
                    const SizedBox(height: 24),
                    ClubActionsSection(
                      isOwner: state.isOwner,
                      billedFor: model.billedFor,
                      onOpenRating: _openRating,
                      onAddGame: state.isOwner ? _addNewGame : null,
                      onRenewSubscription: state.isOwner && showBill ? _bill : null,
                      onCustomColumns: state.isOwner ? _editCustomColumns : null,
                      onHideRating: state.isOwner ? _changeHideDate : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openRating() {
    context.read<ClubBloc>().add(const ClubEvent.openRating());
  }

  void _addNewGame() {
    final clubId = context.read<ClubBloc>().state.model?.id;
    if (clubId == null) return;
    context.router.pushNamed('/club/$clubId/addGame');
  }

  void _changeHideDate() async {
    final bloc = context.read<ClubBloc>();

    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      initialDate: bloc.state.hideDate,
    );

    if (date == null) return;

    bloc.add(ClubEvent.changeHideDate(dateTime: date));
  }

  void _bill() async {
    final bloc = context.read<ClubBloc>();
    final locale = context.locale;
    final billedFor = bloc.state.model?.billedFor;

    String? subtitle;
    if (billedFor != null) {
      final localeCode = Localizations.localeOf(context).languageCode;
      final formatted = DateFormat('dd MMMM yyyy', localeCode).format(billedFor);
      subtitle = locale.billedFor(formatted);
    }

    final days = await BillPlanDialog.open(
      context: context,
      title: locale.profileBillDialogTitle,
      subtitle: subtitle ?? locale.profileBillDialogSubtitle,
    );

    if (!context.mounted) return;
    if (days != null) {
      bloc.add(ClubEvent.billClub(days: days));
    }
  }

  Future<void> _editDescription() async {
    final bloc = context.read<ClubBloc>();
    final currentClub = bloc.state.model;
    if (currentClub == null) {
      return;
    }

    final value = await ClubDescriptionEditDialog.show(
      context: context,
      initialValue: currentClub.description ?? '',
    );

    if (!mounted || value == null) {
      return;
    }

    bloc.add(ClubEvent.editDescription(description: value));
  }

  Future<void> _editPhoto() async {
    final bloc = context.read<ClubBloc>();
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (!mounted || image == null) {
      return;
    }

    final bytes = Uint8List.fromList(await image.readAsBytes());
    bloc.add(ClubEvent.editPhoto(bytes: bytes, fileName: image.name));
  }

  Future<void> _editOwners() async {
    final clubId = context.read<ClubBloc>().state.model?.id;
    if (clubId == null) {
      return;
    }
    await ClubOwnersBottomSheet.show(context, clubId: clubId);
  }

  void _editCustomColumns() {
    final clubId = context.read<ClubBloc>().state.model?.id;
    if (clubId == null) return;
    context.router.pushNamed('/club/$clubId/custom-columns');
  }
}
