# Задача 01 — Эндпоинт кредов оператора + per-table токен (турнир)

> Фича: Диплинк-трансляция оператора · Проект: seating-generator-backend · Этап: 1
> Статус: ✅ выполнено (2026-06-19), commit `7ab1acb`, build+тесты зелёные, локально, без push · Зависит от: 00 (proto-контракты) · Разблокирует: клиентский турнирный флоу (`/broadcast` резолвер), частично 02 (наполнение overlay-полей) и 03 (клубная ветка переиспользует паттерн)

## Контекст
Это ядро фичи и критический путь. Оператор открывает диплинк `…/broadcast?tournamentId=&table=&key=`, приложение по `key` (без логина) запрашивает у бэкенда RTMP-креды стола и сразу открывает нативный экран трансляции (BRD §4.3, FR-6, FR-7). Сам RTMP-ключ в URL не передаётся — только токен `key` (NFR-1). Задача добавляет per-table broadcast-токен в `game_streams`, публичный эндпоинт выдачи кредов и admin-ротацию токена для турнирной ветки.

Релевантные требования BRD: **FR-6** (эндпоинт выдачи кредов по `key`, невалидный `key` → 403), **NFR-1** (ключ не в URL; ротация инвалидирует старые ссылки; rate-limit), **NFR-5** (понятные сообщения об ошибках).

## Зафиксированные решения
- **D1.** Токен диплинка = ОТДЕЛЬНЫЙ per-table broadcast-токен, случайный (`SecureRandom`), хранится в БД по каждому столу, ротируемый. НЕ переиспользуем translation-key `hash("$tournamentId$salt")` из `modules/TranslationModule.kt:192` и `feature/club_translation/ClubTranslationApi.kt:84`. Причина — разделение прав: translation-key даёт контроль контента плашки, broadcast-токен даёт право публикации RTMP; смешивать нельзя (BRD §7, открытый вопрос 1 → решено в пользу отдельного токена).
- **D2.** Жизненный цикл ссылки = БЕССРОЧНЫЙ до ротации токена. Без TTL, без одноразовости. Единственный механизм инвалидации — `rotate-token` (перезапись значения).
- **D4.** Блокировка двух операторов на одном столе ВНЕ scope бэкенда (ответственность RTMP-сервера). Эндпоинт кредов отдаёт одни и те же креды любому держателю валидного токена.
- **D5.** Overlay-поля (`breakPlaceholderImageUrl`, `brandImageUrl`, `overlayDesignKey`) задаются в Задаче 02; здесь они присутствуют в ответе, но всегда `null`/не set.

## Объём работ
### Что делаем
- **Миграция `V3__broadcast_token.sql`** (`src/main/resources/migrations/`): `ALTER TABLE game_streams ADD COLUMN broadcast_token VARCHAR(64) NULL` + UNIQUE индекс на `broadcast_token`. Идемпотентно, в стиле `V2__club_photo_theme.sql` (gating через `information_schema`).
- **`sql/GameStreamsTable.kt`** (текущее определение `sql/GameStreamsTable.kt:7-37`): добавить колонку `val broadcastToken = varchar("broadcast_token", 64).nullable()` после `rtmpKey` (`sql/GameStreamsTable.kt:23`) и UNIQUE индекс в `init {}` (`sql/GameStreamsTable.kt:33-36`).
- **`Utils.kt`** (рядом с `hash()` `Utils.kt:9-12`): добавить генератор токена `generateBroadcastToken(): String` через `SecureRandom` (~32 байта → base64url без паддинга, влезает в `VARCHAR(64)`).
- **`feature/streaming/StreamingRepository.kt`**:
  - в `setStream` (`StreamingRepository.kt:91-116`) — при вставке выставлять `broadcastToken` через `generateBroadcastToken()`, если поле NULL (всегда NULL при insert — генерируем безусловно при создании строки стрима).
  - в `getAdminStreams` (`StreamingRepository.kt:71-89`) — добавить маппинг `row[GameStreamsTable.broadcastToken]?.let { broadcastToken = it }` в `gameStreamAdmin { … }`.
  - в `setStream` (возвращаемый `gameStreamAdmin` `StreamingRepository.kt:106-114`) — вернуть только что сгенерированный `broadcastToken`.
  - новый метод `getCredentialsByKey(tournamentId, table, key): Mafia.BroadcastCredentialsOut?` — валидация по `broadcast_token`, маппинг `rtmpServerUrl`/`rtmpKey`; overlay-поля пока не set (Задача 02).
  - новый метод `rotateToken(tournamentId, streamId): Mafia.GameStreamAdmin` — перезапись `broadcast_token` новым значением, возврат обновлённого `GameStreamAdmin`.
- **`feature/streaming/IStreamingRepository.kt`** (`IStreamingRepository.kt:5-17`): объявить `getCredentialsByKey(...)` и `rotateToken(...)`.
- **`feature/streaming/StreamingApi.kt`**:
  - публичный роут **`GET /api/broadcast/credentials`** (турнирная ветка `?tournamentId=&table=&key=`) ВНЕ `authenticate("auth-jwt")`, по образцу публичного `GET /api/tournament/{id}/streams` (`StreamingApi.kt:21-28`); ошибки 403 (нет/невалидный `key`) и 404 (стол не настроен).
  - admin-роут **`POST /api/admin/tournament/{id}/streams/{streamId}/rotate-token`** внутри `authenticate("auth-jwt")` + `requireOwnership(...)` (`StreamingApi.kt:30-78`).
- **Rate-limit (NFR-1):** установить Ktor `RateLimit` plugin в `Main.kt` (рядом с прочими `install(...)` `Main.kt:124-162`) с именованным конфигом и навесить на публичный `/api/broadcast/credentials`.

### Что НЕ входит
- Клубная ветка `?clubId=&table=&key=`, таблица `club_game_streams`, клубные admin-роуты — **Задача 03**.
- Реальное наполнение `breakPlaceholderImageUrl`/`brandImageUrl`/`overlayDesignKey` — **Задача 02** (здесь всегда возвращаем не-set).
- proto-изменения (`BroadcastCredentialsOut`, `broadcastToken = 8` в `GameStreamAdmin`) — владелец **Задача 00**; здесь только потребляем сгенерированные классы.
- Хостинг AASA — **Задача 04**. Блокировка параллельных операторов — D4, вне scope.

## Технические детали

### Proto (из Задачи 00 — здесь только потребляется)
```proto
message BroadcastCredentialsOut {
  int32 tableNumber = 1;
  string rtmpServerUrl = 2;
  string rtmpKey = 3;
  optional string breakPlaceholderImageUrl = 4;  // null до Задачи 02
  optional string brandImageUrl = 5;             // null до Задачи 02
  optional string overlayDesignKey = 6;          // null до Задачи 02
}
// В существующее GameStreamAdmin (mafia.proto:702-710) добавлено:
//   optional string broadcastToken = 8;
```

### Миграция `V3__broadcast_token.sql`
Стиль зеркалит `V2__club_photo_theme.sql:20-62` (gating через `information_schema`, `PREPARE/EXECUTE/DEALLOCATE`, идемпотентность). Диалект MySQL.
```sql
-- Migration V3: Add broadcast_token column to `game_streams`.
--
-- Per-table broadcast deeplink token (D1): random SecureRandom value, stored
-- per stream row, rotatable. Used by the public /api/broadcast/credentials
-- endpoint to authorize an operator without login. NOT the translation-key.
--
-- Steps:
--   1. Add the `broadcast_token` column (nullable VARCHAR(64)) if absent.
--   2. Add a UNIQUE index on `broadcast_token` (named explicitly so we can
--      detect a previous run via INFORMATION_SCHEMA). NULLs are allowed and
--      not deduplicated by a UNIQUE index in MySQL, so existing rows are safe.
--
-- Each step is idempotent: re-running after a failure performs only the work
-- that wasn't already done.

-- ---------------------------------------------------------------------------
-- Step 1: Add column.
-- ---------------------------------------------------------------------------

SET @has_col = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME   = 'game_streams'
      AND COLUMN_NAME  = 'broadcast_token'
);

SET @stmt_col = IF(
    @has_col = 0,
    'ALTER TABLE game_streams ADD COLUMN broadcast_token VARCHAR(64) NULL',
    'SELECT 1'
);
PREPARE _mig_p FROM @stmt_col;
EXECUTE _mig_p;
DEALLOCATE PREPARE _mig_p;

-- ---------------------------------------------------------------------------
-- Step 2: Add UNIQUE index on broadcast_token.
-- ---------------------------------------------------------------------------

SET @has_idx = (
    SELECT COUNT(*)
    FROM information_schema.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME   = 'game_streams'
      AND INDEX_NAME   = 'uq_game_streams_broadcast_token'
);

SET @stmt_idx = IF(
    @has_idx = 0,
    'ALTER TABLE game_streams
        ADD UNIQUE INDEX uq_game_streams_broadcast_token (broadcast_token)',
    'SELECT 1'
);
PREPARE _mig_p FROM @stmt_idx;
EXECUTE _mig_p;
DEALLOCATE PREPARE _mig_p;
```

### `sql/GameStreamsTable.kt`
Добавить после `rtmpKey` (`sql/GameStreamsTable.kt:23`):
```kotlin
val broadcastToken = varchar("broadcast_token", 64).nullable()
```
И UNIQUE индекс в `init {}` (`sql/GameStreamsTable.kt:33-36`):
```kotlin
init {
    index(false, tournamentId, tableNumber)
    index(false, tournamentId, isActive)
    uniqueIndex("uq_game_streams_broadcast_token", broadcastToken)
}
```
(Имя индекса в `uniqueIndex(...)` обязано совпадать с именем из миграции `V3` — `uq_game_streams_broadcast_token`.)

### `Utils.kt` — генератор токена
Рядом с `hash()` (`Utils.kt:9-12`):
```kotlin
import java.security.SecureRandom
import java.util.Base64

private val secureRandom = SecureRandom()

fun generateBroadcastToken(): String {
    val bytes = ByteArray(32)
    secureRandom.nextBytes(bytes)
    // base64url без паддинга: 32 байта -> 43 символа, влезает в VARCHAR(64)
    return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes)
}
```

### `feature/streaming/IStreamingRepository.kt`
Дополнить интерфейс (`IStreamingRepository.kt:5-17`):
```kotlin
fun getCredentialsByKey(tournamentId: Int, table: Int, key: String): Mafia.BroadcastCredentialsOut?

fun rotateToken(tournamentId: Int, streamId: Int): Mafia.GameStreamAdmin
```

### `feature/streaming/StreamingRepository.kt`
В `setStream` insert-блоке (`StreamingRepository.kt:96-104`) добавить:
```kotlin
it[broadcastToken] = generateBroadcastToken()
```
и в возвращаемом `gameStreamAdmin { … }` (`StreamingRepository.kt:106-114`) — вернуть сгенерированное значение (сохранить его в локальную переменную перед/во время insert и присвоить `this.broadcastToken = token`).

В `getAdminStreams` `gameStreamAdmin { … }` (`StreamingRepository.kt:78-86`) добавить:
```kotlin
row[GameStreamsTable.broadcastToken]?.let { broadcastToken = it }
```

Новые методы (паттерн `transaction { … }` как в существующих, импорт `generated.broadcastCredentialsOut`):
```kotlin
override fun getCredentialsByKey(
    tournamentId: Int,
    table: Int,
    key: String
): Mafia.BroadcastCredentialsOut? = transaction {
    val row = GameStreamsTable.select {
        (GameStreamsTable.tournamentId eq tournamentId) and
            (GameStreamsTable.tableNumber eq table) and
            (GameStreamsTable.broadcastToken eq key)
    }.firstOrNull() ?: return@transaction null  // невалидный key / нет такого стола -> 403 (см. роут)

    val server = row[GameStreamsTable.rtmpServerUrl]
    val streamKey = row[GameStreamsTable.rtmpKey]
    if (server == null || streamKey == null) return@transaction null  // стол не настроен -> 404 (см. роут)

    broadcastCredentialsOut {
        tableNumber = row[GameStreamsTable.tableNumber]
        rtmpServerUrl = server
        rtmpKey = streamKey
        // overlay-поля наполняются в Задаче 02; здесь не выставляются
    }
}

override fun rotateToken(tournamentId: Int, streamId: Int): Mafia.GameStreamAdmin = transaction {
    val row = GameStreamsTable.select {
        (GameStreamsTable.id eq streamId) and (GameStreamsTable.tournamentId eq tournamentId)
    }.firstOrNull() ?: throw NotFoundException("Трансляция не найдена")

    val newToken = generateBroadcastToken()
    GameStreamsTable.update({
        (GameStreamsTable.id eq streamId) and (GameStreamsTable.tournamentId eq tournamentId)
    }) {
        it[broadcastToken] = newToken
    }

    gameStreamAdmin {
        id = streamId
        tableNumber = row[GameStreamsTable.tableNumber]
        row[GameStreamsTable.viewerUrl]?.let { viewerUrl = it }
        row[GameStreamsTable.rtmpServerUrl]?.let { rtmpServerUrl = it }
        row[GameStreamsTable.rtmpKey]?.let { rtmpKey = it }
        active = row[GameStreamsTable.isActive]
        startedAt = row[GameStreamsTable.startedAt].atOffset(ZoneOffset.UTC).toString()
        broadcastToken = newToken
    }
}
```
> Различение 403 vs 404: метод возвращает `null` в обоих случаях (нет валидного токена / стол не настроен). Чтобы роут мог отдать корректный код, **рекомендуется** в роуте сперва проверять наличие строки по `(tournamentId, table, key)` → 403, затем наличие `rtmpServerUrl`/`rtmpKey` → 404. Допустимая альтернатива: репозиторий бросает `ForbiddenException`/`NotFoundException` напрямую (тогда `StatusPages` `Main.kt:124-141` сам отдаст 403/404 с `ErrorOut`), а тип возврата сделать `Mafia.BroadcastCredentialsOut` (не nullable). Финальный выбор — за исполнителем; DoD проверяет только итоговые HTTP-коды.

### `feature/streaming/StreamingApi.kt` — роуты
Публичный роут ВНЕ `authenticate` (рядом с `StreamingApi.kt:21-28`):
```kotlin
route("/api/broadcast/credentials") {
    apiDoc("Получить RTMP-креды стола по токену оператора (без авторизации)")
    get {
        val tournamentId = call.request.queryParameters["tournamentId"]?.toIntOrNull()
            ?: throw BadRequestException("Не указан tournamentId")
        val table = call.request.queryParameters["table"]?.toIntOrNull()
            ?: throw BadRequestException("Не указан номер стола")
        val key = call.request.queryParameters["key"]
        if (key.isNullOrBlank()) {
            throw ForbiddenException("Неверный ключ доступа")  // NFR-5
        }
        val creds = streamingRepository.getCredentialsByKey(tournamentId, table, key)
            ?: throw ForbiddenException("Неверный ключ доступа")  // невалидный токен
        // если стол не настроен (нет rtmp) -> репозиторий вернул null/404; см. примечание о 403/404
        call.respond(creds)
    }
}
```
> Если реализован «двухступенчатый» вариант различения кодов — внутри отдать `ForbiddenException` при отсутствии строки и `NotFoundException("Стол не настроен для трансляции")` при отсутствии RTMP (текст под NFR-5).

Admin-роут ротации — внутри блока `route("/api/admin/tournament/{id}/streams")` (`StreamingApi.kt:31-78`), добавить под `route("/{streamId}")` (`StreamingApi.kt:67-77`) ещё один под-роут или отдельный `route("/{streamId}/rotate-token")`:
```kotlin
route("/{streamId}/rotate-token") {
    apiDoc("Перевыпустить токен оператора для стола (инвалидирует прежнюю ссылку)")
    post {
        val tournamentId = call.requireTournamentId()
        call.requireOwnership(tournamentId)
        val streamId = call.parameters["streamId"]?.toIntOrNull()
            ?: throw BadRequestException("Неверный id трансляции")
        call.respond(streamingRepository.rotateToken(tournamentId, streamId))
    }
}
```
> `requireTournamentId()`/`requireOwnership()` уже определены в этом блоке (`StreamingApi.kt:32-40`) — переиспользуем как есть; ownership через `tournamentOwnersRepository.canManageOwners(...)` (`StreamingApi.kt:37`).

### Rate-limit (NFR-1) в `Main.kt`
Ktor `2.3.12` (`gradle.properties:2`) — плагин `RateLimit` доступен (since 2.2.0). Установить рядом с прочими `install(...)` (`Main.kt:124-162`):
```kotlin
import io.ktor.server.plugins.ratelimit.*
import kotlin.time.Duration.Companion.seconds

install(RateLimit) {
    register(RateLimitName("broadcast-credentials")) {
        rateLimiter(limit = 30, refillPeriod = 60.seconds)
        requestKey { call -> call.request.local.remoteHost }  // ключ по IP
    }
}
```
И обернуть публичный роут: `rateLimit(RateLimitName("broadcast-credentials")) { route("/api/broadcast/credentials") { … } }`.
> Точные числа лимита — ориентир (30 запросов/мин на IP); согласовать при ревью. Зависимость `io.ktor:ktor-server-rate-limit:2.3.12` добавить в `build.gradle`, если её ещё нет (проверить перед сборкой). Проект использует Groovy DSL (в корне `build.gradle`/`settings.gradle`, файла `.kts` нет), поэтому синтаксис — Groovy: `implementation "io.ktor:ktor-server-rate-limit:$ktor_version"` (версия берётся из `gradle.properties:2`, `ktor_version=2.3.12`).

### Маппинг ошибок (уже работает через StatusPages)
`StatusPages` (`Main.kt:124-141`) для любого `HandledInternalException` отдаёт `cause.statusCode` + `Mafia.ErrorOut`. `ForbiddenException` → 403, `NotFoundException` → 404, `BadRequestException` → 400 (`Utils.kt:27-34`). Отдельный обработчик в роуте не нужен — достаточно бросить исключение.

## Definition of Done
- [ ] Файл `src/main/resources/migrations/V3__broadcast_token.sql` создан, применяется `MigrationRunner` на чистой БД (V0→V3) и идемпотентен при повторном запуске (gating через `information_schema`); добавляет колонку `broadcast_token VARCHAR(64) NULL` и UNIQUE индекс `uq_game_streams_broadcast_token`.
- [ ] `sql/GameStreamsTable.kt` содержит `broadcastToken` и `uniqueIndex("uq_game_streams_broadcast_token", broadcastToken)`; имя индекса совпадает с миграцией.
- [ ] `Utils.kt::generateBroadcastToken()` использует `SecureRandom`, выдаёт base64url-строку длиной ≤ 64 символа.
- [ ] При `setStream` новая строка `game_streams` получает непустой уникальный `broadcast_token`; возвращаемый `GameStreamAdmin` содержит `broadcastToken`.
- [ ] `GET /api/admin/tournament/{id}/streams` (`getAdminStreams`) возвращает `broadcastToken` в каждом `GameStreamAdmin` (под JWT+ownership).
- [ ] `GET /api/broadcast/credentials?tournamentId=&table=&key=` доступен БЕЗ авторизации; валидный `key` → 200 + `BroadcastCredentialsOut` с заполненными `tableNumber`/`rtmpServerUrl`/`rtmpKey` (overlay-поля не set).
- [ ] Невалидный или пустой `key` → 403 (`ForbiddenException`, тело `ErrorOut`).
- [ ] Стол без настроенных RTMP-кредов (нет `rtmp_server_url`/`rtmp_key`) → 404 с понятным сообщением (NFR-5).
- [ ] `POST /api/admin/tournament/{id}/streams/{streamId}/rotate-token` под JWT+ownership возвращает `GameStreamAdmin` с НОВЫМ `broadcastToken`; прежний токен после ротации перестаёт проходить на `/api/broadcast/credentials` (получает 403) — проверяемо тестом.
- [ ] Чужой пользователь (без `canManageOwners`) на rotate-token → 403; несуществующий `streamId` → 404.
- [ ] `RateLimit` plugin установлен и навешен на `/api/broadcast/credentials`; зависимость подключена в `build.gradle` (Groovy DSL): `implementation "io.ktor:ktor-server-rate-limit:$ktor_version"`.
- [ ] Изменения proto из Задачи 00 присутствуют в сгенерированных классах (`BroadcastCredentialsOut`, `GameStreamAdmin.broadcastToken`).
- [ ] `./gradlew build` зелёный; `./gradlew test` (скилл `/test`) проходит, включая новые тесты на 200/403/404 и инвалидацию токена ротацией.

## Порядок и зависимости
- **До:** Задача 00 (proto: `BroadcastCredentialsOut`, `GameStreamAdmin.broadcastToken = 8`) должна быть смержена и сгенерирована (агент `proto-sync`), иначе код не скомпилируется.
- **После:** разблокирует клиентский турнирный флоу (резолвер `/broadcast`). Задача 02 дозаполнит overlay-поля в `getCredentialsByKey` (сейчас не set). Задача 03 добавит клубную ветку в тот же эндпоинт и переиспользует методы `generateBroadcastToken`/паттерн `getCredentialsByKey`/`rotateToken`.
- Регистрация модуля уже выполнена: `configureStreaming(assembly.streamingRepository, assembly.tournamentOwnersRepository)` (`Main.kt:211`), репозиторий создаётся в `AppAssembly.kt:169-171`. Новых регистраций в `Main.kt`/`AppAssembly.kt` не требуется (кроме `install(RateLimit)` в `Main.kt`).

## Риски / открытые вопросы
- **Зависимость от Задачи 00 (proto-сабмодуль).** BRD §7 предупреждает о конфликте сабмодуля `seating-generator-proto` при ребейзе. Синхронизировать через агента `proto-sync` до начала работ.
- **Конкретные числа rate-limit** (limit/period, ключ по IP vs по `tournamentId`) — согласовать на ревью. За прокси `remoteHost` может быть IP балансировщика; при необходимости брать `X-Forwarded-For`.
- **403 vs 404 различение** — выбран ли «двухступенчатый» вариант в роуте или исключения из репозитория; на DoD влияют только итоговые коды, но реализацию зафиксировать при ревью.
- **D4 (параллельные операторы)** — бэкенд не блокирует второй publish; зафиксировано как ограничение, ответственность RTMP-сервера.

## Затрагиваемые файлы
| Файл | Действие (создать/изменить) |
|---|---|
| `src/main/resources/migrations/V3__broadcast_token.sql` | создать |
| `src/main/kotlin/sql/GameStreamsTable.kt` | изменить (колонка + uniqueIndex) |
| `src/main/kotlin/Utils.kt` | изменить (`generateBroadcastToken()`) |
| `src/main/kotlin/feature/streaming/IStreamingRepository.kt` | изменить (2 метода) |
| `src/main/kotlin/feature/streaming/StreamingRepository.kt` | изменить (setStream, getAdminStreams, getCredentialsByKey, rotateToken) |
| `src/main/kotlin/feature/streaming/StreamingApi.kt` | изменить (public GET + admin POST rotate-token) |
| `src/main/kotlin/Main.kt` | изменить (`install(RateLimit)`) |
| `build.gradle` | изменить (зависимость ktor-server-rate-limit, Groovy DSL, если отсутствует) |
| `seating-generator-proto/mafia.proto` | потребляется (владелец — Задача 00) |
| тесты `src/test/...` (streaming) | создать/изменить (200/403/404, ротация) |
