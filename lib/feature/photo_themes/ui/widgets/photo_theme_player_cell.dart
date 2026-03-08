import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_entry_model.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class PhotoThemePlayerCell extends StatefulWidget {
  final PhotoThemeEntryModel entry;
  final VoidCallback onUploadPhoto;
  final VoidCallback onDeletePhoto;
  final VoidCallback? onRemovePlayer;

  const PhotoThemePlayerCell({
    super.key,
    required this.entry,
    required this.onUploadPhoto,
    required this.onDeletePhoto,
    this.onRemovePlayer,
  });

  @override
  State<PhotoThemePlayerCell> createState() => _PhotoThemePlayerCellState();
}

class _PhotoThemePlayerCellState extends State<PhotoThemePlayerCell> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hasThemePhoto = widget.entry.themeImageUrl != null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: hasThemePhoto ? null : widget.onUploadPhoto,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: hasThemePhoto
                      ? CachedNetworkImage(
                          imageUrl: widget.entry.themeImageUrl!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const SizedBox(
                            width: 80,
                            height: 80,
                            child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image, size: 32),
                          ),
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.add_a_photo,
                            size: 32,
                            color: Colors.grey.shade500,
                          ),
                        ),
                ),
                if (hasThemePhoto && _isHovered)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: widget.onDeletePhoto,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                if ((_isHovered || context.isMobile) && widget.onRemovePlayer != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: InkWell(
                      onTap: widget.onRemovePlayer,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade700.withValues(alpha: 0.8),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.person_remove,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 80,
              child: Text(
                widget.entry.nickname,
                style: MyTheme.of(context).defaultTextStyle.copyWith(
                      fontSize: 12,
                      color: hasThemePhoto ? null : Colors.grey,
                    ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
