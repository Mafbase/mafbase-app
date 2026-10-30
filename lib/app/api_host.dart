/// Хост бэкенда вне веб-релиза, задаётся через `--dart-define=API_HOST=...`.
const apiHost = String.fromEnvironment('API_HOST', defaultValue: 'mafbase.ru');
