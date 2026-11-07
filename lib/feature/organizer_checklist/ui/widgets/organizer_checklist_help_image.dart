import 'package:flutter/material.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';
import 'package:seating_generator_web/utils.dart';

/// Скриншот справки: вписан в ширину листа, по нажатию открывается на весь экран.
class OrganizerChecklistHelpImage extends StatelessWidget {
  final String asset;

  const OrganizerChecklistHelpImage({super.key, required this.asset});

  static const _maxHeight = 320.0;

  String get _heroTag => 'checklist-help-$asset';

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final borderRadius = BorderRadius.circular(8);

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: _maxHeight),
        child: Container(
          foregroundDecoration: BoxDecoration(
            border: Border.all(color: theme.borderColor),
            borderRadius: borderRadius,
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Image.asset(
              asset,
              excludeFromSemantics: true,
              // До загрузки у картинки нулевой размер: значок и область нажатия появляются вместе с ней.
              frameBuilder: (context, image, frame, _) => Stack(
                children: [
                  Hero(tag: _heroTag, child: image),
                  if (frame != null) ...[
                    PositionedDirectional(
                      end: 6,
                      bottom: 6,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.avatarUploadOverlayColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(Icons.zoom_in, size: 18, color: theme.btnTextColor),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Semantics(
                        button: true,
                        child: Tooltip(
                          message: context.locale.checklistHelpImageZoom,
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () => FullscreenImageViewer.open(
                                context: context,
                                child: Hero(tag: _heroTag, child: Image.asset(asset, excludeFromSemantics: true)),
                                closeWidget: const CloseButton(color: Colors.white),
                              ),
                              child: const SizedBox.expand(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
