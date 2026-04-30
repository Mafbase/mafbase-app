import 'dart:js_interop';

@JS('setFlutterThemeColor')
external void _setFlutterThemeColor(JSString color);

void setWebThemeColor(String hexColor) {
  _setFlutterThemeColor(hexColor.toJS);
}
