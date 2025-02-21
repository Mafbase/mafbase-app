import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class PlayerRow extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final String nickname;
  final String? imageUrl;
  final int index;

  const PlayerRow({
    super.key,
    required this.onTap,
    required this.index,
    required this.onDelete,
    required this.nickname,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
        ),
        child: Row(
          children: [
            imageUrl == null
                ? Image.asset(
                    AppAssets.playerPhoto,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: imageUrl!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(width: 8),
            Text("${index + 1}.\t$nickname"),
            const Spacer(),
            if (onDelete != null)
              Center(
                child: IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete,
                    size: 24,
                    color: MyTheme.of(context).redColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
