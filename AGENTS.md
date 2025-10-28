# Repository Guidelines

## Project Structure & Module Organization
The repository is intentionally lightweight and keeps all artifacts in the root. Core platform stubs live in `ios_stub.swift` (SwiftUI view and service prototypes) and `kmm_stub.kt` (Kotlin Multiplatform contracts). Product-facing artifacts—`HabitFlow_wireframes.md`, `mid_fidelity_wireframes.md`, and `design_tokens.json`—capture UX intent, while CSV files such as `HabitFlow_prompts_rules.csv` and `analytics_schema_ext.csv` describe data inputs. API expectations are documented in `openapi.yaml`, and `postman_collection.json` provides example requests. When adding new code or specs, group related files in clearly named subdirectories to keep the root navigable.

## Build, Test, and Development Commands
There is no unified build pipeline yet; work within the host platform:
- Run iOS experiments by loading `ios_stub.swift` into an Xcode SwiftUI preview (`xcodebuild -scheme HabitFlowPrototype` once the stub is linked to a project).
- Validate Kotlin changes inside your shared module (`./gradlew :shared:compileKotlin` in the consumer app).
- Lint JSON and CSV assets before committing (`jq . openapi.yaml`, `csvlint HabitFlow_prompts_rules.csv`) to avoid broken pipelines downstream.

## Coding Style & Naming Conventions
Follow platform defaults: two-space indentation for SwiftUI previews and four-space indentation for Kotlin data classes. Keep Swift symbols in UpperCamelCase for types and lowerCamelCase for properties; mirror the same casing in Kotlin. Preserve the existing localized strings and comment markers—several files mix English with Simplified Chinese labels. When introducing configuration or prompt files, prefer kebab-case filenames and document column meanings in an inline header comment.

## Testing Guidelines
Add tests alongside the platform you touch. For Swift, create XCTest cases named `FeatureNameTests` and run them with `xcodebuild test`. For KMM, add tests in `shared/src/commonTest` using Kotlin `@Test` methods named `shouldDoThing_whenCondition`. When updating prompt or analytics CSVs, add a short markdown note describing validation steps in the same commit so reviewers understand data coverage expectations.

## Commit & Pull Request Guidelines
Adopt Conventional Commit prefixes (`feat:`, `fix:`, `docs:`) so downstream automation can generate changelogs. Each pull request should include: a concise summary of changes, any linked product requirement or tracking ticket, screenshots or screen recordings for UI-impacting updates, and a checklist confirming tests or validations ran (build, lint, data checks). Flag any schema or prompt adjustments prominently because they affect coaching models and analytics ingestion.
