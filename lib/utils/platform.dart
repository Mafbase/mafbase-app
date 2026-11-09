import 'package:flutter/foundation.dart';

/// Подменяет [kIsWeb], чтобы тесты проверяли и веб-, и мобильный вариант экранов.
@visibleForTesting
bool? debugIsWebOverride;

bool get isWebPlatform => debugIsWebOverride ?? kIsWeb;
