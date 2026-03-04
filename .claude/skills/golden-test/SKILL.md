---
name: golden-test
description: Create golden (screenshot) tests for a Flutter page widget that uses BlocProvider. Use when the user asks to create golden tests, screenshot tests, or visual regression tests for a page.
disable-model-invocation: true
argument-hint: [page-widget-path]
---

# Golden Test Generator

Create golden tests for the Flutter page at `$ARGUMENTS`.

## Step-by-step process

1. **Read the target page widget** at `$ARGUMENTS` to understand:
   - The Bloc type it depends on (`BlocProvider<XxxBloc>`)
   - The Event and State types used by that bloc
   - Constructor parameters of the page widget
   - What providers the page reads from context (e.g. `MyTheme.of(context)`, `context.locale`)

2. **Read the Bloc class** to understand:
   - The Event sealed class / union
   - The State class and its fields (especially `isLoading`, `hasError`, data fields)

3. **Read the State class** to understand all possible states and their `copyWith` parameters

4. **Read the domain model** if the state holds a model — understand its fields to create realistic test fixtures

5. **Create the golden test file** at `test/golden/<page_name>_golden_test.dart`

## Critical rules — MUST follow

### MockBloc — NOT real Bloc

**NEVER** use real `Bloc` instances in golden tests. Real `Bloc` with `on<>` handlers creates stream subscriptions that cause tests to **hang indefinitely** in Flutter's test Zone.

**ALWAYS** use `MockBloc` from the `bloc_test` package:

```dart
import 'package:bloc_test/bloc_test.dart';

class MockXxxBloc extends MockBloc<XxxEvent, XxxState>
    implements XxxBloc {}
```

Create mock instances with `whenListen`:

```dart
MockXxxBloc _createMockBloc(XxxState state) {
  final bloc = MockXxxBloc();
  whenListen(
    bloc,
    const Stream<XxxState>.empty(),
    initialState: state,
  );
  return bloc;
}
```

### Pumping — use pump(), NOT pumpAndSettle()

**NEVER** use `tester.pumpAndSettle()` — it hangs when widgets contain animations (e.g. `CircularProgressIndicator` in loading states).

**ALWAYS** use explicit pumps:

```dart
await tester.pumpWidget(_buildPage(bloc));
await tester.pump();  // let localizations load
await tester.pump();  // render final frame
```

### Widget wrapper — standard setup

Always wrap the page in the full app context:

```dart
Widget _buildPage(XxxBloc bloc) {
  return Provider<MyTheme>.value(
    value: MyTheme.light(false),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('ru'),
      home: BlocProvider<XxxBloc>.value(
        value: bloc,
        child: const XxxPage(/* required params */),
      ),
    ),
  );
}
```

### Golden file paths

Place golden images in `test/golden/goldens/`:

```dart
matchesGoldenFile('goldens/<page_name>_<state_name>.png')
```

### Test structure

```dart
void main() {
  group('XxxPage golden tests', () {
    testWidgets('<state name>', (tester) async {
      final bloc = _createMockBloc(const XxxState(/* ... */));

      await tester.pumpWidget(_buildPage(bloc));
      await tester.pump();
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/<page_name>_<state>.png'),
      );

      await bloc.close();
    });
  });
}
```

### What states to test

Always create tests for:
- **loading** — `isLoading: true`
- **error** — `isLoading: false, hasError: true`
- **data (full)** — realistic data with all fields populated, lists with 3-5 items
- **data (empty lists)** — if the model has list fields, test with empty lists

### Test data

Create `const` model instances at the top of the file with realistic-looking data. Use Russian names/text since the app locale is `ru`.

## After creating the test

1. Verify the test file compiles and passes: `fvm flutter test <test_path> --update-goldens`
2. Verify the generated golden images look correct by reading the PNG files
3. Ensure `bloc_test` is in `dev_dependencies` in `pubspec.yaml` (add with `fvm flutter pub add --dev bloc_test` if missing)

## Reference example

See `test/golden/player_stats_page_golden_test.dart` for a working example.
