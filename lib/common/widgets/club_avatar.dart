import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/utils.dart';

class ClubAvatar extends StatelessWidget {
  final ClubModel clubModel;
  final double size;

  const ClubAvatar({
    super.key,
    required this.clubModel,
    this.size = 70,
  });

  @override
  Widget build(BuildContext context) {
    if (clubModel.imageUrl != null) {
      return Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.hardEdge,
        child: CachedNetworkImage(
          imageUrl: clubModel.imageUrl!,
          height: size,
          width: size,
          fit: BoxFit.cover,
          placeholder: (_, __) => _ImagePlaceholder(
            clubName: clubModel.name,
            size: size,
          ),
        ),
      );
    } else {
      return _ImagePlaceholder(
        clubName: clubModel.name,
        size: size,
      );
    }
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final String clubName;
  final double size;

  const _ImagePlaceholder({
    required this.clubName,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: size,
        width: size,
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
