import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/club_avatar.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/utils.dart';

enum ClubRowStyle {
  mobile,
  desktop;
}

class SingleClubRow extends StatelessWidget {
  final ClubModel model;
  final VoidCallback onTap;
  final ClubRowStyle style;

  const SingleClubRow({
    super.key,
    required this.model,
    required this.onTap,
    this.style = ClubRowStyle.desktop,
  });

  Widget buildMobile(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: context.theme.background1,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClubAvatar(
                  clubModel: model,
                  size: 70,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          model.name,
                          style: context.theme.defaultTextStyle,
                        ),
                        const SizedBox(height: 16),
                        const Divider(height: 2),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'ID: ${model.id}',
                              style: MyTheme.of(context).hintTextStyle,
                            ),
                            const Spacer(),
                            Text(
                              model.city != null ? "г. ${model.city}" : " ",
                              style: context.theme.defaultTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDesktop(BuildContext context) {
    return Tooltip(
      message: 'ID: ${model.id}',
      child: InkWell(
        borderRadius: BorderRadius.circular(500),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: 100,
            maxWidth: 1000,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              ClubAvatar(
                clubModel: model,
                size: 70,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  model.name,
                  style: context.theme.defaultTextStyle,
                ),
              ),
              Container(
                width: 3,
                height: 30,
                color: Colors.black,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              if (model.city != null)
                Expanded(
                  child: Text(
                    "г. ${model.city}",
                    style: context.theme.defaultTextStyle,
                  ),
                )
              else
                const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case ClubRowStyle.mobile:
        return buildMobile(context);
      case ClubRowStyle.desktop:
        return buildDesktop(context);
    }
  }
}
