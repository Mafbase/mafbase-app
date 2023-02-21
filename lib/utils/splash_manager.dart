import 'package:flutter/widgets.dart';

class SplashManager {
  static WidgetsBinding? _binding;

  SplashManager._();

  static void deferSplash(WidgetsBinding widgetsBinding) {
    _binding = widgetsBinding;
    _binding?.deferFirstFrame();
  }

  static void removeSplash() {
    _binding?.allowFirstFrame();
    _binding = null;
  }
}
