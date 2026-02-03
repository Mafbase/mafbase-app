import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/club_games/club_games_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_bloc.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_event.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_state.dart';
import 'package:seating_generator_web/ui/main/rating_page/widgets/game_filter_dialog.dart';
import 'package:seating_generator_web/ui/main/rating_page/widgets/rating_table.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class RatingPage extends StatefulWidget {
  final int? clubId;
  final int? tournamentId;
  final DateTimeRange? range;
  final RatingTableStyle style;
  final RatingSort sort;
  final int gameFilter;

  const RatingPage({
    super.key,
    this.clubId,
    this.tournamentId,
    this.range,
    this.style = RatingTableStyle.full,
    this.sort = RatingSort.score,
    this.gameFilter = 0,
  }) : assert((clubId == null) != (tournamentId == null));

  @override
  State<RatingPage> createState() => _RatingPageState();

  static String createTournamentLocation({
    required int tournamentId,
    required BuildContext context,
    RatingTableStyle tableStyle = RatingTableStyle.full,
    RatingSort sort = RatingSort.score,
    int gameFilter = 0,
  }) {
    return context.namedLocation(
      _tournamentName,
      pathParameters: {
        "id": tournamentId.toString(),
      },
      queryParameters: {
        "style": tableStyle.name,
        "sort": sort.name,
        "game-filter": gameFilter.toString(),
      },
    );
  }

  static String createClubLocation({
    DateTimeRange? range,
    required int clubId,
    required BuildContext context,
    RatingTableStyle tableStyle = RatingTableStyle.full,
    RatingSort sort = RatingSort.score,
    int gameFilter = 0,
  }) {
    return context.namedLocation(
      _clubName,
      pathParameters: {"clubId": clubId.toString()},
      queryParameters: {
        "date-start":
            range == null ? null : dateFormatForRequests.format(range.start),
        "date-end":
            range == null ? null : dateFormatForRequests.format(range.end),
        "style": tableStyle.name,
        "sort": sort.name,
        "game-filter": gameFilter.toString(),
      },
    );
  }

  static const _tournamentName = 'tournament_rating';
  static const _clubName = 'club_rating';

  static final GoRoute tournamentRoute = GoRoute(
    path: 'rating',
    name: _tournamentName,
    builder: (context, state) {
      final tournamentId = int.parse(state.pathParameters["id"]!);
      final style = RatingTableStyle.values.firstWhereOrNull(
            (element) => state.uri.queryParameters["style"] == element.name,
          ) ??
          RatingTableStyle.full;
      final sort = RatingSort.values.firstWhereOrNull(
            (element) => state.uri.queryParameters["sort"] == element.name,
          ) ??
          RatingSort.score;
      final gameFilter =
          int.tryParse(state.uri.queryParameters["game-filter"] ?? "") ?? 0;
      return BlocProvider<RatingBloc>(
        create: (context) {
          return getIt(param1: context);
        },
        child: RatingPage(
          tournamentId: tournamentId,
          style: style,
          sort: sort,
          gameFilter: gameFilter,
        ),
      );
    },
  );

  static final GoRoute clubRoute = GoRoute(
    path: "rating",
    name: _clubName,
    builder: (context, state) {
      final clubId = int.parse(state.pathParameters["clubId"]!);
      final dateStart =
          DateTime.tryParse(state.uri.queryParameters["date-start"] ?? "") ??
              DateTime.now().subtract(const Duration(days: 30));
      final dateEnd =
          DateTime.tryParse(state.uri.queryParameters["date-end"] ?? "") ??
              DateTime.now();
      final range = DateTimeRange(start: dateStart, end: dateEnd);
      final style = RatingTableStyle.values.firstWhereOrNull(
            (element) => state.uri.queryParameters["style"] == element.name,
          ) ??
          RatingTableStyle.full;
      final sort = RatingSort.values.firstWhereOrNull(
            (element) => state.uri.queryParameters["sort"] == element.name,
          ) ??
          RatingSort.score;
      final gameFilter =
          int.tryParse(state.uri.queryParameters["game-filter"] ?? "") ?? 0;
      return BlocProvider<RatingBloc>(
        create: (context) {
          return getIt(param1: context);
        },
        child: RatingPage(
          clubId: clubId,
          range: range,
          style: style,
          sort: sort,
          gameFilter: gameFilter,
        ),
      );
    },
  );
}

class _RatingPageState extends CustomState<RatingPage> {
  final format = DateFormat("dd:MM:yyyy");
  List<RatingTableStyle> items = [
    RatingTableStyle.score,
    RatingTableStyle.full,
    RatingTableStyle.stats,
  ];
  int carouselIndex = 1;
  final _carouselController = carousel.CarouselSliderController();

  @override
  void initState() {
    context.read<RatingBloc>().add(
          RatingEvent.pageOpened(
            range: widget.range,
            clubId: widget.clubId,
            tournamentId: widget.tournamentId,
          ),
        );
    super.initState();
  }

  getTextFrom(RatingTableStyle style) {
    switch (style) {
      case RatingTableStyle.full:
        return 'Рейтинг';
      case RatingTableStyle.stats:
        return "Винрейт";
      case RatingTableStyle.score:
        return "Баллы";
      case RatingTableStyle.addScore:
        return "MVP";
    }
  }

  @override
  void didUpdateWidget(covariant RatingPage oldWidget) {
    if (oldWidget.range != widget.range ||
        oldWidget.clubId != widget.clubId ||
        oldWidget.tournamentId != widget.tournamentId) {
      context.read<RatingBloc>().add(
            RatingEvent.pageOpened(
              range: widget.range,
              clubId: widget.clubId,
              tournamentId: widget.tournamentId,
            ),
          );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget buildMobile(BuildContext context) {
    return BlocBuilder<RatingBloc, RatingState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingOverlayWidget();
        }

        Widget ratingTable({bool singlePage = false}) => RatingTable(
              isTournament: widget.tournamentId != null,
              isMobile: true,
              style: widget.style,
              rows: state.rows,
              clubId: widget.clubId,
              sort: widget.sort,
              gameFilter: widget.gameFilter,
              openGame: openGame,
              pinNicknames: singlePage,
              changeSort: (RatingSort sort) {
                context.read<RatingBloc>().add(
                      RatingEvent.rangeChanged(
                        range: widget.range,
                        clubId: widget.clubId,
                        tournamentId: widget.tournamentId,
                        style: widget.style,
                        sort: sort,
                        gameFilter: widget.gameFilter,
                      ),
                    );
              },
              tournamentId: widget.tournamentId,
            );

        void openFullscreen() {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  title: Text(context.locale.rating),
                  backgroundColor: MyTheme.of(context).darkBlueColor,
                  foregroundColor: Colors.white,
                ),
                backgroundColor: Colors.white,
                body: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ratingTable(singlePage: true),
                  ),
                ),
              ),
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.rows.isNotEmpty)
                    IconButton(
                      onPressed: openFullscreen,
                      icon: Icon(Icons.fullscreen_outlined),
                    ),
                  Flexible(
                    child: Text(
                      state.clubName,
                      style: context.theme.headerTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (widget.clubId != null)
                    IconButton(
                      onPressed: () => context.push(
                        ClubGamesPage.createLocation(
                          context: context,
                          clubId: widget.clubId!,
                          range: widget.range,
                        ),
                      ),
                      icon: const Icon(Icons.table_chart_outlined),
                    ),
                ],
              ),
            ),
            if (widget.range != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                  onPressed: onChangeRangeTap,
                  child: Text(
                    "${context.locale.period}\n${format.format(widget.range!.start)} - ${format.format(widget.range!.end)}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  gameFilterWidget(),
                  const SizedBox(width: 8),
                  styleSwitcher(),
                  const SizedBox(width: 8),
                  downloadRatingButton(),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            winRate(state),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: state.rows.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          context.locale.ratingNoGamesFound,
                          style: MyTheme.of(context).defaultTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : ratingTable(singlePage: false),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildDesktop(BuildContext context) =>
      BlocBuilder<RatingBloc, RatingState>(
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              state.clubName,
                              style: MyTheme.of(context).headerTextStyle,
                            ),
                          ),
                          if (widget.clubId != null)
                            IconButton(
                              onPressed: () => context.push(
                                ClubGamesPage.createLocation(
                                  context: context,
                                  clubId: widget.clubId!,
                                  range: widget.range,
                                ),
                              ),
                              icon: const Icon(Icons.table_chart_outlined),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.range != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, right: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(context.locale.period),
                                  CustomButton(
                                    onTap: onChangeRangeTap,
                                    disabled: widget.tournamentId != null,
                                    text:
                                        "${format.format(widget.range!.start)} - ${format.format(widget.range!.end)}",
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: gameFilterWidget(),
                          ),
                          styleSwitcher(),
                          downloadRatingButton(),
                        ],
                      ),
                      const SizedBox(height: 8),
                      winRate(state),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: Center(
                          child: RatingTable(
                            style: widget.style,
                            rows: state.rows,
                            clubId: widget.clubId,
                            sort: widget.sort,
                            gameFilter: widget.gameFilter,
                            openGame: openGame,
                            changeSort: (RatingSort sort) {
                              context.read<RatingBloc>().add(
                                    RatingEvent.rangeChanged(
                                      range: widget.range,
                                      clubId: widget.clubId,
                                      style: widget.style,
                                      tournamentId: widget.tournamentId,
                                      sort: sort,
                                      gameFilter: widget.gameFilter,
                                    ),
                                  );
                            },
                            tournamentId: widget.tournamentId,
                            isTournament: widget.tournamentId != null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.isLoading) const LoadingOverlayWidget(),
            ],
          );
        },
      );

  Widget downloadRatingButton() => widget.clubId == null
      ? Container()
      : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                context.read<RatingBloc>().add(
                      RatingEvent.downloadRating(
                        range: widget.range!,
                        clubId: widget.clubId!,
                      ),
                    );
              },
              icon: const Icon(
                Icons.download,
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              onPressed: () {
                context.read<RatingBloc>().add(
                      RatingEvent.downloadStats(
                        range: widget.range!,
                        clubId: widget.clubId!,
                      ),
                    );
              },
              icon: const Icon(Icons.stacked_bar_chart),
            ),
          ],
        );

  onChangeRangeTap() async {
    final bloc = context.read<RatingBloc>();
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      initialDateRange: widget.range,
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (range != null) {
      bloc.add(
        RatingEvent.rangeChanged(
          range: range,
          clubId: widget.clubId,
          tournamentId: widget.tournamentId,
          style: widget.style,
          sort: widget.sort,
          gameFilter: widget.gameFilter,
        ),
      );
    }
  }

  void openGame(int gameId) {
    if (widget.clubId != null) {
      context.read<RatingBloc>().add(
            RatingEvent.gameSelected(
              gameId: gameId,
              clubId: widget.clubId,
            ),
          );
    } else {
      context.read<RatingBloc>().add(
            RatingEvent.gameSelected(
              gameId: gameId,
              tournamentId: widget.tournamentId,
            ),
          );
    }
  }

  Widget winRate(RatingState model) {
    if (model.games == 0) return const SizedBox.shrink();
    final citizenWinRate = ((model.citizenWins / model.games) * 100).round();
    final mafiaWinRate = ((model.mafiaWins / model.games) * 100).round();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Винрейт мирных жителей: $citizenWinRate% (${model.citizenWins}/${model.games})",
        ),
        const SizedBox(height: 4),
        Text(
          "Винрейт мафии: $mafiaWinRate% (${model.mafiaWins}/${model.games})",
        ),
      ],
    );
  }

  Widget gameFilterWidget() {
    return IconButton(
      icon: Stack(
        children: [
          const Icon(Icons.filter_list),
          if (widget.gameFilter > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  widget.gameFilter.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      tooltip: widget.gameFilter > 0
          ? context.locale.ratingGameFilterCurrent(widget.gameFilter)
          : context.locale.ratingGameFilter,
      onPressed: () => _showGameFilterDialog(),
    );
  }

  Future<void> _showGameFilterDialog() async {
    final gameFilter = await GameFilterDialog.show(
      context,
      currentFilter: widget.gameFilter,
    );

    if (!mounted) return;

    if (gameFilter != null && gameFilter != widget.gameFilter) {
      context.read<RatingBloc>().add(
            RatingEvent.rangeChanged(
              range: widget.range,
              clubId: widget.clubId,
              tournamentId: widget.tournamentId,
              style: widget.style,
              sort: widget.sort,
              gameFilter: gameFilter,
            ),
          );
    }
  }

  Widget styleSwitcher() {
    return Container(
      width: 162,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyTheme.of(context).darkGreyColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          IgnorePointer(
            ignoring: widget.style == items.first,
            child: Opacity(
              opacity: widget.style == items.first ? 0 : 1,
              child: IconButton(
                onPressed: () {
                  _carouselController.previousPage();
                },
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: MyTheme.of(context).darkGreyColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: carousel.CarouselSlider(
              carouselController: _carouselController,
              items: items
                  .map(
                    (element) => Center(
                      child: Text(getTextFrom(element)),
                    ),
                  )
                  .toList(),
              options: carousel.CarouselOptions(
                enableInfiniteScroll: false,
                initialPage: items.indexOf(widget.style),
                viewportFraction: 1,
                height: 56,
                onPageChanged: (index, controller) {
                  context.read<RatingBloc>().add(
                        RatingEvent.rangeChanged(
                          range: widget.range,
                          clubId: widget.clubId,
                          tournamentId: widget.tournamentId,
                          style: items[index],
                          sort: widget.sort,
                          gameFilter: widget.gameFilter,
                        ),
                      );
                },
              ),
            ),
          ),
          IgnorePointer(
            ignoring: widget.style == items.last,
            child: Opacity(
              opacity: widget.style == items.last ? 0 : 1,
              child: IconButton(
                onPressed: () {
                  _carouselController.nextPage();
                },
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: MyTheme.of(context).darkGreyColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
