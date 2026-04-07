import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/domain/interactors/add_owner_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_owner_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_administration_interactor.dart';
import 'package:seating_generator_web/domain/repositories/owners_repository.dart';
import 'package:seating_generator_web/feature/administration_page/administration_bloc.dart';
import 'package:seating_generator_web/feature/administration_page/administration_event.dart';
import 'package:seating_generator_web/feature/administration_page/administration_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/feature/administration_page/widgets/add_owner_dialog.dart';
import 'package:seating_generator_web/feature/administration_page/widgets/onwer_row.dart';

@RoutePage()
class AdministrationPage extends StatelessWidget {
  final int tournamentId;

  const AdministrationPage({
    super.key,
    @PathParam('id') required this.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    final OwnersRepository ownersRepository = RepositoryFactory.of(context).ownersRepository;
    final getAdministrationInteractor = GetAdministrationInteractor(ownersRepository);
    final addOwnerInteractor = AddOwnerInteractor(ownersRepository);
    final deleteOwnerInteractor = DeleteOwnerInteractor(ownersRepository);
    return BlocProvider<AdministrationBloc>(
      create: (context) => AdministrationBloc(
        const AdministrationState(),
        addOwnerInteractor,
        deleteOwnerInteractor,
        getAdministrationInteractor,
      )..add(
          AdministrationEventPageOpened(tournamentId: tournamentId),
        ),
      child: _AdministrationPageContent(tournamentId: tournamentId),
    );
  }
}

class _AdministrationPageContent extends StatefulWidget {
  final int tournamentId;

  const _AdministrationPageContent({required this.tournamentId});

  @override
  State<_AdministrationPageContent> createState() => _AdministrationPageContentState();
}

class _AdministrationPageContentState extends State<_AdministrationPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: context.backOrGoToDefault(),
        ),
        title: Text(context.locale.ownersTitle),
        actions: [
          IconButton(
            onPressed: () {
              final bloc = context.read<AdministrationBloc>();
              AddOwnerDialog.open(
                context: context,
              ).then((value) {
                if (value != null) {
                  bloc.add(
                    AdministrationEventAddOwner(
                      tournamentId: widget.tournamentId,
                      email: value,
                    ),
                  );
                }
              });
            },
            icon: const Icon(Icons.add),
          ),
          TournamentMenuAction(
            tournamentId: widget.tournamentId,
            openDrawer: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      body: BlocBuilder<AdministrationBloc, AdministrationState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingOverlayWidget();
          }
          return Column(
            children: [
              Expanded(
                child: state.owners.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            context.locale.ownersEmpty,
                            textAlign: TextAlign.center,
                            style: MyTheme.of(context).defaultTextStyle,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => OwnerRow(
                          email: state.owners[index].email,
                          onDelete: () {
                            final bloc = context.read<AdministrationBloc>();
                            ConfirmDialog.open(context).then((value) {
                              if (value == true) {
                                bloc.add(
                                  AdministrationEventDeleteOwner(
                                    tournamentId: widget.tournamentId,
                                    ownerId: state.owners[index].id,
                                  ),
                                );
                              }
                            });
                          },
                        ),
                        itemCount: state.owners.length,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
