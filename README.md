# Example: Custom Lint Rules in Flutter

A Flutter app that demonstrates **custom lint rules** using the [custom_lint](https://pub.dev/packages/custom_lint) package. The rules enforce API restrictions and project conventions: banning `ScaffoldMessenger` and requiring `RouteSettings` for sheets, dialogs, and navigation.

## Rules

| Rule | Description |
|------|-------------|
| **no_scaffold_messenger** | Bans use of `ScaffoldMessenger` (e.g. `ScaffoldMessenger.of(context).showSnackBar(...)`). |
| **require_route_settings** | Requires `routeSettings` on `showDialog` / `showModalBottomSheet`, and `settings` on `MaterialPageRoute` (and similar) for observability and testing. |

## Setup

From the project root:

```bash
flutter pub get
```

Lints run in the IDE (Dart Analysis Server) or via:

```bash
dart run custom_lint
```

## Examples

- **`lib/example_correct.dart`** — Compliant usage (no violations).
- **`lib/example_violations.dart`** — Intentional violations that trigger the rules.

## Structure

- **`packages/custom_lint_rules/`** — Custom lint plugin: `no_scaffold_messenger` and `require_route_settings` rules.
- **`analysis_options.yaml`** — Enables the `custom_lint` plugin and lists the rules.

Related: *Flutter – Custom Lint: Enforcing API Restrictions and Project Conventions* (Medium article).
