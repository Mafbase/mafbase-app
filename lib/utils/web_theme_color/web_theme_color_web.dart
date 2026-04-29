import 'dart:js_interop';

@JS('setFlutterThemeColor')
external void _setFlutterThemeColor(String color);

void setWebThemeColor(String hexColor) {
  _setFlutterThemeColor(hexColor);
}
