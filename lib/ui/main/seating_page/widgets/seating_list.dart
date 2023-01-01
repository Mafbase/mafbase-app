import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/game_result_widget.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';

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
        return Stack(
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            IgnorePointer(
              ignoring: true,
              child: Opacity(
                opacity: 0,
                child: models[columnIndex].isNotEmpty
                    ? GameResultWidget(model: models[columnIndex].first)
                    : Container(),
              ),
            ),
            Positioned.fill(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: models[columnIndex].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: GameResultWidget(
                        model: models[columnIndex][index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
