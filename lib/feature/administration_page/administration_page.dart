import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
import 'package:seating_generator_web/feature/tournament/ui/tournament_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/feature/administration_page/widgets/add_owner_dialog.dart';
import 'package:seating_generator_web/feature/administration_page/widgets/onwer_row.dart';

class AdministrationPage extends StatefulWidget {
  final int tournamentId;

  const AdministrationPage({
    super.key,
    required this.tournamentId,
  });

  @override
  State<AdministrationPage> createState() => _AdministrationPageState();

  static String createTournamentLocation({
    required int tournamentId,
    required BuildContext context,
  }) {
    return context.namedLocation(
      _tournamentName,
      pathParameters: {
        'id': tournamentId.toString(),
      },
    );
  }

  static const _tournamentName = 'tournament_administration';

  static final GoRoute tournamentRoute = GoRoute(
    path: 'administration',
    name: _tournamentName,
    builder: (context, state) {
      final tournamentId = int.parse(state.pathParameters['id']!);
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
        child: AdministrationPage(
          tournamentId: tournamentId,
        ),
      );
    },
  );
}

class _AdministrationPageState extends State<AdministrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: context.backOrGoToDefault(
            (c) => TournamentPage.createLocation(context: c, tournamentId: widget.tournamentId),
          ),
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
