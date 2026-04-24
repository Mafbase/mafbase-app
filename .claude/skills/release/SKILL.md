---
name: release
description: Write changelog entry and bump version in pubspec.yaml. Use when the user asks to prepare a release, write changelog, bump version, or update version.
disable-model-invocation: true
argument-hint: [patch|minor|major]
---

# Release — Changelog + Version Bump

Prepare a release by writing a changelog entry and bumping the version in `pubspec.yaml`.

## Step-by-step process

1. **Determine bump type** from `$ARGUMENTS`:
   - `patch` (default if not specified) — bug fixes, small tweaks
   - `minor` — new features, significant UI changes
   - `major` — breaking changes, major redesigns

2. **Read the current version** from `pubspec.yaml` (line starting with `version:`).
   Format: `major.minor.patch+build` (e.g. `2.4.0+54`).

3. **Calculate the new version**:
   - Increment the appropriate segment (major/minor/patch)
   - Reset lower segments to 0 (e.g. minor bump: `2.4.0` → `2.5.0`)
   - Always increment the build number by 1 (e.g. `+54` → `+55`)

4. **Check for UNRELEASED section** in `CHANGELOG.md`:
   - If `## [UNRELEASED]` section exists at the top — use its entries as the base for the changelog
   - Additionally, run `git log --oneline <last_tag_or_last_changelog_version>..HEAD` to check for any user-visible changes not yet captured in UNRELEASED
   - If no UNRELEASED section — analyze changes from git log and changed files as before
   - Focus on **user-visible changes only**

5. **Write the changelog entry** at the top of `CHANGELOG.md`:
   - Replace `## [UNRELEASED]` with `## [new_version] - DD.MM.YYYY` (if UNRELEASED existed)
   - Or create a new section at the top (if no UNRELEASED)
   - Format: `## [new_version] - DD.MM.YYYY`
   - Date format: `DD.MM.YYYY` (e.g. `04.03.2026`)
   - Each item starts with `- ` (dash + space)
   - Use **today's date**

6. **Update the version** in `pubspec.yaml`

## Critical rules — MUST follow

### Changelog content rules (from AGENTS.md)

1. **Only user-visible changes** — features, UI changes, and bug fixes that users can see
2. **Never include internal changes** — CI/CD, refactoring, infrastructure, test changes, code cleanup
3. **Write in user benefit language** — describe what the user gets, not what was implemented

### Language and style

- Write in **Russian**
- Use verbs: "Добавлена", "Исправлена", "Изменена", "Улучшена"
- Be concise — one line per change
- **Maximum 5 items** per release — group minor fixes into one summary line (e.g. "Исправлены ошибки навигации и отображения"), prioritize the most important features
- No technical jargon — "страница статистики игрока" not "PlayerStatsPage"

### Examples

```markdown
## Good:
- Добавлена страница статистики игрока с диаграммой распределения ролей
- Исправлена ошибка отображения рейтинга на мобильных устройствах

## Bad (too technical):
- Добавлен RoleDistributionChart виджет с CustomPaint
- Рефакторинг PlayerStatsPage на CustomState паттерн
- Добавлены golden тесты
```

### Version format

```yaml
# pubspec.yaml
version: 2.5.0+55
#        ^^^^^  ^^
#        semver build
```

## After making changes

1. Verify `CHANGELOG.md` has the new entry at the top
2. Verify `pubspec.yaml` has the updated version
3. Run `fvm flutter analyze` to ensure no errors

## Reference

See `CHANGELOG.md` for existing changelog style and `AGENTS.md` for full changelog rules.