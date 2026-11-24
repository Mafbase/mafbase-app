import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/shared/club/data/club_repository_dependency.dart';
import 'package:seating_generator_web/feature/clubs/domain/interactors/get_clubs_interactor.dart';
import 'package:seating_generator_web/feature/clubs/ui/clubs_router.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/common/widgets/main_mobile_app_bar.dart';
import 'package:seating_generator_web/feature/clubs/ui/clubs_bloc.dart';
import 'package:seating_generator_web/feature/clubs/ui/clubs_event.dart';
import 'package:seating_generator_web/feature/clubs/ui/clubs_state.dart';
import 'package:seating_generator_web/feature/clubs/ui/widgets/single_club_row.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage()
class ClubsPage extends StatelessWidget {
  const ClubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = DependencyScope.of(context);
    return BlocProvider<ClubsBloc>(
      create: (context) => ClubsBloc(
        getClubsInteractor: GetClubsInteractor(scope.clubRepository),
        router: ClubsRouterImpl(context),
      ),
      child: const _ClubsPageContent(),
    );
  }
}

class _ClubsPageContent extends StatefulWidget {
  const _ClubsPageContent();

  @override
  State<_ClubsPageContent> createState() => _ClubsPageContentState();
}

class _ClubsPageContentState extends CustomState<_ClubsPageContent> {
  @override
  void initState() {
    context.read<ClubsBloc>().add(const ClubsEvent.pageOpened());
    super.initState();
  }

  void _onClubTap(BuildContext context, int index, ClubsState state) {
    context.read<ClubsBloc>().add(
          ClubsEvent.clubSelected(clubModel: state.clubs[index]),
        );
  }

  @override
  Widget? buildMobile(BuildContext context) => Scaffold(
        appBar: const MainMobileAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<ClubsBloc>().add(const ClubsEvent.createClubTapped()),
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<ClubsBloc, ClubsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const LoadingOverlayWidget();
            }
            return RefreshIndicator(
              onRefresh: () {
                final completer = Completer();
                context.read<ClubsBloc>().add(
                      ClubsEvent.pageOpened(completer: completer),
                    );
                return completer.future;
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.clubs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) => SingleClubRow(
                  style: ClubRowStyle.mobile,
                  model: state.clubs[index],
                  onTap: () => _onClubTap(context, index, state),
                ),
              ),
            );
          },
        ),
      );

  @override
  Widget buildDesktop(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.locale.clubsHeader),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: context.locale.addClubTitle,
              onPressed: () => context.read<ClubsBloc>().add(const ClubsEvent.createClubTapped()),
            ),
          ],
        ),
        body: BlocBuilder<ClubsBloc, ClubsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const LoadingOverlayWidget();
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
              itemCount: state.clubs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) => SingleClubRow(
                model: state.clubs[index],
                onTap: () => _onClubTap(context, index, state),
              ),
            );
          },
        ),
      );
}
