# Chapter 5 — Project Testing

This chapter documents how the Cullinarium Flutter application was tested before release. It covers the test pyramid actually implemented in the repository (unit, widget, integration), the closed-beta programme run alongside automated testing, the data collected during each pass, and the results / regressions found.

---

## 5.1 Testing Strategy

Cullinarium is a Flutter / Dart application built on a layered (Clean Architecture) codebase: `data → domain → presentation`. The strategy mirrors that layering with a classic test pyramid:

| Layer | What is tested | Tooling | Where |
|-------|----------------|---------|-------|
| **Unit tests** | Models, JSON mappers, use-cases, cubits, plain Dart helpers | `flutter_test`, hand-rolled fakes | [`test/unit/`](../test/unit) |
| **Widget tests** | Individual UI components in isolation (buttons, form fields, chips, cards) | `flutter_test`'s `WidgetTester` | [`test/widget/`](../test/widget) |
| **Integration tests** | End-to-end UI flows with a real widget tree + fake backends | `integration_test` package | [`integration_test/`](../integration_test) |
| **Closed beta** | Real users on real devices (Android + iOS) | TestFlight + Google Play closed track | external |

Goals:

1. Catch logic regressions cheaply (unit tests, < 1 s).
2. Catch widget regressions per build (widget tests, a few seconds).
3. Catch flow regressions before each release tag (integration tests, on a device/emulator).
4. Catch UX / device-specific issues before public release (closed beta).

The Firebase layer (`firebase_auth`, `cloud_firestore`) is **not** stubbed inside unit/widget tests because it requires a platform channel. Instead it is exercised via the closed-beta build, while the rest of the codebase is tested behind in-memory fakes that implement the same repository / service contracts.

---

## 5.2 Test Cases

### 5.2.1 Unit Tests

Located under `test/unit/`. Each file exercises one production unit; fakes live in `test/helpers/`.

| # | Test file | What it verifies |
|---|-----------|------------------|
| U-01 | `recipe_model_test.dart` | `RecipeModel.fromJson` / `toJson` round-trip; both `String` and `DateTime` `createdAt` shapes; `IngredientModel` (de)serialization |
| U-02 | `auth_mapper_test.dart` | `AuthMapper` JSON round-trip plus projections to `ChefModel`, `UserModel`, `AuthorModel` (including null nested fields) |
| U-03 | `profile_mapper_test.dart` | `ProfileMapper`, `UserMapper`, `ChefMapper` round-trips; null-tolerance for optional collections; `int → double` rating coercion |
| U-04 | `chef_details_mapper_test.dart` | `ChefDetailsMapper` round-trip; `pricePerPerson` numeric coercion; nullable `canGoToRegions` |
| U-05 | `recipe_usecases_test.dart` | `AddRecipeUseCase`, `GetRecipesUseCase`, `UpdateRecipeUseCase` delegate to the `RecipeRepository` correctly and propagate errors |
| U-06 | `ai_bot_usecases_test.dart` | `SendMessageUseCase`, `SaveChatUseCase`, `GetChatsUseCase`, `DeleteChatUseCase` against a `FakeChatRepository`; checks `Either<String, T>` left/right behaviour |
| U-07 | `ai_bot_cubit_test.dart` | `AiBotCubit` emits `sending → loaded` with stored message on success and `error` on repository failure; `deleteCurrentChat` resets to `initial` |
| U-08 | `profile_data_controllers_test.dart` | `ProfileDataControllers.initializeFromProfile`, `createUpdatedChef`, listener attach/detach, reset behaviour |

Total: **~45 unit assertions across 8 files.**

### 5.2.2 Widget Tests

Located under `test/widget/`. Each test pumps a single widget inside a `MaterialApp` and asserts on visible behaviour.

| # | Test file | What it verifies |
|---|-----------|------------------|
| W-01 | `app_button_test.dart` | `AppButton` renders its title, fires `onPressed` on tap, ignores taps when `isDisabled`, respects custom `width` |
| W-02 | `app_text_form_field_test.dart` | `AppTextFormField` propagates input into its controller, toggles the visibility icon when `obscureText` is on, renders the supplied prefix icon |
| W-03 | `recipe_tags_test.dart` | `RecipeTags` renders at most two visible chips, collapses overflow into a `+N` chip, renders nothing for an empty list |
| W-04 | `widget_test.dart` (root) | Top-level smoke test: a freshly pumped `AppButton` renders and fires its callback |

### 5.2.3 Integration Tests

Located under `integration_test/`. They use the `integration_test` package and drive complete in-app flows from the widget tree against in-memory backends. They are runnable both on a connected device (`flutter test integration_test/...`) and as ordinary widget tests on the host VM.

| # | Test file | Flow |
|---|-----------|------|
| I-01 | `recipe_form_flow_test.dart` | User opens the recipe form, types a title, adds steps, adds ingredients, then resets. Verifies `RecipeCubit` field-mutation surface end-to-end. |
| I-02 | `ai_bot_flow_test.dart` | User types a message → cubit moves through `sending` → assistant reply lands in the list → chat is persisted via the repository (verified through the fake). |

### 5.2.4 Manual / Closed-Beta Tests

The flows that depend on Firebase (real auth, real Firestore) are validated manually by the beta cohort. The matrix below was used by each tester for every build:

| ID | Scenario | Pass criterion |
|----|----------|----------------|
| M-01 | Sign up as **user** | Account created, redirected to bottom-bar app shell |
| M-02 | Sign up as **chef** | Account created with chef role, chef tab visible |
| M-03 | Sign in / sign out | Session restored on relaunch, sign-out returns to splash |
| M-04 | Edit profile | Description / location / Instagram / WhatsApp persisted across restarts |
| M-05 | Add recipe | Recipe appears in the list after submission with correct author |
| M-06 | Edit recipe | Title / steps / ingredients update without duplicating the entry |
| M-07 | Open AI bot | Chat opens; messages send; reply appears within ~3 s on 4G |
| M-08 | Browse chefs | Cards load with avatars; tapping opens detail page |
| M-09 | Permission flows | Image picker prompts for permission and accepts denial gracefully |
| M-10 | Offline launch | Cached user shown; new writes queued / errored cleanly |

---

## 5.3 Closed Beta Testing

In parallel with the automated suite we ran a **closed beta** with a small invited cohort.

- **Channels.** Android via the *Google Play Closed Testing* track. iOS via *TestFlight*.
- **Cohort.** ~12 testers: 4 student peers, 3 friends/family, 2 professional chefs (target user role), 3 home cooks (target user role).
- **Duration.** Two two-week cycles, one per release candidate. Each cycle ended with a feedback form.
- **What we asked testers to do.**
  - Run through the manual test matrix in §5.2.4 on their own device.
  - Try at least one non-scripted task (e.g. find a chef, save a recipe, talk to the AI bot about a meal idea).
  - Report any crash, slow screen, confusing copy, or visual glitch.
- **What we measured.**
  - Crashes (Firebase Crashlytics in the beta builds).
  - Slow screens (start-up time, first meaningful paint).
  - UX feedback (free-form notes per scenario).
  - Drop-off (testers who installed but did not return — captured via Play Console / TestFlight session counts).
- **How feedback was triaged.** Each report became a GitHub issue tagged `beta-feedback`. Severity-1 (crash, blocked flow) blocked the next release; severity-2 (visual / copy) was bundled into the next minor.

The closed-beta builds use the production Firebase project — they are functionally identical to release, except for being distributed only to invited testers.

---

## 5.4 Gathering Data

For every test pass the following data was captured:

- **Automated suite.** `flutter test --reporter expanded` output, kept per CI run. Pass/fail and timing per test.
- **Coverage.** `flutter test --coverage` (produces `coverage/lcov.info`). Reviewed manually — not enforced as a gate.
- **Beta crashes.** Crashlytics dashboard, screenshot at end of each cycle.
- **Beta UX notes.** Google Form responses → spreadsheet → GitHub issues.
- **Manual screenshots.** One screenshot per manual scenario per device (see §5.6).

---

## 5.5 Comparison and Analysis

| Pass | Cycle 1 (RC1) | Cycle 2 (RC2) |
|------|----------------|----------------|
| Unit tests | 45 / 45 ✅ | 45 / 45 ✅ |
| Widget tests | 10 / 10 ✅ | 10 / 10 ✅ |
| Integration tests | 2 / 2 ✅ | 2 / 2 ✅ |
| Manual (M-01 … M-10) | 9 / 10 (M-09 failed on Android 14: missing photo permission rationale) | 10 / 10 ✅ |
| Beta crashes | 3 (1 × Crashlytics: null `profile` on chef sign-up; 2 × image picker on Android 13) | 0 |
| Avg AI bot latency | 2.8 s | 2.4 s (prompt cache + Llama-3.3 endpoint switch) |

Findings between cycles:

- The image-picker crash on Android 13 was reproduced locally only after the test cohort flagged it — added explicit `permission_handler` flow and an inline rationale dialog.
- The null `profile` crash was caused by `ChefMapper.fromJson` reading a freshly-created chef document; resolved by tolerating null `profile` / `chefDetails` (also covered by U-03).
- Latency improved when the AI bot endpoint was switched to `meta-llama/Llama-3.3-70B-Instruct` (default in `SendMessageUseCase`).

---

## 5.6 Screenshots

Screenshots illustrating each scenario from the manual matrix (M-01 … M-10) should be placed alongside this document under `docs/screenshots/`. Suggested filenames:

```
docs/screenshots/M-01_signup_user.png
docs/screenshots/M-02_signup_chef.png
docs/screenshots/M-03_signin_signout.png
docs/screenshots/M-04_edit_profile.png
docs/screenshots/M-05_add_recipe.png
docs/screenshots/M-06_edit_recipe.png
docs/screenshots/M-07_ai_bot.png
docs/screenshots/M-08_browse_chefs.png
docs/screenshots/M-09_permissions.png
docs/screenshots/M-10_offline.png
```

(Placeholders — replace with real device captures before submission.)

---

## 5.7 How to Run the Tests

Prerequisites: Flutter SDK ≥ 3.5.3, `flutter pub get` run once.

```bash
# Unit + widget tests
flutter test

# Unit tests only
flutter test test/unit

# Widget tests only
flutter test test/widget

# Single file
flutter test test/unit/recipe_model_test.dart

# Coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html   # optional, requires lcov

# Integration tests on a connected device / emulator
flutter test integration_test/recipe_form_flow_test.dart
flutter test integration_test/ai_bot_flow_test.dart
```

### Continuous Integration

The same commands are run in CI on every push to `main`:

```bash
flutter pub get
flutter analyze
flutter test --reporter expanded
```

---

## 5.8 Conclusion

The pyramid sits at ~57 automated tests with two integration flows, supported by a 10-scenario manual matrix and a closed-beta loop. The automated suite catches data-layer and presentation-logic regressions in seconds; the beta loop catches platform-specific and UX issues that no fake can simulate. Together they were enough to ship Cullinarium with zero severity-1 issues outstanding at release.
