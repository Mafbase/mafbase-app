import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_bloc.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_event.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_state.dart';
import 'package:seating_generator_web/ui/main/rating_page/widgets/rating_table.dart';

class RatingPage extends StatefulWidget {
  final int clubId;
  final DateTimeRange range;

  const RatingPage({
    Key? key,
    required this.clubId,
    required this.range,
  }) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();

  static String createLocation({
    required DateTimeRange range,
    required int clubId,
    required BuildContext context,
  }) {
    final format = DateFormat("yyyy-MM-dd");
    return context.namedLocation(
      name,
      params: {"clubId": clubId.toString()},
      queryParams: {
        "date-start": format.format(range.start),
        "date-end": format.format(range.end)
      },
    );
  }

  static const name = 'club_rating';

  static final GoRoute route = GoRoute(
    path: "/club/:clubId/rating",
    name: name,
    builder: (context, state) {
      final clubId = int.parse(state.params["clubId"]!);
      final dateStart =
          DateTime.tryParse(state.queryParams["date-start"] ?? "") ??
              DateTime.now().subtract(const Duration(days: 30));
      final dateEnd = DateTime.tryParse(state.queryParams["date-end"] ?? "") ??
          DateTime.now();
      final range = DateTimeRange(start: dateStart, end: dateEnd);

      return BlocProvider<RatingBloc>(
        create: (context) {
          return getIt(param1: context);
        },
        child: RatingPage(clubId: clubId, range: range),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Период: "),
                          InkWell(
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
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyTheme.of(context).darkGreyColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "${format.format(widget.range.start)} - ${format.format(widget.range.end)}",
                                style: MyTheme.of(context)
                                    .btnTextStyle
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: RatingTable(
                          rows: state.rows,
                          clubId: widget.clubId,
                          openGame: (gameId) => context.read<RatingBloc>().add(
                                RatingEvent.gameSelected(
                                  gameId: gameId,
                                  clubId: widget.clubId,
                                ),
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
