import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/widgets/game_result_widget.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';

class SeatingList extends StatelessWidget {
  final List<List<GameResultModel>> models;

  const SeatingList({
    Key? key,
    required this.models,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: models.length,
      itemBuilder: (context, columnIndex) {
        return LayoutBuilder(
          builder: (context, layout) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(
                minWidth: layout.maxWidth,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: models[columnIndex].map((model) {
                  return InkWell(
                    onTap: () {
                      context.read<SeatingPageBloc>().add(
                            SeatingPageEvent.openGameEditing(
                              gameId: model.gameId,
                            ),
                          );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GameResultWidget(
                        model: model,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 8,
        );
      },
    );
  }
}
