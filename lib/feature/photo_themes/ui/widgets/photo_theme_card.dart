import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_model.dart';
import 'package:seating_generator_web/utils.dart';

class PhotoThemeCard extends StatelessWidget {
  final PhotoThemeModel theme;
  final bool isSelected;
  final bool isActive;
  final VoidCallback onTap;

  const PhotoThemeCard({
    super.key,
    required this.theme,
    required this.isSelected,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? MyTheme.of(context).darkBlueColor.withValues(alpha: 0.15) : null,
          border: Border(
            left: BorderSide(
              color: isSelected ? MyTheme.of(context).darkBlueColor : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    theme.name,
                    style: MyTheme.of(context).defaultTextStyle.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    context.locale.photoThemesPhotosCount(theme.photosCount),
                    style: MyTheme.of(context).hintTextStyle,
                  ),
                ],
              ),
            ),
            if (isActive)
              Icon(
                Icons.check_circle,
                color: MyTheme.of(context).positiveColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
