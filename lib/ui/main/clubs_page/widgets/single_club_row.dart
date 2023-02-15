import 'package:flutter/material.dart';
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
            if (model.imageUrl != null)
              Image.network(
                model.imageUrl!,
                height: 70,
                width: 70,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return _ImagePlaceholder(clubName: model.name);
                },
              )
            else
              _ImagePlaceholder(clubName: model.name),
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

class _ImagePlaceholder extends StatelessWidget {
  final String clubName;

  const _ImagePlaceholder({Key? key, required this.clubName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: context.theme.greyColor,
        ),
        child: Center(
          child: Text(
            clubName.substring(0, 1).toUpperCase(),
            style: context.theme.defaultTextStyle,
          ),
        ),
      ),
    );
  }
}
