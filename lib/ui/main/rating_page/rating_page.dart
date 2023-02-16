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

class RatingPage extends StatefulWidget {
  final int clubId;
  final DateTimeRange range;
  final RatingTableStyle? style;
  final RatingSort? sort;
  final int? gameFilter;

  const RatingPage({
    Key? key,
    required this.clubId,
    required this.range,
    this.style,
    this.sort,
    this.gameFilter,
  }) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();

  static String createLocation({
    required DateTimeRange range,
    required int clubId,
    required BuildContext context,
    RatingTableStyle tableStyle = RatingTableStyle.full,
    RatingSort sort = RatingSort.score,
    int gameFilter = 0,
  }) {
    return context.namedLocation(
      name,
      params: {"clubId": clubId.toString()},
      queryParams: {
        "date-start": dateFormatForRequests.format(range.start),
        "date-end": dateFormatForRequests.format(range.end),
        "style": tableStyle.name,
        "sort": sort.name,
        "game-filter": gameFilter.toString()
      },
    );
  }

  static const name = 'club_rating';

  static final GoRoute route = GoRoute(
    path: "rating",
    name: name,
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
      );
      final sort = RatingSort.values.firstWhereOrNull(
        (element) => state.queryParams["sort"] == element.name,
      );
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

class _RatingPageState extends State<RatingPage> {
  final format = DateFormat("dd:MM:yyyy");

  @override
  void initState() {
    context.read<RatingBloc>().add(
          RatingEvent.pageOpened(
            range: widget.range,
            clubId: widget.clubId,
          ),
        );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RatingPage oldWidget) {
    if (oldWidget.range != widget.range || oldWidget.clubId != widget.clubId) {
      context.read<RatingBloc>().add(
            RatingEvent.pageOpened(
              range: widget.range,
              clubId: widget.clubId,
            ),
          );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingBloc, RatingState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 0,
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
                            onTap: () async {
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
                                    style:
                                    widget.style ?? RatingTableStyle.full,
                                    sort: widget.sort ?? RatingSort.score,
                                    gameFilter: widget.gameFilter ?? 0,
                                  ),
                                );
                              }
                            },
                            text: "${format.format(widget.range.start)} - ${format.format(widget.range.end)}",
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: () {
                              context.read<RatingBloc>().add(
                                    RatingEvent.downloadRating(
                                      range: widget.range,
                                      clubId: widget.clubId,
                                    ),
                                  );
                            },
                            icon: const Icon(
                              Icons.download,
                            ),
                          ),
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
                            openGame: (gameId) =>
                                context.read<RatingBloc>().add(
                                      RatingEvent.gameSelected(
                                        gameId: gameId,
                                        clubId: widget.clubId,
                                      ),
                                    ),
                            changeSort: (RatingSort sort) {
                              context.read<RatingBloc>().add(
                                    RatingEvent.rangeChanged(
                                      range: widget.range,
                                      clubId: widget.clubId,
                                      style:
                                          widget.style ?? RatingTableStyle.full,
                                      sort: sort,
                                      gameFilter: widget.gameFilter ?? 0,
                                    ),
                                  );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.isLoading) const LoadingOverlayWidget(),
            ],
          ),
        );
      },
    );
  }
}
