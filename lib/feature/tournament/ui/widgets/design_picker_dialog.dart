import 'package:flutter/material.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class DesignPickerDialog extends StatefulWidget {
  final List<DesignModel> designs;
  final int initialIndex;

  const DesignPickerDialog._({
    required this.designs,
    required this.initialIndex,
  });

  static Future<DesignModel?> open({
    required BuildContext context,
    required List<DesignModel> designs,
    int initialIndex = 0,
  }) {
    return Navigator.of(context, rootNavigator: true).push<DesignModel>(
      _DesignPickerRoute(
        designs: designs,
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  State<DesignPickerDialog> createState() => _DesignPickerDialogState();
}

class _DesignPickerRoute extends PageRoute<DesignModel> {
  final List<DesignModel> designs;
  final int initialIndex;

  _DesignPickerRoute({
    required this.designs,
    required this.initialIndex,
  });

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => Colors.black54;

  @override
  String? get barrierLabel => 'Close';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return DesignPickerDialog._(
      designs: designs,
      initialIndex: initialIndex,
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class _DesignPickerDialogState extends State<DesignPickerDialog> {
  late final PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return Center(
      child: Dialog(
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.locale.translationDesignPickerTitle,
                      style: theme.headerTextStyle,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.designs.length,
                        onPageChanged: (index) => setState(() => _currentPage = index),
                        itemBuilder: (context, index) {
                          final design = widget.designs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: FullscreenViewerWrapper(
                                    closeIcon: CloseButton(color: Colors.white),
                                    heroTag: 'design-preview-${design.designKey}',
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        design.preview,
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) => const Center(
                                          child: Icon(Icons.image_not_supported, size: 48),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  design.title,
                                  style: theme.defaultTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.designs.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: index == _currentPage ? theme.blueForCard : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!context.isMobile)
                          IconButton(
                            onPressed: _currentPage > 0
                                ? () => _pageController.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    )
                                : null,
                            icon: const Icon(Icons.chevron_left, size: 32),
                          ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, widget.designs[_currentPage]),
                          child: Text(context.locale.translationDesignSelect),
                        ),
                        if (!context.isMobile)
                          IconButton(
                            onPressed: _currentPage < widget.designs.length - 1
                                ? () => _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    )
                                : null,
                            icon: const Icon(Icons.chevron_right, size: 32),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
