# Задача 05 — Тесты и верификация

> Фича: Диплинк-трансляция оператора · Проект: seating-generator-backend · Этап: 5
> Статус: на ревью · Зависит от: 00, 01, 02, 03, 04 · Разблокирует: —

## Контекст
Завершающая задача итерации: после реализации proto-контрактов (00), эндпоинта кредов оператора (01), overlay-конфига (02), клубных RTMP-стримов (03) и хостинга AASA (04) необходимо доказать корректность поведения автотестами и зафиксировать чек-лист ручной верификации. Задача закрывает контроль качества по FR-6 (выдача кредов по `key`, невалидный `key` → 403), FR-10/FR-11 (клубные стримы), NFR-1 (ротация `key` инвалидирует старые ссылки; rate-limit), а также проверяет применимость миграций V3-V5 на чистой БД. Тесты пишутся в существующем стиле: API-тесты на mockk + `testMyApplicationV2`, репозиторные — на H2 + `openDatabase(true)`.

## Зафиксированные решения
- **D1** (отдельный per-table broadcast-токен, SecureRandom, ротируемый). Тесты проверяют: валидный токен из БД → 200; чужой/пустой → 403; ротация перезаписывает токен и старое значение перестаёт давать 200. НЕ проверяем сценарий с translation-key hash — он к broadcast-эндпоинту неприменим.
- **D2** (ссылка бессрочная до ротации). Тестов на TTL/одноразовость НЕТ — наличие такого теста = ошибка спецификации. Единственный механизм инвалидации — ротация (NFR-1).
- **D3** (клубные стримы переиспользуют `GameStream`/`GameStreamAdmin`/`SetStreamEvent`/`GetStreamsOut`/`GetStreamsAdminOut`). Клубные API-тесты используют те же proto-билдеры (`gameStreamAdmin`, `setStreamEvent`, `getStreamsAdminOut`), что и турнирные в `StreamingApiTest.kt`.
- **D4** (блокировка параллельных операторов вне scope бэкенда). Тестов на «второй publish» НЕТ — это ответственность RTMP-сервера, зафиксировано как ограничение.
- **D5** (overlay-константа `plashkiMafbase` — на клиенте). Тесты проверяют только, что бэкенд хранит/отдаёт `breakPlaceholderImageUrl` + `brandImageUrl` (+ опц. `overlayDesignKey`); саму константу не тестируем.

## Объём работ
### Что делаем
- **API-тесты broadcast-кредов** — новый класс `feature/broadcast/BroadcastApiTest.kt` (зеркало `src/test/kotlin/feature/streaming/StreamingApiTest.kt:25`), мок репозитория + `createAssembly`-паттерн (`StreamingApiTest.kt:27-35`):
  - валидный `key` (турнир) → 200 + `BroadcastCredentialsOut` с `rtmpServerUrl`/`rtmpKey`/`tableNumber`;
  - невалидный `key` → 403 (паттерн `ClubTranslationApiTest.kt:69` «wrong key returns 403»);
  - отсутствующий `key` → 403 (паттерн `ClubTranslationApiTest.kt:79` «missing key returns 403»);
  - стол без стрима / без rtmp-полей → 404;
  - overlay-поля присутствуют в ответе, когда заданы (после Задачи 02);
  - клубная ветка `?clubId=&table=&key=` → 200 (после Задачи 03).
- **API-тесты ротации токена** (турнир) — в `StreamingApiTest.kt` (расширяем существующий класс): `POST …/streams/{streamId}/rotate-token` для владельца → 200 + `GameStreamAdmin` с заполненным `broadcastToken`; неавторизован → 401; не-владелец → 403 (паттерны `StreamingApiTest.kt:104`, `:112`).
- **API-тест admin-маппинга** — `getAdminStreams` отдаёт `broadcastToken` в `GameStreamAdmin` (расширение теста `StreamingApiTest.kt:76`).
- **API-тесты overlay-настроек** — `PUT /api/admin/tournament/{id}/stream-settings` и `PUT /api/admin/club/{id}/stream-settings` (Задача 02): владелец → 200 + `StreamSettingsOut`; не-владелец → 403; неавторизован → 401.
- **API-тесты клубных стримов** — `feature/broadcast/ClubStreamingApiTest.kt` или расширение существующего набора: public GET, admin GET/PUT/DELETE/rotate-token; ownership через `ClubOwnersRepository.canManageOwners` (паттерн мока — `ClubTranslationApiTest.kt:22-30`, только `canManageOwners` вместо `canViewOwners`).
- **Репозиторные тесты broadcast-токена** — в `repositories/StreamingRepositoryTest.kt` (расширяем; H2 + `openDatabase(true)` + `@TestInstance(PER_METHOD)`, как `StreamingRepositoryTest.kt:28-51`):
  - `setStream` на столе без токена генерирует `broadcast_token` (NOT NULL после вызова, влезает в VARCHAR(64));
  - повторный `setStream` на том же столе НЕ перегенерирует токен (если уже есть) — токен сохраняется;
  - резолв кредов по валидному токену возвращает строку стрима; по неизвестному токену → null/NotFound;
  - ротация перезаписывает `broadcast_token`, старое значение больше не резолвится.
- **Репозиторные тесты клубного репозитория** — новый `repositories/ClubStreamingRepositoryTest.kt` (зеркало `StreamingRepositoryTest.kt`, сущность — `club_id`), с подготовкой клуба через `ClubsTableItem`-аналог (см. `repositories/ClubsRepositoryTest.kt`).
- **Тест миграционной согласованности** — существующий `MigrationSchemaTest.kt:30` (`schema after migration matches exposed definitions`) автоматически покрывает V3-V5: после добавления колонок `broadcast_token`, `break_placeholder_image_url`, `brand_image_url` в Exposed-таблицы и таблицы `ClubGameStreamsTable` он должен оставаться зелёным. Отдельно НЕ дублируем — фиксируем в DoD, что тест проходит.
- **Чек-лист ручной верификации** — curl-примеры (раздел «Технические детали»).

### Что НЕ входит
- Реализация самих эндпоинтов/репозиториев/миграций — Задачи 01-04. Здесь только тесты и верификация.
- Изменение proto — Задача 00.
- Тесты Flutter-клиента (резолвер `/broadcast`, golden-тесты) — вне backend-репозитория.
- Тесты TTL/одноразовости (D2) и параллельных операторов (D4) — не существуют по контракту.
- Нагрузочный/функциональный тест rate-limit (NFR-1) на уровне инфраструктуры — в backend-юнит-тестах не воспроизводим; ротация как механизм инвалидации покрыта репозиторным тестом.

## Технические детали

### Инфраструктура тестов (как есть, переиспользуем)
- API-тесты: `testMyApplicationV2(assembly) { … }` + `createTestClient(userId)` — `src/test/kotlin/TestUtils.kt:28` и `:38`. Клиент без `userId` шлёт запрос без JWT (для public-эндпоинтов и проверки 401); с `userId` — добавляет `Bearer`-токен через `generateToken` (`TestUtils.kt:42`).
- Сборка ассембли с моками — анонимный `object : TestAppAssembly()` с переопределением нужных репозиториев, образец `StreamingApiTest.kt:27-35`. Базовый `TestAppAssembly` — `src/test/kotlin/TestAppAssembly.kt:11`.
- Тело protobuf-запроса: `setBody(<builder>{…}.toByteArray())`; разбор ответа: `Mafia.<Msg>.parseFrom(response.bodyAsChannel().toByteArray())` (`StreamingApiTest.kt:58`) или `response.body<ByteArray>()` (`ClubTranslationApiTest.kt:42`).
- Репозиторные тесты: `openDatabase(true)` поднимает H2 в режиме MySQL и пересоздаёт схему через `SchemaUtils` (`Main.kt:222`, ветка `testing`), подготовка данных через `transaction { … }` и DAO/`insert` (`StreamingRepositoryTest.kt:43-51`, `:55-70`).
- Соль translation-key (`TranslationConfig.keySalt`) и `hash(...)` — для broadcast НЕ используются (D1); упоминаются только чтобы не спутать с клубным translation-key (`ClubTranslationApiTest.kt:32`).

### Эскиз API-теста broadcast-кредов (стиль зеркалит StreamingApiTest.kt)
```kotlin
package feature.broadcast

import TestAppAssembly
import createTestClient
import generated.Mafia
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.util.*
import io.mockk.*
import org.junit.jupiter.api.Test
import testMyApplicationV2
import kotlin.test.assertEquals

internal class BroadcastApiTest {

    private fun createAssembly(repo: IBroadcastRepository = mockk(relaxed = true)) =
        object : TestAppAssembly() {
            override val broadcastRepository = repo   // имя поля сверить с Задачей 01/AppAssembly
        }

    @Test
    fun `credentials - valid token returns 200 with rtmp creds`() {
        val repo = mockk<IBroadcastRepository> {
            every { getCredentials(tournamentId = 5, table = 1, key = "tok123") } returns
                broadcastCredentialsOut {
                    tableNumber = 1
                    rtmpServerUrl = "rtmp://a.rtmp.youtube.com/live2"
                    rtmpKey = "xxxx-yyyy"
                }
        }
        testMyApplicationV2(createAssembly(repo)) {
            val response = createTestClient()
                .get("/api/broadcast/credentials?tournamentId=5&table=1&key=tok123")
            assertEquals(HttpStatusCode.OK, response.status)
            val out = Mafia.BroadcastCredentialsOut.parseFrom(response.bodyAsChannel().toByteArray())
            assertEquals(1, out.tableNumber)
            assertEquals("xxxx-yyyy", out.rtmpKey)
        }
    }

    @Test
    fun `credentials - wrong token returns 403`() {
        testMyApplicationV2(createAssembly()) {
            val response = createTestClient()
                .get("/api/broadcast/credentials?tournamentId=5&table=1&key=wrong")
            assertEquals(HttpStatusCode.Forbidden, response.status)
        }
    }

    @Test
    fun `credentials - missing token returns 403`() {
        testMyApplicationV2(createAssembly()) {
            val response = createTestClient()
                .get("/api/broadcast/credentials?tournamentId=5&table=1")
            assertEquals(HttpStatusCode.Forbidden, response.status)
        }
    }

    @Test
    fun `credentials - table not configured returns 404`() {
        val repo = mockk<IBroadcastRepository> {
            every { getCredentials(any(), any(), any()) } throws NotFoundException("Стол не настроен")
        }
        testMyApplicationV2(createAssembly(repo)) {
            val response = createTestClient()
                .get("/api/broadcast/credentials?tournamentId=5&table=9&key=tok123")
            assertEquals(HttpStatusCode.NotFound, response.status)
        }
    }
}
```
> Точные имена интерфейса репозитория (`IBroadcastRepository`), метода (`getCredentials`) и proto-билдера (`broadcastCredentialsOut`) — взять из реализации Задачи 01; выше — эскиз стиля. Если креды отдаются через расширение `IStreamingRepository`, тест переносится в `StreamingApiTest.kt` без смены паттерна.

### Эскиз теста ротации токена (расширяет StreamingApiTest.kt)
```kotlin
@Test
fun `rotateToken - returns new broadcastToken for owner`() {
    val repo = mockk<IStreamingRepository> {
        coEvery { rotateBroadcastToken(5, 10) } returns gameStreamAdmin {
            id = 10; tableNumber = 1; active = true; broadcastToken = "newTok"
        }
    }
    testMyApplicationV2(createAssembly(repo)) {
        val response = createTestClient(1).post("/api/admin/tournament/5/streams/10/rotate-token")
        assertEquals(HttpStatusCode.OK, response.status)
        val out = Mafia.GameStreamAdmin.parseFrom(response.bodyAsChannel().toByteArray())
        assertEquals("newTok", out.broadcastToken)
        coVerify { repo.rotateBroadcastToken(5, 10) }
    }
}

@Test
fun `rotateToken - non-owner returns 403`() {
    val ownersRepo = mockk<TournamentOwnersRepository> {
        every { canManageOwners(any(), any()) } returns false
    }
    testMyApplicationV2(createAssembly(ownersRepo = ownersRepo)) {
        val response = createTestClient(1).post("/api/admin/tournament/5/streams/10/rotate-token")
        assertEquals(HttpStatusCode.Forbidden, response.status)
    }
}
```

### Эскиз репозиторного теста ротации (H2, зеркало StreamingRepositoryTest.kt)
```kotlin
@Test
fun `rotateBroadcastToken - invalidates previous token`() {
    val created = runBlocking { repository.setStream(tournamentId, setStreamEvent { tableNumber = 1 }) }
    val oldToken = transaction {
        GameStreamsTable.select { GameStreamsTable.id eq created.id }
            .first()[GameStreamsTable.broadcastToken]   // колонка добавляется в Задаче 01
    }
    assertNotNull(oldToken)

    runBlocking { repository.rotateBroadcastToken(tournamentId, created.id) }

    val newToken = transaction {
        GameStreamsTable.select { GameStreamsTable.id eq created.id }
            .first()[GameStreamsTable.broadcastToken]
    }
    assertNotNull(newToken)
    assertNotEquals(oldToken, newToken)
    // старый токен больше не резолвится
    assertThrows<NotFoundException> {
        repository.getCredentials(tournamentId, table = 1, key = oldToken!!)
    }
}
```

### Миграционная проверка
`MigrationSchemaTest.kt:30` сравнивает Exposed-определения (`sqlTables`, `Main.kt`) с состоянием после применения миграций (через H2 + `SchemaUtils`). После Задач 01-03 в Exposed добавятся: `broadcast_token` в `GameStreamsTable.kt` (сейчас `src/main/kotlin/sql/GameStreamsTable.kt:7-37`), `break_placeholder_image_url`/`brand_image_url` в таблицах турниров и клубов, новая таблица `ClubGameStreamsTable`. Если миграции V3-V5 и Exposed-объекты согласованы — `MigrationSchemaTest` остаётся зелёным; рассинхрон выдаст список pending-statements (`MigrationSchemaTest.kt:48-54`). Это и есть автоматическая проверка «миграции применяются на чистой БД». Для боевого MySQL дополнительно — ручной прогон V3-V5 на чистой схеме (curl/SQL-чек-лист ниже).

### Чек-лист ручной верификации (curl)
> Запускать против локально поднятого backend. `$JWT` — токен владельца турнира/клуба; `$KEY` — `broadcast_token` стола из admin-GET. Все запросы protobuf — ниже только проверка кодов ответа (`-i`).
```bash
# 1. Турнир: валидный токен -> 200
curl -i "http://localhost:8080/api/broadcast/credentials?tournamentId=5&table=1&key=$KEY"

# 2. Турнир: невалидный токен -> 403
curl -i "http://localhost:8080/api/broadcast/credentials?tournamentId=5&table=1&key=garbage"

# 3. Турнир: без токена -> 403
curl -i "http://localhost:8080/api/broadcast/credentials?tournamentId=5&table=1"

# 4. Стол без стрима/без rtmp -> 404
curl -i "http://localhost:8080/api/broadcast/credentials?tournamentId=5&table=99&key=$KEY"

# 5. Admin GET streams содержит broadcastToken (proto-ответ -> проверить hexdump/декод)
curl -i -H "Authorization: Bearer $JWT" http://localhost:8080/api/admin/tournament/5/streams

# 6. Ротация токена -> 200, новый broadcastToken; повтор шага 1 со старым $KEY -> 403
curl -i -X POST -H "Authorization: Bearer $JWT" \
  http://localhost:8080/api/admin/tournament/5/streams/10/rotate-token

# 7. Ротация не-владельцем -> 403  (JWT без прав на турнир 5)
curl -i -X POST -H "Authorization: Bearer $OTHER_JWT" \
  http://localhost:8080/api/admin/tournament/5/streams/10/rotate-token

# 8. Overlay-настройки турнира (PUT, тело SetStreamSettingsEvent) -> 200
curl -i -X PUT -H "Authorization: Bearer $JWT" \
  --data-binary @set_stream_settings.bin \
  http://localhost:8080/api/admin/tournament/5/stream-settings

# 9. Клубная ветка кредов -> 200
curl -i "http://localhost:8080/api/broadcast/credentials?clubId=3&table=1&key=$CLUB_KEY"

# 10. Клубный admin GET streams (ownership canManageOwners) -> 200 владелец / 403 чужой
curl -i -H "Authorization: Bearer $JWT" http://localhost:8080/api/admin/club/3/streams

# 11. AASA доступна без auth, Content-Type application/json, без .json в пути
curl -i http://localhost:8080/.well-known/apple-app-site-association
curl -i http://localhost:8080/apple-app-site-association
```

## Definition of Done
- [ ] Написан `feature/broadcast/BroadcastApiTest.kt` (или эквивалент в `StreamingApiTest.kt`) с тестами: валидный токен → 200 + `BroadcastCredentialsOut` (поля `tableNumber`/`rtmpServerUrl`/`rtmpKey`); невалидный токен → 403; пустой/отсутствующий токен → 403; стол без стрима/rtmp → 404; клубная ветка `?clubId=…` → 200.
- [ ] Тест: overlay-поля (`breakPlaceholderImageUrl`/`brandImageUrl`) присутствуют в `BroadcastCredentialsOut`, когда заданы, и отсутствуют (`has…() == false`), когда не заданы.
- [ ] Тесты ротации токена в `StreamingApiTest.kt`: владелец → 200 + непустой `broadcastToken`; не-владелец → 403; неавторизован → 401.
- [ ] Тест admin-маппинга: `getAdminStreams` возвращает `broadcastToken` в `GameStreamAdmin`.
- [ ] Тесты overlay-настроек: `PUT …/tournament/{id}/stream-settings` и `PUT …/club/{id}/stream-settings` — владелец → 200 + `StreamSettingsOut`; не-владелец → 403; неавторизован → 401.
- [ ] Тесты клубных стримов: public GET → 200 без auth; admin GET/PUT/DELETE/rotate-token — владелец (`ClubOwnersRepository.canManageOwners == true`) → 200/201/OK, чужой → 403, без JWT → 401.
- [ ] Репозиторный тест: `setStream` на новом столе создаёт непустой `broadcast_token` (длина ≤ 64); повторный `setStream` на столе с уже выданным токеном НЕ меняет токен.
- [ ] Репозиторный тест ротации: после `rotateBroadcastToken` значение `broadcast_token` изменилось и старый токен не резолвит креды (NotFound/403) — подтверждает NFR-1.
- [ ] Репозиторный тест клубного репозитория (зеркало турнирного) — set/get/rotate по `club_id`.
- [ ] `MigrationSchemaTest` (`schema after migration matches exposed definitions`) зелёный после добавления колонок V3/V4 и таблицы V5 в Exposed — нет pending-statements.
- [ ] Миграции V3-V5 применяются на чистой БД: `./gradlew build` поднимает H2-схему без ошибок; ручной прогон V3-V5 на пустом MySQL без ошибок (чек-лист curl/SQL приложен и пройден).
- [ ] `./gradlew build` зелёный (компиляция + все тесты).
- [ ] Скилл `/test` без фильтра проходит: вывод `Failed: 0 | Errors: 0`, строка «All tests passed».
- [ ] Чек-лист ручной проверки эндпоинтов (curl 1-11 выше) выполнен; для 403/404/200/401 коды совпадают с ожидаемыми; результат зафиксирован в PR.

## Порядок и зависимости
- **До:** реализованы и смержены Задачи 00 (proto + регенерация сабмодуля), 01 (broadcast-эндпоинт + миграция V3 + ротация), 02 (overlay V4), 03 (клубные стримы V5), 04 (AASA). Без них тесты не скомпилируются (нет proto-классов/репозиториев) и curl-чек-лист невыполним.
- **После:** разблокирует финальный merge итерации в `feat/mafbase-stream` и снятие блокера с Flutter-клиента (резолвер `/broadcast`).
- Тесты можно дописывать инкрементально по мере готовности задач (broadcast-тесты после 01, overlay после 02, клубные после 03), но зелёный `./gradlew build` и `/test` — критерий приёмки именно этой задачи целиком.

## Риски / открытые вопросы
- **Имена идентификаторов** (`IBroadcastRepository`/`getCredentials`/`rotateBroadcastToken`/поле в `AppAssembly`/`GameStreamsTable.broadcastToken`/proto-билдер `broadcastCredentialsOut`) фиксируются Задачами 00/01 — при расхождении эскизы тестов подправить под фактические сигнатуры, контракт по кодам ответов (200/403/404/401) не меняется.
- **Ротация → инвалидация** работает только при отсутствии кэша токенов в репозитории; если будет кэш — добавить тест, что кэш сбрасывается при ротации (иначе NFR-1 нарушится).
- **Rate-limit (NFR-1)** на эндпоинт кредов в юнит-тестах не воспроизводится; если он реализуется как Ktor-плагин — добавить отдельный тест на 429 при превышении лимита (зафиксировать в Задаче 01, здесь — упомянуть).
- **MySQL-специфика миграций**: `MigrationSchemaTest` гоняется на H2 и не исполняет MySQL-only синтаксис (`PREPARE/EXECUTE`, backticks) — поэтому ручной прогон V3-V5 на боевом MySQL обязателен (стиль сверять с `V1__club_translation.sql`).
- **H2-файлы между прогонами**: перед `/test` чистить `test_db*.mv.db` и `build/test-results/test` (шаг 1 скилла `/test`), иначе возможны конфликты схемы.

## Затрагиваемые файлы
| Файл | Действие (создать/изменить) |
|---|---|
| `src/test/kotlin/feature/broadcast/BroadcastApiTest.kt` | создать |
| `src/test/kotlin/feature/broadcast/ClubStreamingApiTest.kt` | создать (если клубный API вынесен отдельно) |
| `src/test/kotlin/feature/streaming/StreamingApiTest.kt` | изменить (тесты ротации токена + broadcastToken в admin-маппинге + overlay-настройки) |
| `src/test/kotlin/repositories/StreamingRepositoryTest.kt` | изменить (генерация/неперегенерация/ротация broadcast_token) |
| `src/test/kotlin/repositories/ClubStreamingRepositoryTest.kt` | создать (зеркало турнирного на club_id) |
| `src/test/kotlin/MigrationSchemaTest.kt` | не менять (используется как есть для проверки V3-V5) |
| `docs/tasks/broadcast-deeplink/05-tests-verification.md` | создать (этот файл) |
