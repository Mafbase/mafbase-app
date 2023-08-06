import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_bloc.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_event.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_state.dart';
import 'package:seating_generator_web/ui/main/rating_page/widgets/rating_table.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class RatingPage extends StatefulWidget {
  final int? clubId;
  final int? tournamentId;
  final DateTimeRange range;
  final RatingTableStyle style;
  final RatingSort sort;
  final int gameFilter;

  const RatingPage({
    Key? key,
    this.clubId,
    this.tournamentId,
    required this.range,
    this.style = RatingTableStyle.full,
    this.sort = RatingSort.score,
    this.gameFilter = 0,
  })  : assert((clubId == null) != (tournamentId == null)),
        super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();

  static String createTournamentLocation({
    required int tournamentId,
    required BuildContext context,
    RatingTableStyle tableStyle = RatingTableStyle.full,
    RatingSort sort = RatingSort.score,
  }) {
    return context.namedLocation(
      _tournamentName,
      params: {
        "id": tournamentId.toString(),
      },
      queryParams: {"style": tableStyle.name, "sort": sort.name},
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
      params: {"clubId": clubId.toString()},
      queryParams: {
        "date-start":
            range == null ? null : dateFormatForRequests.format(range.start),
        "date-end":
            range == null ? null : dateFormatForRequests.format(range.end),
        "style": tableStyle.name,
        "sort": sort.name,
        "game-filter": gameFilter.toString()
      },
    );
  }

  static const _tournamentName = 'tournament_rating';
  static const _clubName = 'club_rating';

  static final GoRoute tournamentRoute = GoRoute(
    path: 'rating',
    name: _tournamentName,
    builder: (context, state) {
      final tournamentId = int.parse(state.params["id"]!);
      final dateStart =
          DateTime.tryParse(state.queryParams["date-start"] ?? "") ??
              DateTime.now().subtract(const Duration(days: 30));
      final dateEnd = DateTime.tryParse(state.queryParams["date-end"] ?? "") ??
          DateTime.now();
      final range = DateTimeRange(start: dateStart, end: dateEnd);
      final style = RatingTableStyle.values.firstWhereOrNull(
            (element) => state.queryParams["style"] == element.name,
          ) ??
          RatingTableStyle.full;
      final sort = RatingSort.values.firstWhereOrNull(
            (element) => state.queryParams["sort"] == element.name,
          ) ??
          RatingSort.score;
      final gameFilter =
          int.tryParse(state.queryParams["game-filter"] ?? "") ?? 0;
      return BlocProvider<RatingBloc>(
        create: (context) {
          return getIt(param1: context);
        },
        child: RatingPage(
          tournamentId: tournamentId,
          range: range,
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
      final clubId = int.parse(state.params["clubId"]!);
      final dateStart =
          DateTime.tryParse(state.queryParams["date-start"] ?? "") ??
              DateTime.now().subtract(const Duration(days: 30));
      final dateEnd = DateTime.tryParse(state.queryParams["date-end"] ?? "") ??
          DateTime.now();
      final range = DateTimeRange(start: dateStart, end: dateEnd);
      final style = RatingTableStyle.values.firstWhereOrNull(
            (element) => state.queryParams["style"] == element.name,
          ) ??
          RatingTableStyle.full;
      final sort = RatingSort.values.firstWhereOrNull(
            (element) => state.queryParams["sort"] == element.name,
          ) ??
          RatingSort.score;
      final gameFilter =
          int.tryParse(state.queryParams["game-filter"] ?? "") ?? 0;
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
    RatingTableStyle.stats
  ];
  int carouselIndex = 1;
  final CarouselController _carouselController = CarouselController();

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
    if (oldWidget.range != widget.range || oldWidget.clubId != widget.clubId) {
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
        return Column(
          children: [
            Center(
              child: Text(
                state.clubName,
                style: context.theme.headerTextStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Период: "),
                CustomButton(
                  onTap: onChangeRangeTap,
                  disabled: widget.tournamentId != null,
                  text:
                      "${format.format(widget.range.start)} - ${format.format(widget.range.end)}",
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  styleSwitcher(),
                  const SizedBox(width: 8),
                  downloadRatingButton(),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    RatingTable(
                      isMobile: true,
                      style: widget.style,
                      rows: state.rows,
                      clubId: widget.clubId,
                      sort: widget.sort,
                      gameFilter: widget.gameFilter,
                      openGame: (gameId) {
                        if (widget.clubId != null) {
                          context.read<RatingBloc>().add(
                                RatingEvent.gameSelected(
                                  gameId: gameId,
                                  clubId: widget.clubId!,
                                ),
                              );
                        }
                      },
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
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return BlocBuilder<RatingBloc, RatingState>(
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
                    Text(
                      state.clubName,
                      style: MyTheme.of(context).headerTextStyle,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Период: "),
                        CustomButton(
                          onTap: onChangeRangeTap,
                          disabled: widget.tournamentId != null,
                          text:
                              "${format.format(widget.range.start)} - ${format.format(widget.range.end)}",
                        ),
                        const SizedBox(width: 16),
                        Stack(
                          children: [
                            styleSwitcher(),
                          ],
                        ),
                        downloadRatingButton(),
                      ],
                    ),
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
                          openGame: (gameId) {
                            if (widget.clubId != null) {
                              context.read<RatingBloc>().add(
                                    RatingEvent.gameSelected(
                                      gameId: gameId,
                                      clubId: widget.clubId!,
                                    ),
                                  );
                            }
                          },
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
  }

  Widget downloadRatingButton() => widget.clubId == null
      ? Container()
      : IconButton(
          onPressed: () {
            context.read<RatingBloc>().add(
                  RatingEvent.downloadRating(
                    range: widget.range,
                    clubId: widget.clubId!,
                  ),
                );
          },
          icon: const Icon(
            Icons.download,
          ),
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
            child: CarouselSlider(
              carouselController: _carouselController,
              items: items
                  .map(
                    (element) => Center(
                      child: Text(getTextFrom(element)),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
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
