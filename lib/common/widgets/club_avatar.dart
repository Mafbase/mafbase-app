import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/utils.dart';

class ClubAvatar extends StatelessWidget {
  final ClubModel clubModel;
  final double size;
  final BorderRadius? borderRadius;
  final Color? placeholderColor;

  const ClubAvatar({
    super.key,
    required this.clubModel,
    this.size = 70,
    this.borderRadius,
    this.placeholderColor,
  });

  @override
  Widget build(BuildContext context) {
    if (clubModel.imageUrl != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: borderRadius == null ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: borderRadius,
        ),
        clipBehavior: Clip.hardEdge,
        child: CachedNetworkImage(
          imageUrl: clubModel.imageUrl!,
          height: size,
          width: size,
          fit: BoxFit.cover,
          placeholder: (_, __) => _ImagePlaceholder(
            clubName: clubModel.name,
            size: size,
            borderRadius: borderRadius,
            color: placeholderColor,
          ),
        ),
      );
    } else {
      return _ImagePlaceholder(
        clubName: clubModel.name,
        size: size,
        borderRadius: borderRadius,
        color: placeholderColor,
      );
    }
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final String clubName;
  final double size;
  final BorderRadius? borderRadius;
  final Color? color;

  const _ImagePlaceholder({
    required this.clubName,
    required this.size,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = color ?? context.theme.greyColor;
    final letter = clubName.isNotEmpty ? clubName.substring(0, 1).toUpperCase() : '';

    if (borderRadius != null) {
      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontSize: size * 0.36,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return ClipOval(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(color: bgColor),
        child: Center(
          child: Text(
            letter,
            style: context.theme.defaultTextStyle,
          ),
        ),
      ),
    );
  }
}
