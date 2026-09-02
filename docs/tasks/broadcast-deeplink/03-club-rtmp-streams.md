# Задача 03 — Клубные RTMP-стримы (зеркало турнирных)

> Фича: Диплинк-трансляция оператора · Проект: seating-generator-backend · Этап: 3
> Статус: ✅ выполнено (2026-06-19), commit `63c1de3`, build+653 теста зелёные, локально, без push · Зависит от: 00 (proto-контракты) · Разблокирует: клубный флоу оператора (FR-9..FR-12) и клубную ветку эндпоинта кредов

## Контекст
Сейчас клуб умеет только зрительскую трансляцию по translation-key (`feature/club_translation/ClubTranslationApi.kt`), но **не умеет** хранить RTMP server/key по столам — это прямо отмечено в BRD §1 («Клуб **не умеет** вводить RTMP server/key (только ключ для зрителей)»). Задача закрывает FR-9, FR-10, FR-11, FR-12: создаёт зеркало турнирной таблицы `game_streams` на `club_id`, репозиторий и admin-эндпоинты по образцу турнирных, а также расширяет публичный эндпоинт кредов (`GET /api/broadcast/credentials`) клубной веткой `?clubId=&table=&key=`. Это вторая опорная точка для нативного экрана `mafbase_stream` — для столов клуба.

Турнирный аналог (Задача 01) уже задаёт паттерн: per-table broadcast-токен (`SecureRandom`), публичный эндпоинт кредов с проверкой токена (403/404), ротация. Эта задача **переиспользует тот паттерн дословно** на `club_id`.

## Зафиксированные решения
- **D1** (отдельный per-table broadcast-токен, `SecureRandom`, ротируемый, `VARCHAR(64)`, **не** translation-key). Клубная таблица `club_game_streams` содержит собственную колонку `broadcast_token VARCHAR(64) NULL` с `UNIQUE`-индексом. Токен создаётся при `setStream`, если `broadcast_token IS NULL`; ротация перезаписывает значение — старые ссылки сразу инвалидируются (механизм NFR-1). **Не** используется `hash("club$clubId$salt")` из `ClubTranslationApi.kt:42,84` — там translation-key для зрительского контроля, у broadcast-токена другой радиус поражения (право публикации на стол).
- **D3** (переиспользование proto без новых клубных сообщений). Клубный репозиторий возвращает те же `GameStream` / `GameStreamAdmin` / `GetStreamsOut` / `GetStreamsAdminOut` и принимает тот же `SetStreamEvent` (`mafia.proto:693-733`). Эти сообщения **не содержат** `tournamentId`/`clubId` — сущность задаётся роутом (`/api/club/{id}/streams`), поэтому новые клубные сообщения не нужны. Поле `broadcastToken = 8` добавляется в `GameStreamAdmin` в Задаче 00 и переиспользуется здесь как есть.
- **D4** (блокировка параллельных операторов на одном столе — ответственность RTMP-сервера, **вне scope бэкенда**). Зафиксировано как ограничение: бэкенд по одному и тому же `key` отдаёт креды любому числу запросов; ограничение публикации — на стороне RTMP-сервера.
- **D5** (overlay-константа на клиенте). Клубные overlay-поля (`break_placeholder_image_url`, `brand_image_url`) добавляются в таблицу `clubs` в **Задаче 02**, в текущей задаче клубная ветка эндпоинта кредов возвращает их как `null` (до выполнения Задачи 02), `overlayDesignKey` не заполняется.

## Объём работ

### Что делаем
- **Миграция `V5__club_game_streams.sql`** — `CREATE TABLE IF NOT EXISTS club_game_streams` как зеркало `game_streams` (`V0__initial_schema.sql:263-278`), но на `club_id` (FK на `clubs(id)`), **с** колонкой `broadcast_token VARCHAR(64) NULL` + `UNIQUE`-индекс, **без** `vk_owner_id`/`vk_video_id` (VK-автогенерация для клубов вне scope). Стиль идемпотентности — как в существующих миграциях.
- **Exposed-таблица `ClubGameStreamsTable.kt`** в `src/main/kotlin/sql/` — зеркало `sql/GameStreamsTable.kt:7-37`, поле `tournamentId` заменяется на `clubId` (FK на `ClubsTable.id`), добавляется `broadcastToken = varchar("broadcast_token", 64).nullable()`, поля `vkOwnerId`/`vkVideoId` опускаются.
- **Интерфейс `IClubStreamingRepository.kt`** + класс `ClubStreamingRepository.kt` в `src/main/kotlin/feature/club_streaming/` (новый пакет) — методы `getPublicStreams`, `getAdminStreams`, `setStream`, `stopStream`, `getCredentialsByKey`, `rotateToken` по `clubId`. Зеркало `feature/streaming/StreamingRepository.kt:53-217` **без** VK-веток. Возвращают / принимают proto `GameStream`/`GameStreamAdmin`/`SetStreamEvent`/`GetStreamsOut`/`GetStreamsAdminOut` (D3).
- **`configureClubStreaming`** в `src/main/kotlin/feature/club_streaming/ClubStreamingApi.kt` — роуты по образцу `feature/streaming/StreamingApi.kt:16-81`, но ownership через `ClubOwnersRepository.canManageOwners` (`feature/owners/ClubOwnersRepository.kt:20-25`):
  - `GET /api/club/{id}/streams` — public, без auth → `GetStreamsOut` (без секретов, по образцу `StreamingApi.kt:21-28`).
  - `GET /api/admin/club/{id}/streams` — JWT + `canManageOwners` → `GetStreamsAdminOut` (с `broadcastToken`).
  - `PUT /api/admin/club/{id}/streams` — JWT + `canManageOwners`, тело `SetStreamEvent` → `GameStreamAdmin`.
  - `DELETE /api/admin/club/{id}/streams/{streamId}` — JWT + `canManageOwners`.
  - `POST /api/admin/club/{id}/streams/{streamId}/rotate-token` — JWT + `canManageOwners` → `GameStreamAdmin` с новым `broadcastToken`.
- **Расширение эндпоинта кредов (Задача 01)** `GET /api/broadcast/credentials` клубной веткой `?clubId=&table=&key=` — делегирует в `clubStreamingRepository.getCredentialsByKey(clubId, table, key)`; коды ошибок 403/404 как в турнире. Точный паттерн валидации токена (403) и «стол не настроен» (404) — см. Задачу 01; здесь зеркалится.
- **Регистрация**: добавить `clubStreamingRepository` в `AppAssembly.kt` (по образцу `streamingRepository` `AppAssembly.kt:169-171`, но без VK-конфига) и вызвать `configureClubStreaming(...)` в `Main.kt` рядом с `configureClubTranslation` (`Main.kt:214`).

### Что НЕ входит
- **Proto-изменения** — единственный владелец Задача 00. Здесь proto только потребляется. `broadcastToken = 8` в `GameStreamAdmin` приходит из Задачи 00.
- **VK-автогенерация для клубов** — вне scope всей итерации. Метод `startVkStream` и колонки `vk_owner_id`/`vk_video_id` в клубной таблице **не заводятся**.
- **Overlay-поля клуба** (`break_placeholder_image_url`, `brand_image_url` в `clubs`) — **Задача 02**. До неё клубная ветка кредов возвращает overlay-поля как `null`.
- **Сам эндпоинт `GET /api/broadcast/credentials`** (турнирная ветка, базовая структура, rate-limit NFR-1) — создаётся в **Задаче 01**. Здесь только добавляется клубная ветка.
- **Блокировка параллельных операторов** — D4, ответственность RTMP-сервера.

## Технические детали

### Миграция `V5__club_game_streams.sql`
Зеркало `game_streams` (`V0__initial_schema.sql:263-278`) на `club_id`, с `broadcast_token` + `UNIQUE`, без VK-колонок. Идемпотентность через `CREATE TABLE IF NOT EXISTS` (стиль `V1__club_translation.sql:88`):

```sql
-- Migration V5: club_game_streams — зеркало game_streams на club_id.
--
-- Хранит RTMP server/key + per-table broadcast-токен по столам клуба
-- (FR-10, FR-11). VK-колонки (vk_owner_id/vk_video_id) опущены — VK-
-- автогенерация для клубов вне scope. broadcast_token — отдельный
-- per-table токен оператора (SecureRandom), ротируемый; UNIQUE-индекс
-- гарантирует уникальность для резолва кредов по key.
--
-- Идемпотентно: CREATE TABLE IF NOT EXISTS — повторный прогон ничего не делает.

CREATE TABLE IF NOT EXISTS `club_game_streams` (
    `id`              INT          NOT NULL AUTO_INCREMENT,
    `club_id`         INT          NOT NULL,
    `table_number`    INT          NOT NULL,
    `viewer_url`      VARCHAR(512),
    `rtmp_server_url` VARCHAR(512),
    `rtmp_key`        VARCHAR(256),
    `broadcast_token` VARCHAR(64),
    `is_active`       BOOLEAN      NOT NULL DEFAULT TRUE,
    `started_at`      DATETIME     NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `club_game_streams_broadcast_token` (`broadcast_token`),
    INDEX `club_game_streams_club_id_table_number` (`club_id`, `table_number`),
    INDEX `club_game_streams_club_id_is_active`    (`club_id`, `is_active`),
    FOREIGN KEY (`club_id`) REFERENCES `clubs`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
```

> Примечание для ревьюера: в MySQL `UNIQUE`-индекс по nullable-колонке допускает несколько строк с `NULL` — это корректно, т.к. неинициализированные столы имеют `broadcast_token = NULL`, а уникальность нужна только среди реальных токенов.

### Exposed-таблица `ClubGameStreamsTable.kt`
Зеркало `sql/GameStreamsTable.kt:7-37` (`IntIdTable`, `tableName = "club_game_streams"`):

```kotlin
package sql

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.ReferenceOption
import org.jetbrains.exposed.sql.javatime.datetime

object ClubGameStreamsTable : IntIdTable() {
    override val tableName: String
        get() = "club_game_streams"

    val clubId = integer("club_id").references(
        ClubsTable.id,
        onUpdate = ReferenceOption.CASCADE,
        onDelete = ReferenceOption.CASCADE
    )

    val tableNumber = integer("table_number")
    val viewerUrl = varchar("viewer_url", 512).nullable()
    val rtmpServerUrl = varchar("rtmp_server_url", 512).nullable()
    val rtmpKey = varchar("rtmp_key", 256).nullable()
    val broadcastToken = varchar("broadcast_token", 64).nullable()
    val isActive = bool("is_active").default(true)
    val startedAt = datetime("started_at")

    init {
        index(false, clubId, tableNumber)
        index(false, clubId, isActive)
    }
}
```

### Интерфейс `IClubStreamingRepository.kt`
Зеркало `feature/streaming/IStreamingRepository.kt:5-17` без VK / `deactivateExpiredStreams`, плюс broadcast-методы (как в Задаче 01 для турнира):

```kotlin
package feature.club_streaming

import generated.Mafia

interface IClubStreamingRepository {
    fun getPublicStreams(clubId: Int): Mafia.GetStreamsOut
    fun getAdminStreams(clubId: Int): Mafia.GetStreamsAdminOut
    suspend fun setStream(clubId: Int, event: Mafia.SetStreamEvent): Mafia.GameStreamAdmin
    suspend fun stopStream(clubId: Int, streamId: Int)
    fun getCredentialsByKey(clubId: Int, tableNumber: Int, key: String): Mafia.BroadcastCredentialsOut
    fun rotateToken(clubId: Int, streamId: Int): Mafia.GameStreamAdmin
}
```

### `ClubStreamingRepository.kt` — ключевые методы
Зеркало `feature/streaming/StreamingRepository.kt:53-116` на `ClubGameStreamsTable`, **без** VK-веток. Маппинг `getAdminStreams` дополнительно отдаёт `broadcastToken` (поле `8` из Задачи 00):

```kotlin
override fun getAdminStreams(clubId: Int): Mafia.GetStreamsAdminOut = transaction {
    val rows = ClubGameStreamsTable.select { ClubGameStreamsTable.clubId eq clubId }.toList()
    getStreamsAdminOut {
        streams.addAll(rows.map { row ->
            gameStreamAdmin {
                id = row[ClubGameStreamsTable.id].value
                tableNumber = row[ClubGameStreamsTable.tableNumber]
                row[ClubGameStreamsTable.viewerUrl]?.let { viewerUrl = it }
                row[ClubGameStreamsTable.rtmpServerUrl]?.let { rtmpServerUrl = it }
                row[ClubGameStreamsTable.rtmpKey]?.let { rtmpKey = it }
                row[ClubGameStreamsTable.broadcastToken]?.let { broadcastToken = it }
                active = row[ClubGameStreamsTable.isActive]
                startedAt = row[ClubGameStreamsTable.startedAt].atOffset(ZoneOffset.UTC).toString()
            }
        })
    }
}
```

`setStream` — зеркало `StreamingRepository.kt:91-116`, но генерирует `broadcast_token`, если он `NULL` (D1). Генерация токена (~32 байта → base64url, влезает в `VARCHAR(64)`) — общий helper с Задачей 01, например:

```kotlin
private fun generateBroadcastToken(): String {
    val bytes = ByteArray(32)
    SecureRandom().nextBytes(bytes)
    return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes)
}
```

`getCredentialsByKey(clubId, tableNumber, key)` — резолв строки по `(clubId, tableNumber, broadcast_token = key)`:
- токен не найден / не совпадает → `ForbiddenException` (HTTP 403), по образцу проверки ключа `ClubTranslationApi.kt:84` (`key != hash(...) -> Forbidden`);
- строка найдена, но `rtmp_server_url`/`rtmp_key` пустые («стол не настроен») → `NotFoundException` (HTTP 404);
- успех → `BroadcastCredentialsOut` (`mafia.proto`, добавлено в Задаче 00) с `tableNumber`, `rtmpServerUrl`, `rtmpKey`; overlay-поля `null` до Задачи 02.

`rotateToken(clubId, streamId)` — перезаписывает `broadcast_token` новым значением (`UPDATE` по `(id = streamId AND club_id = clubId)`; нет строки → `NotFoundException`), возвращает обновлённый `GameStreamAdmin` с новым `broadcastToken`. Старая ссылка немедленно перестаёт резолвиться (NFR-1).

### `ClubStreamingApi.kt` — роуты
Зеркало `feature/streaming/StreamingApi.kt:16-81`, ownership через `ClubOwnersRepository.canManageOwners` (`ClubOwnersRepository.kt:20`). Сигнатура и структура `requireOwnership` — как в `StreamingApi.kt:35-40`, но с проверкой клуба:

```kotlin
fun Application.configureClubStreaming(
    clubStreamingRepository: IClubStreamingRepository,
    clubOwnersRepository: ClubOwnersRepository
) {
    routing {
        route("/api/club/{id}/streams") {
            apiDoc("Получить публичные RTMP-трансляции клуба")
            get {
                val clubId = call.parameters["id"]?.toIntOrNull()
                    ?: throw BadRequestException("Неверный id клуба")
                call.respond(clubStreamingRepository.getPublicStreams(clubId))
            }
        }

        authenticate("auth-jwt") {
            route("/api/admin/club/{id}/streams") {
                fun ApplicationCall.requireClubId() =
                    parameters["id"]?.toIntOrNull() ?: throw BadRequestException("Неверный id клуба")

                fun ApplicationCall.requireOwnership(clubId: Int) {
                    val userId = getUserId()
                    if (!clubOwnersRepository.canManageOwners(clubId, userId)) {
                        throw ForbiddenException("Нет доступа к управлению трансляциями этого клуба")
                    }
                }

                get { /* getAdminStreams → GetStreamsAdminOut */ }
                put { /* receive SetStreamEvent → setStream → 201 GameStreamAdmin */ }

                route("/{streamId}") {
                    delete { /* stopStream → 200 */ }
                    route("/rotate-token") {
                        post { /* rotateToken → GameStreamAdmin */ }
                    }
                }
            }
        }
    }
}
```

> Перекрёстная ссылка: клубная ветка `GET /api/broadcast/credentials?clubId=&table=&key=` добавляется в обработчик эндпоинта из **Задачи 01** — он по наличию `clubId` vs `tournamentId` в query выбирает `clubStreamingRepository.getCredentialsByKey(...)` или турнирный аналог. Эндпоинт остаётся одним (`/api/broadcast/credentials`), без auth, с rate-limit (NFR-1).

### Регистрация
В `AppAssembly.kt` — рядом с `streamingRepository` (`AppAssembly.kt:169-171`), но без VK-конфига (зеркало `clubOwnersRepository` `AppAssembly.kt:137-139`):

```kotlin
open val clubStreamingRepository: IClubStreamingRepository by lazy {
    ClubStreamingRepository()
}
```

В `Main.kt` — рядом с `configureClubTranslation` (`Main.kt:214`):

```kotlin
configureClubStreaming(assembly.clubStreamingRepository, assembly.clubOwnersRepository)
```

Клубная ветка эндпоинта кредов регистрируется внутри `configureBroadcastCredentials(...)` (Задача 01) — туда передаётся и `clubStreamingRepository`.

## Definition of Done
- [ ] Миграция `src/main/resources/migrations/V5__club_game_streams.sql` создана; на чистой БД создаёт таблицу `club_game_streams` с колонками `id, club_id, table_number, viewer_url, rtmp_server_url, rtmp_key, broadcast_token, is_active, started_at`, `UNIQUE`-индексом по `broadcast_token`, индексами `(club_id, table_number)` и `(club_id, is_active)`, FK на `clubs(id)` `ON DELETE CASCADE`; повторный прогон — no-op (идемпотентность через `IF NOT EXISTS`).
- [ ] В таблице `club_game_streams` **нет** колонок `vk_owner_id`/`vk_video_id` (VK вне scope) и **нет** overlay-полей (они в `clubs`, Задача 02).
- [ ] Создан `sql/ClubGameStreamsTable.kt`, отражающий миграцию 1:1 (имена колонок, типы, nullable, индексы).
- [ ] Создан интерфейс `feature/club_streaming/IClubStreamingRepository.kt` с методами `getPublicStreams/getAdminStreams/setStream/stopStream/getCredentialsByKey/rotateToken` по `clubId`.
- [ ] Создан `feature/club_streaming/ClubStreamingRepository.kt`; методы используют только proto `GameStream`/`GameStreamAdmin`/`SetStreamEvent`/`GetStreamsOut`/`GetStreamsAdminOut`/`BroadcastCredentialsOut` (новых клубных stream-сообщений нет — D3).
- [ ] `getPublicStreams` возвращает `GetStreamsOut` **без** `rtmpServerUrl`/`rtmpKey`/`broadcastToken` (только `id, tableNumber, viewerUrl, active, startedAt`, как `GameStream` в `mafia.proto:693-699`).
- [ ] `getAdminStreams` возвращает `GetStreamsAdminOut` с заполненным `broadcastToken` (поле 8 из Задачи 00) для строк, где токен не `NULL`.
- [ ] `setStream` генерирует `broadcast_token` через `SecureRandom` (~32 байта → base64url), если текущий `NULL`; результат влезает в `VARCHAR(64)`.
- [ ] `rotateToken` перезаписывает `broadcast_token`, и сразу после ротации запрос `GET /api/broadcast/credentials?clubId=&table=&key=<старый_токен>` возвращает 403 (старая ссылка инвалидирована — NFR-1).
- [ ] `GET /api/club/{id}/streams` — без auth, отдаёт публичные стримы клуба без секретов.
- [ ] `GET /api/admin/club/{id}/streams` без валидного JWT → 401; с JWT, но без `canManageOwners` для клуба → 403; с правами владельца клуба → 200 + `GetStreamsAdminOut`.
- [ ] `PUT /api/admin/club/{id}/streams` (тело `SetStreamEvent`) под `canManageOwners` → 201 + `GameStreamAdmin`; запись появляется в `club_game_streams`.
- [ ] `DELETE /api/admin/club/{id}/streams/{streamId}` под `canManageOwners` → 200; стрим помечен `is_active = false`.
- [ ] `POST /api/admin/club/{id}/streams/{streamId}/rotate-token` под `canManageOwners` → 200 + `GameStreamAdmin` с новым `broadcastToken` (отличным от прежнего).
- [ ] `GET /api/broadcast/credentials?clubId=&table=&key=`: невалидный/отсутствующий `key` → 403; валидный `key`, но стол без `rtmp_server_url`/`rtmp_key` → 404; валидный `key` настроенного стола → 200 + `BroadcastCredentialsOut` (`tableNumber`, `rtmpServerUrl`, `rtmpKey`; overlay-поля `null` до Задачи 02).
- [ ] `clubStreamingRepository` зарегистрирован в `AppAssembly.kt` (lazy, без VK-конфига); `configureClubStreaming(assembly.clubStreamingRepository, assembly.clubOwnersRepository)` вызван в `Main.kt`.
- [ ] `./gradlew build` зелёный.

## Порядок и зависимости
- **До**: Задача 00 (proto `BroadcastCredentialsOut` + `GameStreamAdmin.broadcastToken = 8` сгенерированы и закоммичены в сабмодуль `seating-generator-proto`); Задача 01 даёт паттерн broadcast-токена и сам обработчик `GET /api/broadcast/credentials`, в который добавляется клубная ветка (helper генерации токена — общий).
- **Параллельно/после**: Задача 02 добавляет overlay-поля в `clubs` — до неё клубная ветка кредов возвращает их как `null` (DoD это явно допускает).
- **Разблокирует**: клиентскую клубную RTMP-админку (FR-9, FR-12) и клубный флоу оператора (диплинк `…/broadcast?clubId=…&table=…&key=…`).

## Риски / открытые вопросы
- **Конфликт сабмодуля `seating-generator-proto`** при ребейзе (предупреждение BRD §7) — синхронизировать аккуратно; proto-изменения выполняет агент `proto-sync` в Задаче 00, эта задача стартует только после успешной генерации.
- **Уникальность `broadcast_token`** — `UNIQUE`-индекс по nullable-колонке в MySQL разрешает несколько `NULL` (неинициализированные столы) и блокирует дубли реальных токенов; вероятность коллизии 32 случайных байт пренебрежимо мала, ретрай на коллизию `UNIQUE` не требуется, но допустим как defensive-мера.
- **Согласование с Задачей 01** — обработчик `GET /api/broadcast/credentials` единый; нужно, чтобы Задача 01 заложила точку расширения (передача `clubStreamingRepository` и ветвление по `clubId`/`tournamentId`). Если Задача 01 ещё не вмёржена, клубную ветку временно держать в том же PR, что и базовый эндпоинт.
- **D4** — параллельные операторы на одном столе не блокируются бэкендом; убедиться, что это явно отражено в клиентских/эксплуатационных ожиданиях (ответственность RTMP-сервера).

## Затрагиваемые файлы
| Файл | Действие (создать/изменить) |
|---|---|
| `src/main/resources/migrations/V5__club_game_streams.sql` | создать |
| `src/main/kotlin/sql/ClubGameStreamsTable.kt` | создать |
| `src/main/kotlin/feature/club_streaming/IClubStreamingRepository.kt` | создать |
| `src/main/kotlin/feature/club_streaming/ClubStreamingRepository.kt` | создать |
| `src/main/kotlin/feature/club_streaming/ClubStreamingApi.kt` | создать |
| `src/main/kotlin/AppAssembly.kt` | изменить (добавить `clubStreamingRepository`) |
| `src/main/kotlin/Main.kt` | изменить (вызвать `configureClubStreaming`) |
| `src/main/kotlin/feature/broadcast/...` (эндпоинт кредов из Задачи 01) | изменить (добавить клубную ветку `?clubId=`) |
