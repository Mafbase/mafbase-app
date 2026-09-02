# Задача 02 — Overlay-конфиг (breakPlaceholderImageUrl, brandImageUrl)

> Фича: Диплинк-трансляция оператора · Проект: seating-generator-backend · Этап: 2
> Статус: ✅ выполнено (2026-06-19), commit `733beb7`, build+674 тестов зелёные (вкл. MigrationSchemaTest), локально, без push · Зависит от: 00 · Разблокирует: обогащает ответ 01 и 03 (overlay-поля, до этого `null`)

## Контекст
Нативный экран `mafbase_stream` накладывает на видео оверлей: заставку перерыва и брендовую плашку. По BRD (**FR-6**, **FR-7**) бэкенд при выдаче RTMP-кредов должен вернуть `breakPlaceholderImageUrl` и `brandImageUrl`, а клиент сам подставляет константу-разметку `plashkiMafbase` (**D5**). Эта задача добавляет хранение и admin-редактирование этих двух URL на уровне сущности (турнир / клуб) и подключает их к ответу эндпоинта кредов из Задачи 01/03. Без неё эндпоинт кредов возвращает overlay-поля пустыми, что допустимо как промежуточное состояние (граф зависимостей: «02 обогащает ответ 01»).

## Зафиксированные решения
- **D5.** Overlay-константа `plashkiMafbase` задаётся НА КЛИЕНТЕ. Бэкенд только хранит и отдаёт `breakPlaceholderImageUrl` + `brandImageUrl` (+ опционально `overlayDesignKey`). Поэтому в этой задаче: нет рендера/композиции оверлея на бэке, нет валидации картинок — только хранение строк-URL и их выдача.
- `overlayDesignKey` для турнира уже реализован отдельным механизмом: колонка `tournaments.design_key` (`src/main/kotlin/sql/TournamentsTable.kt:26-30`) и эндпоинт `POST /api/tournament/{id}/translation-design` (`src/main/kotlin/modules/TranslationModule.kt:94-103`). Эту задачу он НЕ трогает: при сборке `BroadcastCredentialsOut` для турнира `overlayDesignKey` берётся из существующего `tournamentsRepository.getDesignKey(...)` (`src/main/kotlin/repositories/TournamentsRepository.kt:103-106`). Для клуба аналога нет — `overlayDesignKey` остаётся пустым/опциональным.

## Объём работ

### Что делаем
- **Миграция** `src/main/resources/migrations/V4__stream_overlay_config.sql`: добавить колонки `break_placeholder_image_url VARCHAR(512) NULL` и `brand_image_url VARCHAR(512) NULL` в таблицы `tournaments` И `clubs`. Идемпотентно через `information_schema.COLUMNS`, диалект MySQL — в стиле `V2__club_photo_theme.sql` (`src/main/resources/migrations/V2__club_photo_theme.sql:20-35`).
- **Exposed-таблицы**:
  - `src/main/kotlin/sql/TournamentsTable.kt` — добавить `val breakPlaceholderImageUrl = varchar("break_placeholder_image_url", 512).nullable()` и `val brandImageUrl = varchar("brand_image_url", 512).nullable()` (рядом с `designKey`, `TournamentsTable.kt:26-30`).
  - `src/main/kotlin/sql/ClubsTable.kt` — те же две колонки (рядом с `photoThemeId`, `ClubsTable.kt:28-32`).
- **Репозитории — методы get/set** (зеркало `getDesignKey`/`updateDesignKey`, `TournamentsRepository.kt:103-112`):
  - В `TournamentsRepository`: `getStreamSettings(tournamentId): Pair<String?, String?>` и `updateStreamSettings(tournamentId, breakUrl: String?, brandUrl: String?)`.
  - В клубный репозиторий (тот, где `clubOwnersRepository` управляет доступом; новый или существующий клубный репозиторий по решению backend-developer) — аналогичные `getStreamSettings(clubId)` / `updateStreamSettings(clubId, ...)`.
- **Admin-эндпоинты** (новый модуль либо расширение существующего; регистрация в `Main.kt`):
  - `PUT /api/admin/tournament/{id}/stream-settings` — `auth-jwt` + `tournamentOwnersRepository.canManageOwners(tournamentId, userId)` (паттерн `StreamingApi.kt:35-40`). Тело `SetStreamSettingsEvent` → ответ `StreamSettingsOut`.
  - `PUT /api/admin/club/{id}/stream-settings` — `auth-jwt` + `clubOwnersRepository.canManageOwners(clubId, userId)` (`src/main/kotlin/feature/owners/ClubOwnersRepository.kt:20`). Тело `SetStreamSettingsEvent` → ответ `StreamSettingsOut`.
- **Интеграция в эндпоинт кредов** (Задача 01 для турнира, Задача 03 для клуба): при сборке `BroadcastCredentialsOut` заполнять `breakPlaceholderImageUrl` / `brandImageUrl` из соответствующего `getStreamSettings(...)`, если значения заданы; турнирный `overlayDesignKey` — из `getDesignKey(...)`.

### Что НЕ входит
- Само proto-сообщение `SetStreamSettingsEvent` / `StreamSettingsOut` и поле `BroadcastCredentialsOut.breakPlaceholderImageUrl/brandImageUrl/overlayDesignKey` — владелец **Задача 00** (эта задача только их потребляет после регенерации).
- Сам эндпоинт `GET /api/broadcast/credentials` и токен-логика — **Задача 01** (турнир) и **Задача 03** (клуб). Здесь только описывается, какими значениями эти задачи заполняют overlay-поля.
- Любая загрузка/хостинг самих файлов-картинок (клиент передаёт готовый URL), композиция оверлея, валидация форматов изображений.
- Клубные RTMP-стримы и таблица `club_game_streams` — **Задача 03**.

## Технические детали

### Proto (потребляется из Задачи 00 — append в конец `mafia.proto`, после строки 758)
```proto
message SetStreamSettingsEvent {
  optional string breakPlaceholderImageUrl = 1;
  optional string brandImageUrl = 2;
}

message StreamSettingsOut {
  optional string breakPlaceholderImageUrl = 1;
  optional string brandImageUrl = 2;
}
```
Связанные поля `BroadcastCredentialsOut` (`breakPlaceholderImageUrl = 4`, `brandImageUrl = 5`, `overlayDesignKey = 6`) также объявляет Задача 00.

### Миграция `V4__stream_overlay_config.sql` (MySQL, идемпотентно, стиль `V2`)
```sql
-- Migration V4: Stream overlay config columns for tournaments and clubs.
--
-- Adds nullable URL columns used to build the operator's broadcast overlay:
--   break_placeholder_image_url — заставка перерыва
--   brand_image_url             — брендовая плашка
-- Mirrors the V2 pattern: each ALTER is gated on information_schema.COLUMNS so
-- re-running the migration after a partial failure is a no-op.

-- ---------------------------------------------------------------------------
-- tournaments.break_placeholder_image_url
-- ---------------------------------------------------------------------------
SET @has_col = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME   = 'tournaments'
      AND COLUMN_NAME  = 'break_placeholder_image_url'
);
SET @stmt = IF(
    @has_col = 0,
    'ALTER TABLE tournaments ADD COLUMN break_placeholder_image_url VARCHAR(512) NULL',
    'SELECT 1'
);
PREPARE _mig_p FROM @stmt;
EXECUTE _mig_p;
DEALLOCATE PREPARE _mig_p;

-- ---------------------------------------------------------------------------
-- tournaments.brand_image_url
-- ---------------------------------------------------------------------------
SET @has_col = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME   = 'tournaments'
      AND COLUMN_NAME  = 'brand_image_url'
);
SET @stmt = IF(
    @has_col = 0,
    'ALTER TABLE tournaments ADD COLUMN brand_image_url VARCHAR(512) NULL',
    'SELECT 1'
);
PREPARE _mig_p FROM @stmt;
EXECUTE _mig_p;
DEALLOCATE PREPARE _mig_p;

-- ---------------------------------------------------------------------------
-- clubs.break_placeholder_image_url
-- ---------------------------------------------------------------------------
SET @has_col = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME   = 'clubs'
      AND COLUMN_NAME  = 'break_placeholder_image_url'
);
SET @stmt = IF(
    @has_col = 0,
    'ALTER TABLE clubs ADD COLUMN break_placeholder_image_url VARCHAR(512) NULL',
    'SELECT 1'
);
PREPARE _mig_p FROM @stmt;
EXECUTE _mig_p;
DEALLOCATE PREPARE _mig_p;

-- ---------------------------------------------------------------------------
-- clubs.brand_image_url
-- ---------------------------------------------------------------------------
SET @has_col = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME   = 'clubs'
      AND COLUMN_NAME  = 'brand_image_url'
);
SET @stmt = IF(
    @has_col = 0,
    'ALTER TABLE clubs ADD COLUMN brand_image_url VARCHAR(512) NULL',
    'SELECT 1'
);
PREPARE _mig_p FROM @stmt;
EXECUTE _mig_p;
DEALLOCATE PREPARE _mig_p;
```

### Exposed-колонки
`src/main/kotlin/sql/TournamentsTable.kt` (после `designKey`, строка 30):
```kotlin
val breakPlaceholderImageUrl = varchar("break_placeholder_image_url", 512).nullable()
val brandImageUrl = varchar("brand_image_url", 512).nullable()
```
`src/main/kotlin/sql/ClubsTable.kt` (после `photoThemeId`, строка 32):
```kotlin
val breakPlaceholderImageUrl = varchar("break_placeholder_image_url", 512).nullable()
val brandImageUrl = varchar("brand_image_url", 512).nullable()
```

### Методы репозитория (зеркало `getDesignKey`/`updateDesignKey`, `TournamentsRepository.kt:103-112`)
```kotlin
// TournamentsRepository
fun getStreamSettings(tournamentId: Int): Pair<String?, String?> = transaction {
    TournamentsTable.select { TournamentsTable.id eq tournamentId }
        .firstOrNull()
        ?.let { it.getOrNull(TournamentsTable.breakPlaceholderImageUrl) to it.getOrNull(TournamentsTable.brandImageUrl) }
        ?: (null to null)
}

fun updateStreamSettings(tournamentId: Int, breakPlaceholderImageUrl: String?, brandImageUrl: String?) = transaction {
    TournamentsTable.update({ TournamentsTable.id eq tournamentId }) {
        it[TournamentsTable.breakPlaceholderImageUrl] = breakPlaceholderImageUrl
        it[TournamentsTable.brandImageUrl] = brandImageUrl
    }
}
```
Клубный репозиторий — те же сигнатуры на `ClubsTable` и параметр `clubId`.

### Admin-эндпоинты (паттерн `StreamingApi.kt:30-40` для ownership; `TranslationModule.kt:94-103` для PUT-сеттера)
```kotlin
authenticate("auth-jwt") {
    route("/api/admin/tournament/{id}/stream-settings") {
        apiDoc("Установить overlay-настройки трансляции турнира")
        put {
            val tournamentId = call.parameters["id"]?.toIntOrNull()
                ?: throw BadRequestException("Неверный id турнира")
            val userId = call.getUserId()
            if (!tournamentOwnersRepository.canManageOwners(tournamentId, userId)) {
                throw ForbiddenException("Нет доступа к управлению трансляциями этого турнира")
            }
            val event = call.receive<Mafia.SetStreamSettingsEvent>()
            tournamentsRepository.updateStreamSettings(
                tournamentId,
                if (event.hasBreakPlaceholderImageUrl()) event.breakPlaceholderImageUrl else null,
                if (event.hasBrandImageUrl()) event.brandImageUrl else null,
            )
            val (breakUrl, brandUrl) = tournamentsRepository.getStreamSettings(tournamentId)
            call.respond(streamSettingsOut {
                breakUrl?.let { breakPlaceholderImageUrl = it }
                brandUrl?.let { brandImageUrl = it }
            })
        }
    }
    // /api/admin/club/{id}/stream-settings — зеркало с clubOwnersRepository.canManageOwners(clubId, userId)
}
```
`hasXxx()` / опциональный геттер обязателен, поскольку поля proto объявлены `optional` (как `SetTournamentDesignEvent`, `TranslationModule.kt:99`).

### Интеграция в `BroadcastCredentialsOut` (перекрёстно с Задачами 01 и 03)
- Турнир (Задача 01): после получения RTMP-кредов стола подставить
  `val (breakUrl, brandUrl) = tournamentsRepository.getStreamSettings(tournamentId)` → `breakPlaceholderImageUrl` / `brandImageUrl`; `overlayDesignKey` ← `tournamentsRepository.getDesignKey(tournamentId)` (`TournamentsRepository.kt:103-106`). Все три — опциональны, ставятся только при non-null.
- Клуб (Задача 03): `getStreamSettings(clubId)` для двух URL; `overlayDesignKey` НЕ заполняется (для клуба аналога `design_key` нет — D5, остаётся пустым).

## Definition of Done
- [ ] Файл `src/main/resources/migrations/V4__stream_overlay_config.sql` создан; на чистой БД миграция применяется без ошибок и добавляет `break_placeholder_image_url VARCHAR(512) NULL` и `brand_image_url VARCHAR(512) NULL` в `tournaments` И в `clubs`; повторный прогон миграции — no-op (идемпотентность как в `V2`).
- [ ] В `TournamentsTable.kt` и `ClubsTable.kt` добавлены соответствующие nullable `varchar(512)` колонки; имена колонок ровно `break_placeholder_image_url` и `brand_image_url`.
- [ ] В `TournamentsRepository` и клубном репозитории есть `getStreamSettings` / `updateStreamSettings`.
- [ ] Эндпоинт `PUT /api/admin/tournament/{id}/stream-settings` под `auth-jwt`: запрос от не-владельца возвращает 403; запрос владельца сохраняет значения и возвращает `StreamSettingsOut` с сохранёнными значениями.
- [ ] Эндпоинт `PUT /api/admin/club/{id}/stream-settings` под `auth-jwt`: не-владелец → 403; владелец сохраняет и получает `StreamSettingsOut` (ownership через `ClubOwnersRepository.canManageOwners`).
- [ ] После установки настроек `GET /api/broadcast/credentials` (турнирная ветка, Задача 01) возвращает заполненные `breakPlaceholderImageUrl` / `brandImageUrl`; до установки — поля отсутствуют (опциональны). Для турнира `overlayDesignKey` возвращается из `tournaments.design_key`, когда он задан.
- [ ] Новый/расширенный модуль зарегистрирован в `Main.kt` (рядом с `configureStreaming` `Main.kt:211`), нужные репозитории проброшены через `AppAssembly` (рядом с `streamingRepository` `AppAssembly.kt:169-171`).
- [ ] `./gradlew build` зелёный (используется свежесгенерированный proto-код из Задачи 00).

## Порядок и зависимости
- **До**: Задача 00 (proto `SetStreamSettingsEvent` / `StreamSettingsOut` + overlay-поля `BroadcastCredentialsOut` сгенерированы и закоммичены в сабмодуль `seating-generator-proto`). Без сгенерированных классов `Mafia.SetStreamSettingsEvent` / билдера `streamSettingsOut {}` код не компилируется.
- **Параллельно/после**: интеграция overlay-полей в ответ кредов выполняется совместно с Задачей 01 (турнир) и Задачей 03 (клуб). До завершения этой задачи 01/03 отдают overlay-поля пустыми — это допустимое промежуточное состояние.
- Версия миграции фиксирована: `V4` (следующая после `V3__broadcast_token.sql` из Задачи 01). Не конфликтует с `V3` и `V5`.

## Риски / открытые вопросы
- Клубный stream-settings репозиторий: если на момент работы клубный RTMP-репозиторий из Задачи 03 ещё не создан, методы `getStreamSettings`/`updateStreamSettings(clubId)` следует разместить в подходящем существующем клубном репозитории (например, `ClubTranslationRepository`, `AppAssembly.kt:165-167`), чтобы не плодить конфликт владения. Согласовать с исполнителем Задачи 03.
- `overlayDesignKey` для клуба остаётся пустым осознанно (D5) — если в будущем потребуется клубный design_key, это отдельная фича вне scope.

## Затрагиваемые файлы
| Файл | Действие (создать/изменить) |
|---|---|
| `src/main/resources/migrations/V4__stream_overlay_config.sql` | создать |
| `src/main/kotlin/sql/TournamentsTable.kt` | изменить (2 колонки) |
| `src/main/kotlin/sql/ClubsTable.kt` | изменить (2 колонки) |
| `src/main/kotlin/repositories/TournamentsRepository.kt` | изменить (get/set stream-settings) |
| Клубный репозиторий (напр. `src/main/kotlin/feature/club_translation/ClubTranslationRepository.kt`) | изменить (get/set stream-settings) |
| Модуль stream-settings эндпоинтов (новый или расширение `StreamingApi.kt`) | создать/изменить |
| `src/main/kotlin/Main.kt` | изменить (регистрация модуля) |
| `src/main/kotlin/AppAssembly.kt` | изменить (проброс репозиториев при необходимости) |
| `seating-generator-proto/mafia.proto` | потребляется (владелец — Задача 00) |
