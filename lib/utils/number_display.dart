extension NumDisplayExt on num {
  /// Текст числа как в dart2js: целые `double` без `.0`, иначе как `toString()`.
  String toDisplayString() {
    final text = toString();
    return text.endsWith('.0') && text != '-0.0' ? text.substring(0, text.length - 2) : text;
  }
}
