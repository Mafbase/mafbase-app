import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/widgets/game_result_widget.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';

class SeatingList extends StatelessWidget {
  final List<List<GameResultModel>> models;

  const SeatingList({
    super.key,
    required this.models,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final coef = min(
          min(
            (constraints.maxHeight / 584),
            constraints.maxWidth / 432,
          ),
          1.0,
        );

        final pageView = constraints.maxWidth < 500;

        Widget itemBuilder(BuildContext context, int columnIndex) {
          final children = models[columnIndex].map((model) {
            return InkWell(
              onTap: () {
                context.read<SeatingPageBloc>().add(
                      SeatingPageEvent.openGameEditing(
                        gameId: model.gameId,
                      ),
                    );
              },
              child: GameResultWidget(
                model: model,
                width: GameResultWidget.baseWidth * coef,
                height: GameResultWidget.baseHeight * coef,
              ),
            );
          }).toList();

          if (pageView) {
            return SizedBox(
              height: constraints.maxHeight,
              child: PageView(
                children: children
                    .map(
                      (e) => Align(
                        alignment: Alignment.topCenter,
                        child: e,
                      ),
                    )
                    .toList(),
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, layout) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                constraints: BoxConstraints(
                  minWidth: layout.maxWidth,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: e,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        }

        if (pageView) {
          return PageView.builder(
            itemCount: models.length,
            itemBuilder: itemBuilder,
            scrollDirection: Axis.vertical,
          );
        }

        return ListView.separated(
          itemCount: models.length,
          itemBuilder: itemBuilder,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 32);
          },
        );
      },
    );
  }
}
