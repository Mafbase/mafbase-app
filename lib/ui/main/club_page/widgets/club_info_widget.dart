import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/club_avatar.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/ui/main/club_page/club_bloc.dart';
import 'package:seating_generator_web/ui/main/club_page/club_event.dart';
import 'package:seating_generator_web/utils.dart';

class ClubInfoWidget extends StatelessWidget {
  final ClubModel clubModel;
  final bool isMobile;
  final VoidCallback? onAddGame;
  final VoidCallback? billClub;
  final VoidCallback? changeHideDate;
  final VoidCallback? onEditDescription;
  final VoidCallback? onEditPhoto;

  const ClubInfoWidget({
    super.key,
    required this.clubModel,
    this.isMobile = false,
    this.onAddGame,
    this.billClub,
    this.changeHideDate,
    this.onEditDescription,
    this.onEditPhoto,
  });

  @override
  Widget build(BuildContext context) => Provider<bool>.value(
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
                                children: [
                                  _ClubInfoHeader(onEditPhoto: onEditPhoto),
                                  SizedBox(height: 20),
                                  _ClubDescription(
                                    onEditDescription: onEditDescription,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (changeHideDate != null)
                              Tooltip(
                                message: 'Скрыть рейтинг',
                                child: IconButton(
                                  onPressed: changeHideDate,
                                  icon: const Icon(
                                    Icons.pivot_table_chart_outlined,
                                  ),
                                ),
                              ),
                            const Flexible(child: _ClubRatingButton()),
                            if (onAddGame != null)
                              _AddGameButton(onTap: onAddGame!),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );

  Widget buildMobile(BuildContext context) {
    final showBill = context
            .watch<AuthNotifier>()
            .value
            .mapOrNull(authorized: (model) => !model.hideBilling) ??
        true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _ClubInfoHeader(onEditPhoto: onEditPhoto),
                const SizedBox(height: 20),
                _ClubDescription(onEditDescription: onEditDescription),
                if (onEditDescription != null) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Редактировать описание',
                      onTap: onEditDescription!,
                    ),
                  ),
                ],
                if (billClub != null && showBill) ...[
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Продлить подписку клуба',
                    onTap: billClub!,
                  ),
                ],
                if (changeHideDate != null && kIsWeb) ...[
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Скрыть рейтинг',
                    onTap: changeHideDate!,
                  ),
                ],
              ],
            ),
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(child: _ClubRatingButton()),
            if (onAddGame != null) ...[
              _AddGameButton(onTap: onAddGame!),
              const SizedBox(width: 12),
            ],
          ],
        ),
      ],
    );
  }
}

class _ClubRatingButton extends StatelessWidget {
  const _ClubRatingButton();

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

class _AddGameButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddGameButton({required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MyTheme.of(context).darkGreyColor,
          ),
          child: const Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ),
      );
}

class _ClubDescription extends StatelessWidget {
  final VoidCallback? onEditDescription;

  const _ClubDescription({this.onEditDescription});

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
        Row(
          children: [
            Text(
              context.locale.description,
              style: context.theme.headerTextStyle,
            ),
            if (onEditDescription != null) ...[
              const SizedBox(width: 8),
              IconButton(
                onPressed: onEditDescription,
                tooltip: 'Редактировать описание',
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ],
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
        ),
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
                if (onEditDescription != null)
                  IconButton(
                    onPressed: onEditDescription,
                    tooltip: 'Редактировать описание',
                    icon: const Icon(Icons.edit_outlined),
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
  final VoidCallback? onEditPhoto;

  const _ClubInfoHeader({this.onEditPhoto});

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
        Stack(
          children: [
            ClubAvatar(clubModel: model, size: 140),
            if (onEditPhoto != null)
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: context.theme.darkGreyColor,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onEditPhoto,
                    tooltip: 'Сменить фото',
                    icon: const Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
          ],
        ),
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
            Stack(
              children: [
                ClubAvatar(clubModel: clubModel),
                if (onEditPhoto != null)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: context.theme.darkGreyColor,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onEditPhoto,
                        tooltip: 'Сменить фото',
                        icon: const Icon(
                          Icons.photo_camera_outlined,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
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
