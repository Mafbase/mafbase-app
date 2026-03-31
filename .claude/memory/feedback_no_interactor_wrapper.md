---
name: feedback_no_interactor_wrapper
description: Не создавать Interactor если он просто оборачивает вызов repository. Sentry-логирование через BaseInteractor больше не нужно.
type: feedback
---

Если Interactor не содержит дополнительной логики кроме вызова метода repository — не создавать его. Вызывать repository напрямую из BLoC.

**Why:** Пользователь указал что Sentry-логика из BaseInteractor больше не актуальна, и обёртка без логики — лишний код.

**How to apply:** При создании новых фич в seating-generator-web проверять, есть ли у interactor'а дополнительная логика помимо делегирования в repository. Если нет — вызывать repository напрямую из BLoC.
