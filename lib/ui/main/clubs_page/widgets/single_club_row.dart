import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/club_avatar.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/utils.dart';

class SingleClubRow extends StatelessWidget {
  final ClubModel model;
  final VoidCallback onTap;

  const SingleClubRow({
    Key? key,
    required this.model,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                  "г. ${model.city}" ?? "",
                  style: context.theme.defaultTextStyle,
                ),
              )
            else
              const Spacer(),
          ],
        ),
      ),
    );
  }
}
