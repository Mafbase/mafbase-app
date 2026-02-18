# Правила работы с локализацией

## Общие принципы

1. **Все пользовательские строки должны быть локализованы** - никогда не используйте хардкод строк в UI коде
2. **Используйте расширение `context.locale`** для доступа к локализованным строкам
3. **Файл локализации**: `lib/l10n/app_ru.arb` - содержит все строки на русском языке
4. **Генерация кода**: После добавления новых строк в `.arb` файл запустите `fvm flutter gen-l10n`

# Правила проверки кода

## Проверка ошибок

1. **Всегда используйте `fvm flutter analyze` для проверки ошибок** - это основной инструмент для статического анализа кода
2. **После внесения изменений в код запускайте `fvm flutter analyze`** для проверки на наличие ошибок компиляции и предупреждений
3. **Исправляйте все ошибки (error)** перед завершением работы над задачей
4. **Обращайте внимание на предупреждения (warning)** - их желательно исправлять, но они не блокируют компиляцию
5. **Информационные сообщения (info)** можно игнорировать, если они не критичны

## Структура локализации

### Файлы локализации
- `lib/l10n/app_ru.arb` - основной файл с переводами (JSON формат)
- `lib/l10n/app_localizations.dart` - автогенерируемый файл с классами локализации
- `lib/utils.dart` - содержит расширение `BuildContextLocaleExt` для удобного доступа

### Формат записи в .arb файле

```json
{
  "keyName": "Текст на русском",
  "@keyName": {},
  "keyWithParam": "Текст с параметром {param}",
  "@keyWithParam": {
    "placeholders": {
      "param": {
        "type": "String",
        "example": "пример"
      }
    }
  }
}
```

## Использование в коде

### Базовое использование

```dart
// ❌ ПЛОХО - хардкод строки
Text('Заголовок')

// ✅ ХОРОШО - локализованная строка
Text(context.locale.someKey)
```

### С параметрами

```dart
// В .arb файле:
// "fantasyPoints": "{count} очков"

// В коде:
Text(context.locale.fantasyPoints(10))
```

### Именование ключей

- Используйте camelCase для ключей
- Группируйте ключи по фичам с префиксом (например, `fantasy*`, `tournament*`, `login*`)
- Используйте описательные имена: `fantasyRatingEmpty` вместо `empty`

## Процесс добавления новой строки

1. **Добавьте строку в `lib/l10n/app_ru.arb`**:
   ```json
   "fantasyNewFeature": "Новая фича",
   "@fantasyNewFeature": {}
   ```

2. **Запустите генерацию**:
   ```bash
   fvm flutter gen-l10n
   ```

3. **Используйте в коде**:
   ```dart
   Text(context.locale.fantasyNewFeature)
   ```

## Примеры из проекта

### Простые строки
```dart
// В .arb: "fantasy": "Фентези"
Text(context.locale.fantasy)
```

### С параметрами
```dart
// В .arb: "fantasyGame": "Игра {number}"
Text(context.locale.fantasyGame(gameNumber))
```

### Комбинирование строк
```dart
// Используйте несколько локализованных строк
Text('${context.locale.fantasyGame(gameNumber)}: ${context.locale.fantasyYourPrediction}')
```

## Важные замечания

1. **Не используйте конкатенацию строк** - лучше создайте отдельный ключ с параметрами
2. **Проверяйте наличие ключа** - если ключ отсутствует, приложение упадет
3. **Обновляйте локализацию** - после изменений в `.arb` всегда запускайте `fvm flutter gen-l10n`
4. **Используйте расширение `context.locale`** - оно уже настроено в `lib/utils.dart`

## Проверка перед коммитом

- [ ] Все строки в UI коде используют `context.locale`
- [ ] Новые ключи добавлены в `app_ru.arb`
- [ ] Запущен `fvm flutter gen-l10n`
- [ ] Код компилируется без ошибок

# Правила организации кода и виджетов

## Разделение на виджеты

1. **Большие файлы должны быть разбиты на более мелкие виджеты** - если файл страницы превышает 300-400 строк, его необходимо разбить на отдельные виджеты
2. **Каждый виджет должен иметь одну ответственность** - виджет должен отвечать за одну конкретную часть UI
3. **Создавайте отдельные файлы для виджетов** - выносите виджеты в отдельные файлы в папке `widgets/` внутри фичи
4. **Используйте описательные имена** - имена виджетов должны четко отражать их назначение (например, `FantasyRatingSection`, `FantasyPredictionChip`)

## Структура виджетов

### Когда создавать отдельный виджет:

- **Повторяющиеся блоки UI** - если один и тот же UI используется в нескольких местах
- **Сложные секции** - если секция страницы содержит много логики и UI элементов
- **Диалоги и модальные окна** - каждый диалог должен быть отдельным виджетом
- **Bottom sheets и drawers** - выносите в отдельные виджеты
- **Списки и элементы списков** - каждый элемент списка должен быть отдельным виджетом

### Примеры разделения:

```dart
// ❌ ПЛОХО - все в одном файле (600+ строк)
class FantasyPage extends StatefulWidget {
  // ... 600 строк кода со всеми виджетами внутри
}

// ✅ ХОРОШО - разделено на отдельные виджеты
// fantasy_page.dart (150 строк) - только основная структура
// widgets/fantasy_rating_section.dart - секция рейтинга
// widgets/fantasy_prediction_section.dart - секция предсказаний
// widgets/fantasy_notifications_banner.dart - баннер уведомлений
// widgets/fantasy_participants_bottom_sheet.dart - bottom sheet участников
```

## Организация файлов

### Структура папок для фичи:

```
lib/feature/fantasy/ui/
  - fantasy_page.dart (основная страница)
  - fantasy_bloc.dart
  - fantasy_state.dart
  - fantasy_event.dart
  - widgets/
    - fantasy_rating_section.dart
    - fantasy_prediction_section.dart
    - fantasy_notifications_banner.dart
    - fantasy_participants_bottom_sheet.dart
    - fantasy_add_participant_dialog.dart
    - fantasy_rating_row.dart
    - fantasy_prediction_chip.dart
    - fantasy_header.dart
    - fantasy_game_win_utils.dart (утилиты)
```

## Правила именования виджетов

- Используйте префикс фичи для всех виджетов фичи (например, `Fantasy*`)
- Используйте описательные имена: `FantasyRatingSection` вместо `RatingWidget`
- Группируйте связанные виджеты по назначению (section, dialog, banner, chip, row и т.д.)

## Вспомогательные функции и утилиты

- Выносите повторяющуюся логику в отдельные файлы с утилитами
- Используйте расширения (extensions) для часто используемых операций
- Группируйте утилиты по функциональности в отдельные файлы

## Пример рефакторинга

```dart
// До: один большой файл с методами _build*
class _FantasyPageState extends State<FantasyPage> {
  Widget _buildRatingSection(...) { /* 100 строк */ }
  Widget _buildPredictionSection(...) { /* 80 строк */ }
  Widget _buildNotificationsBanner(...) { /* 50 строк */ }
  void _showParticipantsBottomSheet(...) { /* 100 строк */ }
  // ... еще методы
}

// После: отдельные виджеты
class _FantasyPageState extends State<FantasyPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FantasyHeader(...),
        FantasyNotificationsBanner(),
        FantasyRatingSection(...),
        FantasyPredictionSection(...),
      ],
    );
  }
}
```

# Правила Dependency Injection

## Использование DependencyScope/StorageFactory/RepositoryFactory

1. **Используйте DependencyScope для Dependency Injection** - это современный подход для управления зависимостями в приложении
2. **getIt считается устаревшим** - не используйте `getIt` для получения зависимостей, используйте вместо этого `DependencyScope`, `StorageFactory` и `RepositoryFactory`
3. **Все зависимости должны передаваться через конструктор** - сервисы и репозитории должны получать свои зависимости через конструктор, а не через глобальный контейнер

## Структура DI

### DependencyScope
- Основной контейнер зависимостей, доступный через `DependencyScope.of(context)`
- Содержит `StorageFactory` и `RepositoryFactory`
- Используется для получения доступа к фабрикам зависимостей

### StorageFactory
- Фабрика для создания и получения хранилищ (Storage)
- Доступ через `StorageFactory.of(context)`
- Примеры: `tokenStorage`, `credentialStorage`

### RepositoryFactory
- Фабрика для создания и получения репозиториев
- Доступ через `RepositoryFactory.of(context)`
- Примеры: `authRepository`, `clubRepository`, `profileRepository`

## Использование в коде

### ❌ ПЛОХО - использование getIt (устаревший подход)

```dart
import 'package:seating_generator_web/app/get_it_register.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = getIt<AuthRepository>(); // ❌ Устаревший подход
    final storage = getIt<TokenStorage>(); // ❌ Устаревший подход
    // ...
  }
}
```

### ✅ ХОРОШО - использование DependencyScope/StorageFactory/RepositoryFactory

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = RepositoryFactory.of(context).authRepository; // ✅ Современный подход
    final storage = StorageFactory.of(context).tokenStorage; // ✅ Современный подход
    // ...
  }
}
```

### Получение зависимостей в виджетах

```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получение репозитория
    final authRepository = RepositoryFactory.of(context).authRepository;
    
    // Получение хранилища
    final tokenStorage = StorageFactory.of(context).tokenStorage;
    final credentialStorage = StorageFactory.of(context).credentialStorage;
    
    // Получение notifier через DependencyScope
    final authNotifier = DependencyScope.of(context).authNotifier;
    
    return Scaffold(
      // ...
    );
  }
}
```

### Передача зависимостей через конструктор

```dart
// ✅ ХОРОШО - зависимости через конструктор
class MyService {
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  MyService(this._authRepository, this._tokenStorage);
}

// ❌ ПЛОХО - зависимости через getIt внутри класса
class MyService {
  MyService() {
    _authRepository = getIt<AuthRepository>(); // ❌ Устаревший подход
  }
}
```

## Миграция с getIt

При рефакторинге существующего кода:

1. **Замените `getIt<T>()` на соответствующий фабричный метод**:
   - Репозитории → `RepositoryFactory.of(context).repositoryName`
   - Хранилища → `StorageFactory.of(context).storageName`
   - Notifiers → `DependencyScope.of(context).notifierName`

2. **Убедитесь, что виджет имеет доступ к BuildContext** - DependencyScope доступен только через BuildContext

3. **Для сервисов передавайте зависимости через конструктор** - не используйте getIt внутри сервисов

## Проверка перед коммитом

- [ ] Все использования `getIt` заменены на `DependencyScope`/`StorageFactory`/`RepositoryFactory` (кроме get_it_register.dart)
- [ ] Все сервисы и репозитории получают зависимости через конструктор
- [ ] Код компилируется без ошибок
