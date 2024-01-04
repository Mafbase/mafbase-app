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
    Key? key,
    required this.models,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final coef = min(
          min(
            (constraints.maxHeight / 552),
            constraints.maxWidth / 432,
          ),
          1.0,
        );

        final pageView = coef < .99 || constraints.maxWidth < 500;

        Widget itemBuilder(BuildContext context, int columnIndex) {
          final children = models[columnIndex].map((model) {
            return Transform.scale(
              scale: coef,
              child: InkWell(
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
              ),
            );
          }).toList();

          if (pageView) {
            return SizedBox(
              height: constraints.maxHeight,
              child: Center(
                child: PageView(
                  children: children
                      .map(
                        (e) => Center(
                          child: e,
                        ),
                      )
                      .toList(),
                ),
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
                  children: children,
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
