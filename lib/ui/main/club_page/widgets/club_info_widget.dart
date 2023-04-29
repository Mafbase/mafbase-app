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
  final bool isMobile;

  const ClubInfoWidget({
    Key? key,
    required this.clubModel,
    this.isMobile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<bool>.value(
      value: isMobile,
      child: Provider<ClubModel>.value(
        value: clubModel,
        child: isMobile
            ? buildMobile(context)
            : Container(
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
                      const _ClubRatingButton(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [
                _ClubInfoHeader(),
                SizedBox(height: 20),
                _ClubDescription(),
                Spacer()
              ],
            ),
          ),
        ),
        const Divider(),
        const _ClubRatingButton(),
      ],
    );
  }
}

class _ClubRatingButton extends StatelessWidget {
  const _ClubRatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: CustomButton(
          text: context.locale.openRating,
          onTap: () {
            context.read<ClubBloc>().add(const ClubEvent.openRating());
          },
        ),
      ),
    );
  }
}

class _ClubDescription extends StatelessWidget {
  const _ClubDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = context.watch<bool>();
    if (isMobile) {
      return buildMobile(context);
    }
    final model = context.watch<ClubModel>();
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

  Widget buildMobile(BuildContext context) {
    final model = context.watch<ClubModel>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? Colors.transparent,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.darkGreyColor,
                  ),
                  child: Icon(
                    Icons.description_outlined,
                    color: context.theme.greyColor,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    context.locale.clubDescription,
                    style: context.theme.headerTextStyle.copyWith(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              model.description ?? "Тут пусто",
              style: context.theme.defaultTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class _ClubInfoHeader extends StatelessWidget {
  const _ClubInfoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = context.watch<bool>();
    if (isMobile) {
      return buildMobile(context);
    }
    final model = context.watch<ClubModel>();
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
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMobile(BuildContext context) {
    final clubModel = context.watch<ClubModel>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClubAvatar(clubModel: clubModel),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                clubModel.name,
                style: context.theme.headerTextStyle,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 70,
              height: 70,
              child: Center(
                child: Icon(
                  Icons.location_city_outlined,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(clubModel.city ?? "Не установлен"),
          ],
        ),
      ],
    );
  }
}
