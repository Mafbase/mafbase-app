import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/common/widgets/main_mobile_app_bar.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournament_item_row.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournament_status_widget.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_events.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_search_field.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_state.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage._();

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();

  static const String _name = 'tournaments';

  static String createLocation(BuildContext context) {
    return context.namedLocation(_name);
  }

  static final GoRoute route = GoRoute(
    path: '/tournament',
    name: _name,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: TournamentsPage._(),
    ),
  );
}

class _TournamentsPageState extends CustomState<TournamentsPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TournamentsBloc>().add(const TournamentsEvent.opened());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<TournamentsBloc>().add(const TournamentsEvent.loadMore());
    }
  }

  void _onSearchChanged(String query) {
    context.read<TournamentsBloc>().add(TournamentsEvent.search(query));
  }

  void _onSearchClear() {
    context.read<TournamentsBloc>().add(const TournamentsEvent.search(''));
  }

  @override
  Widget? buildMobile(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return Scaffold(
      appBar: const MainMobileAppBar(),
      body: RefreshIndicator(
        onRefresh: () {
          final completer = Completer();
          context.read<TournamentsBloc>().add(TournamentsEvent.opened(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<TournamentsBloc, TournamentsState>(
          builder: (context, state) => CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                floating: true,
                delegate: _SearchHeaderDelegate(
                  child: Container(
                    color: theme.background1,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TournamentsSearchField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      onClear: _onSearchClear,
                      hintText: locale.tournamentsSearchHint,
                    ),
                  ),
                ),
              ),
              if (state.isLoading)
                const SliverFillRemaining(
                  child: LoadingOverlayWidget(),
                )
              else if (state.tournaments.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 64, color: theme.greyColor),
                        const SizedBox(height: 16),
                        Text(
                          locale.tournamentsSearchEmpty,
                          style: TextStyle(fontSize: 16, color: theme.greyColor),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverList.separated(
                    itemCount: state.tournaments.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return TournamentItemRow(
                        tournamentModel: state.tournaments[index],
                      );
                    },
                  ),
                ),
                if (state.isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: context.read<AuthNotifier>(),
        builder: (context, authModel, _) {
          if (authModel is! AuthNotifierAuthorizedModel) return const SizedBox.shrink();
          return FloatingActionButton(
            elevation: 10,
            onPressed: () {
              context.read<TournamentsBloc>().add(const TournamentsEvent.create());
            },
            child: const Icon(Icons.add, color: Colors.white),
          );
        },
      ),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(locale.tournamentsListTitle),
              const SizedBox(width: 24),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: TournamentsSearchField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      onClear: _onSearchClear,
                      hintText: locale.tournamentsSearchHint,
                    ),
                  ),
                ),
              ),
              SizedBox(width: max((constraints.maxWidth - 900) / 2 - 16, 0)),
            ],
          ),
        ),
        body: BlocBuilder<TournamentsBloc, TournamentsState>(
          builder: (context, state) => Stack(
            children: [
              if (!state.isLoading && state.tournaments.isEmpty)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search_off, size: 64, color: theme.greyColor),
                      const SizedBox(height: 16),
                      Text(
                        locale.tournamentsSearchEmpty,
                        style: TextStyle(fontSize: 16, color: theme.greyColor),
                      ),
                    ],
                  ),
                )
              else
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.tournaments.length,
                          (context, index) {
                            final tournament = state.tournaments[index];
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 900),
                                  child: _DesktopTournamentCard(tournament: tournament),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (state.isLoadingMore)
                      const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                  ],
                ),
              if (state.isLoading) const LoadingOverlayWidget(),
            ],
          ),
        ),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: context.read<AuthNotifier>(),
          builder: (context, authModel, _) {
            if (authModel is! AuthNotifierAuthorizedModel) return const SizedBox.shrink();
            return FloatingActionButton.large(
              elevation: 10,
              onPressed: () {
                context.read<TournamentsBloc>().add(const TournamentsEvent.create());
              },
              child: const Icon(Icons.add, color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchHeaderDelegate({required this.child});

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 64;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) => false;
}

class _DesktopTournamentCard extends StatelessWidget {
  final TournamentModel tournament;

  const _DesktopTournamentCard({required this.tournament});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.read<MainBloc>().add(
              MainEvent.tournamentSelected(tournamentId: tournament.id),
            );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: theme.background2,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.cardShadowColor,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _iconColor(theme),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        tournament.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'ID: ${tournament.id}',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.hintColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _buildMetadata(context, theme, locale),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${tournament.billedPlayers}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  locale.tournamentCardPlayersLabel,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.greyColor,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            TournamentStatusWidget(status: tournament.status),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadata(BuildContext context, MyTheme theme, dynamic locale) {
    final dateRange = _formatDateRange(context, tournament.dateStart, tournament.dateEnd);
    final metaStyle = TextStyle(fontSize: 13, color: theme.greyColor);
    final iconColor = theme.greyColor;

    return Row(
      children: [
        Icon(Icons.calendar_today, size: 13, color: iconColor),
        const SizedBox(width: 4),
        Text(dateRange, style: metaStyle),
        const SizedBox(width: 8),
        _dot(theme),
        const SizedBox(width: 8),
        Icon(Icons.sports_esports, size: 13, color: iconColor),
        const SizedBox(width: 4),
        Text(locale.tournamentCardGames(tournament.gamesCount), style: metaStyle),
      ],
    );
  }

  Widget _dot(MyTheme theme) {
    return Container(
      width: 3,
      height: 3,
      decoration: BoxDecoration(
        color: theme.greyColor,
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }

  Color _iconColor(MyTheme theme) {
    switch (tournament.status) {
      case TournamentStatus.active:
        return theme.darkBlueColor;
      case TournamentStatus.waitForBilling:
        return theme.positiveColor;
      case TournamentStatus.ended:
        return theme.darkGreyColor;
    }
  }

  String _formatDateRange(BuildContext context, DateTime start, DateTime end) {
    final fmt = DateFormat('d MMM', Localizations.localeOf(context).languageCode);
    if (start.year == end.year && start.month == end.month && start.day == end.day) {
      return fmt.format(start);
    }
    return '${fmt.format(start)} – ${fmt.format(end)}';
  }
}
