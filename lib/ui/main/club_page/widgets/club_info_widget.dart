import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/common/widgets/club_avatar.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/ui/main/club_page/club_bloc.dart';
import 'package:seating_generator_web/ui/main/club_page/club_event.dart';
import 'package:seating_generator_web/utils.dart';

class ClubInfoWidget extends StatelessWidget {
  final ClubModel clubModel;

  const ClubInfoWidget({
    Key? key,
    required this.clubModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ClubModel>.value(
      value: clubModel,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 300,
        ),
        padding: const EdgeInsets.only(
          left: 60,
          top: 40,
          right: 60,
        ),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _ClubInfoHeader(),
                        SizedBox(height: 20),
                        _ClubDescription(),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: CustomButton(
                    text: context.locale.openRating,
                    onTap: () {
                      context
                          .read<ClubBloc>()
                          .add(const ClubEvent.openRating());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClubDescription extends StatelessWidget {
  const _ClubDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ClubModel>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.locale.description,
          style: context.theme.headerTextStyle,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: context.theme.background1,
          ),
          child: Text(
            model.description ?? "Тут пусто",
            style: context.theme.defaultTextStyle,
          ),
        )
      ],
    );
  }
}

class _ClubInfoHeader extends StatelessWidget {
  const _ClubInfoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ClubModel>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClubAvatar(clubModel: model, size: 140),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.name,
              style: context.theme.headerTextStyle,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_city_outlined),
                const SizedBox(width: 4),
                Text(model.city ?? "Не установлен"),
              ],
            )
          ],
        ),
      ],
    );
  }
}
