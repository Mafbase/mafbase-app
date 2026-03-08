import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_model.dart';
import 'package:seating_generator_web/utils.dart';

class PhotoThemeSelector extends StatelessWidget {
  final List<PhotoThemeModel> themes;
  final PhotoThemeModel? selectedTheme;
  final ValueChanged<PhotoThemeModel?> onChanged;

  const PhotoThemeSelector({
    super.key,
    required this.themes,
    required this.selectedTheme,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            context.locale.photoThemesSelectorLabel,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomDropdown<PhotoThemeModel?>(
              items: [null, ...themes],
              initValue: selectedTheme,
              mapToString: (item) =>
                  item?.name ?? context.locale.photoThemesProfilePhotos,
              onChanged: (value) => onChanged(value),
            ),
          ),
        ],
      ),
    );
  }
}
